import 'package:equatable/equatable.dart';
import 'package:irllink/src/domain/entities/settings/chat_events_settings.dart';

class Settings extends Equatable {
  //CHAT SETTINGS
  final bool? isEmotes;
  final double? textSize;
  final double? emotesSize;
  final bool? displayTimestamp;
  final bool? alternateChannel;
  final String? alternateChannelName;
  final List? hiddenUsersIds;
  final ChatEventsSettings? chatEventsSettings;

  //GENERAL SETTINGS
  final bool? isDarkMode;
  final bool? keepSpeakerOn;
  final Map? appLanguage;

  //CONNECTIONS SETTINGS
  final bool? isObsConnected;
  final String? obsWebsocketUrl;
  final String? obsWebsocketPassword;
  final String? streamElementsAccessToken;
  final List? browserTabs;
  final List? obsConnectionsHistory;

  //TTS SETTIGS
  final bool? ttsEnabled;
  final String? language;
  final List? prefixsToIgnore;
  final List? prefixsToUseTtsOnly;
  final double? volume;
  final double? pitch;
  final double? rate;
  final Map<String, String>? voice;
  final List? ttsUsersToIgnore;
  final bool? ttsMuteViewerName;

  const Settings({
    //CHAT SETTINGS
    required this.isEmotes,
    required this.textSize,
    required this.emotesSize,
    required this.displayTimestamp,
    required this.alternateChannel,
    required this.alternateChannelName,
    required this.hiddenUsersIds,
    required this.chatEventsSettings,

    //GENERAL SETTINGS
    required this.isDarkMode,
    required this.keepSpeakerOn,
    required this.appLanguage,

    //CONNECTIONS SETTINGS
    required this.isObsConnected,
    required this.obsWebsocketUrl,
    required this.obsWebsocketPassword,
    required this.streamElementsAccessToken,
    required this.browserTabs,
    required this.obsConnectionsHistory,

    //TTS SETTIGS
    required this.ttsEnabled,
    required this.language,
    required this.prefixsToIgnore,
    required this.prefixsToUseTtsOnly,
    required this.volume,
    required this.pitch,
    required this.rate,
    required this.voice,
    required this.ttsUsersToIgnore,
    required this.ttsMuteViewerName,
  });

  Settings.defaultSettings({
    //CHAT SETTINGS
    this.isEmotes = true,
    this.textSize = 19,
    this.emotesSize = 20,
    this.displayTimestamp = false,
    this.alternateChannel = false,
    this.alternateChannelName = "",
    this.hiddenUsersIds = const [],
    this.chatEventsSettings = const ChatEventsSettings(
      firstsMessages: true,
      subscriptions: true,
      bitsDonations: true,
      announcements: true,
      incomingRaids: true,
      redemptions: true,
    ),

    //GENERAL SETTINGS
    this.isDarkMode = true,
    this.keepSpeakerOn = true,
    this.appLanguage = const {"languageCode": "en", "countryCode": "US"},

    //CONNECTIONS SETTINGS
    this.isObsConnected = false,
    this.obsWebsocketUrl = "",
    this.obsWebsocketPassword = "",
    this.streamElementsAccessToken = "",
    this.browserTabs = const [],
    this.obsConnectionsHistory = const [],

    //TTS SETTINGS
    this.ttsEnabled = false,
    this.language = "en-US",
    this.prefixsToIgnore = const [],
    this.prefixsToUseTtsOnly = const [],
    this.volume = 1.0,
    this.pitch = 1.0,
    this.rate = 0.5,
    this.voice = const {"name": "en-us-x-sfg-local", "locale": "en-US"},
    this.ttsUsersToIgnore = const [],
    this.ttsMuteViewerName = false,
  });

  Map toJson() => {
        //CHAT
        'isEmotes': isEmotes,
        'textSize': textSize,
        'emotesSize': emotesSize,
        'displayTimestamp': displayTimestamp,
        'alternateChannel': alternateChannel,
        'alternateChannelName': alternateChannelName,
        'hiddenUsersIds': hiddenUsersIds,
        'chatEventsSettings': chatEventsSettings?.toJson(),
        //GENERAL
        'isDarkMode': isDarkMode,
        'keepSpeakerOn': keepSpeakerOn,
        'appLanguage': appLanguage,
        //CONNECTIONS
        'isObsConnected': isObsConnected,
        'obsWebsocketUrl': obsWebsocketUrl,
        'obsWebsocketPassword': obsWebsocketPassword,
        'streamElementsAccessToken': streamElementsAccessToken,
        'browserTabs': browserTabs,
        'obsConnectionsHistory': obsConnectionsHistory,
        //TTS
        'ttsEnabled': ttsEnabled,
        'language': language,
        'prefixsToIgnore': prefixsToIgnore,
        'prefixsToUseTtsOnly': prefixsToUseTtsOnly,
        'volume': volume,
        'pitch': pitch,
        'rate': rate,
        'voice': voice,
        'ttsUsersToIgnore': ttsUsersToIgnore,
        'ttsMuteViewerName': ttsMuteViewerName,
      };

