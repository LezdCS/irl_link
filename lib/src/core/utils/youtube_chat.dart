import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:irllink/src/core/utils/globals.dart' as globals;

class YoutubeChat {
  String videoId;
  
  final StreamController _chatStreamController = StreamController.broadcast();
  Stream get chatStream => _chatStreamController.stream;

  YoutubeChat(
    this.videoId,
  );

  // Function to fetch the initial continuation token
  Future<String?> fetchInitialContinuationToken(String videoId) async {
    var headers = {
      'accept':
          'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7',
      'accept-language': 'en-US,en;q=0.9',
      'cache-control': 'no-cache',
      'pragma': 'no-cache',
      'user-agent':
          'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/123.0.0.0 Safari/537.36'
    };

    final url = 'https://www.youtube.com/live_chat?is_popout=1&v=$videoId';
    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      final document = parser.parse(response.body);
      final scripts = document.getElementsByTagName('script');
      final ytInitialDataScript = scripts
          .firstWhere((script) => script.innerHtml.contains('ytInitialData'));
      final scriptContent = ytInitialDataScript.innerHtml;
      // Extracting ytInitialData JSON from the script tag
      final dataStart = scriptContent.indexOf('{');
      final dataEnd = scriptContent.lastIndexOf('}') + 1;
      final jsonString = scriptContent.substring(dataStart, dataEnd);
      final ytInitialData = json.decode(jsonString);
      globals.talker?.debug(ytInitialData);

      // Extract continuation token from ytInitialData
      final continuation = ytInitialData['contents']['liveChatRenderer']
          ['continuations'][0]['invalidationContinuationData']['continuation'];
      return continuation;
    } catch (error) {
      globals.talker
          ?.error('Error fetching initial continuation token: $error');
      return null;
    }
  }

  Future<String?> fetchChatMessages(String? continuationToken) async {
    final body = json.encode({
      'context': {
        'client': {
          'hl': 'en',
          'gl': 'JP',
          'remoteHost': '123.123.123.123',
          'userAgent':
              'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/123.0.0.0 Safari/537.36',
          'clientName': 'WEB',
          'clientVersion': '2.20240411.09.00',
        },
        'user': {'lockedSafetyMode': false}
      },
      'continuation': continuationToken
    });

    final options = {
      'headers': {'Content-Type': 'application/json'},
    };

    const url =
        'https://www.youtube.com/youtubei/v1/live_chat/get_live_chat?prettyPrint=false';

    try {
      final response = await http.post(Uri.parse(url),
          headers: options['headers'], body: body);
      final data = json.decode(response.body);
      final messages = (data['continuationContents']['liveChatContinuation']
              ['actions'] as List?)
          ?.map((action) => (action['addChatItemAction']['item']
                  ['liveChatTextMessageRenderer']['message']['runs'] as List?)
              ?.map((run) => run['text'])
              .join(''))
          .where((message) => message != null)
          .toList();
      globals.talker?.info("Fetched messages: $messages");
      messages?.forEach((message) {
        _chatStreamController.add(message);
      });

      final newContinuationToken = data['continuationContents']
              ['liveChatContinuation']['continuations'][0]
          ['invalidationContinuationData']['continuation'];
      if (newContinuationToken == null) {
        globals.talker?.info('No continuation token found, terminating.');
        return null;
      }
      return newContinuationToken;
    } catch (error) {
      globals.talker?.error('Error fetching chat messages: $error');
      return continuationToken; // Retry with the same token
    }
  }

  Future<void> startFetchingChat(String videoId) async {
    var continuationToken = await fetchInitialContinuationToken(videoId);
    if (continuationToken == null) {
      globals.talker?.error('Failed to fetch initial continuation token.');
      return;
    }

    while (continuationToken != null) {
      continuationToken = await fetchChatMessages(continuationToken);
      await Future.delayed(const Duration(seconds: 5)); // 5-second pause
    }
  }
}
