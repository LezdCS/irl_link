import 'package:equatable/equatable.dart';

class StreamElementsSettings extends Equatable {
  final bool showFollowerActivity;
  final bool showSubscriberActivity;
  final bool showDonationActivity;
  final bool showCheerActivity;
  final bool showRaidActivity;
  final bool showHostActivity;
  final bool showMerchActivity;
  final String? jwt;
  final String? overlayToken;

  const StreamElementsSettings({
    required this.showFollowerActivity,
    required this.showSubscriberActivity,
    required this.showDonationActivity,
    required this.showCheerActivity,
    required this.showRaidActivity,
    required this.showHostActivity,
    required this.showMerchActivity,
    required this.jwt,
    required this.overlayToken,
  });

  @override
  List<Object?> get props {
    return [
      showFollowerActivity,
      showSubscriberActivity,
      showDonationActivity,
      showCheerActivity,
      showRaidActivity,
      showHostActivity,
      showMerchActivity,
      jwt,
      overlayToken,
    ];
  }

  Map toJson() => {
        'showFollowerActivity': showFollowerActivity,
        'showSubscriberActivity': showSubscriberActivity,
        'showDonationActivity': showDonationActivity,
        'showCheerActivity': showCheerActivity,
        'showRaidActivity': showRaidActivity,
        'showHostActivity': showHostActivity,
        'showMerchActivity': showMerchActivity,
        'jwt': jwt,
        'overlayToken': overlayToken,
      };

  @override
  bool get stringify => true;

  StreamElementsSettings copyWith({
    bool? showFollowerActivity,
    bool? showSubscriberActivity,
    bool? showDonationActivity,
    bool? showCheerActivity,
    bool? showRaidActivity,
    bool? showHostActivity,
    bool? showMerchActivity,
    String? jwt,
    String? overlayToken,
  }) {
    return StreamElementsSettings(
      showFollowerActivity: showFollowerActivity ?? this.showFollowerActivity,
      showSubscriberActivity:
          showSubscriberActivity ?? this.showSubscriberActivity,
      showDonationActivity: showDonationActivity ?? this.showDonationActivity,
      showCheerActivity: showCheerActivity ?? this.showCheerActivity,
      showRaidActivity: showRaidActivity ?? this.showRaidActivity,
      showHostActivity: showHostActivity ?? this.showHostActivity,
      showMerchActivity: showMerchActivity ?? this.showMerchActivity,
      jwt: jwt ?? this.jwt,
      overlayToken: overlayToken ?? this.overlayToken,
    );
  }
}