  @override
  List<Object?> get props {
    return [
      //CHAT
      isEmotes,
      textSize,
      emotesSize,
      displayTimestamp,
      alternateChannel,
      alternateChannelName,
      hiddenUsersIds,
      chatEventsSettings,
      //GENERAL
      isDarkMode,
      keepSpeakerOn,
      appLanguage,
      //CONNECTIONS
      isObsConnected,
      obsWebsocketUrl,
      obsWebsocketPassword,
      streamElementsAccessToken,
      browserTabs,
      obsConnectionsHistory,
      //TTS
      ttsEnabled,
      language,
      prefixsToIgnore,
      prefixsToUseTtsOnly,
      volume,
      pitch,
      rate,
      voice,
      ttsUsersToIgnore,
      ttsMuteViewerName,
    ];
  }

  @override
  bool get stringify => true;

  Settings copyWith({
    //CHAT
    bool? isEmotes,
    double? textSize,
    double? emotesSize,
    bool? displayTimestamp,
    bool? alternateChannel,
    String? alternateChannelName,
    List? hiddenUsersIds,
    ChatEventsSettings? chatEventsSettings,
    //GENERAL
    bool? isDarkMode,
    bool? keepSpeakerOn,
    Map<String, String>? appLanguage,
    //CONNECTIONS
    bool? isObsConnected,
    String? obsWebsocketUrl,
    String? obsWebsocketPassword,
    String? streamElementsAccessToken,
    List? browserTabs,
    List? obsConnectionsHistory,
    //TTS
    bool? ttsEnabled,
    String? language,
    List? prefixsToIgnore,
    List? prefixsToUseTtsOnly,
    double? volume,
    double? pitch,
    double? rate,
    Map<String, String>? voice,
    List? ttsUsersToIgnore,
    bool? ttsMuteViewerName,
  }) =>
      Settings(
        //CHAT
        isEmotes: isEmotes ?? this.isEmotes,
        textSize: textSize ?? this.textSize,
        emotesSize: emotesSize ?? this.emotesSize,
        displayTimestamp: displayTimestamp ?? this.displayTimestamp,
        alternateChannel: alternateChannel ?? this.alternateChannel,
        alternateChannelName: alternateChannelName ?? this.alternateChannelName,
        hiddenUsersIds: hiddenUsersIds ?? this.hiddenUsersIds,
        chatEventsSettings: chatEventsSettings ?? this.chatEventsSettings,
        //GENERAL
        isDarkMode: isDarkMode ?? this.isDarkMode,
        keepSpeakerOn: keepSpeakerOn ?? this.keepSpeakerOn,
        appLanguage: appLanguage ?? this.appLanguage,
        //CONNECTIONS
        isObsConnected: isObsConnected ?? this.isObsConnected,
        obsWebsocketUrl: obsWebsocketUrl ?? this.obsWebsocketUrl,
        obsWebsocketPassword: obsWebsocketPassword ?? this.obsWebsocketPassword,
        streamElementsAccessToken:
            streamElementsAccessToken ?? this.streamElementsAccessToken,
        browserTabs: browserTabs ?? this.browserTabs,
        obsConnectionsHistory:
            obsConnectionsHistory ?? this.obsConnectionsHistory,
        //TTS
        ttsEnabled: ttsEnabled ?? this.ttsEnabled,
        language: language ?? this.language,
        prefixsToIgnore: prefixsToIgnore ?? this.prefixsToIgnore,
        prefixsToUseTtsOnly: prefixsToUseTtsOnly ?? this.prefixsToUseTtsOnly,
        volume: volume ?? this.volume,
        pitch: pitch ?? this.pitch,
        rate: rate ?? this.rate,
        voice: voice ?? this.voice,
        ttsUsersToIgnore: ttsUsersToIgnore ?? this.ttsUsersToIgnore,
        ttsMuteViewerName: ttsMuteViewerName ?? this.ttsMuteViewerName,
      );
}
