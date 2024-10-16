// import 'package:google_mobile_ads/google_mobile_ads.dart';

// class RewardedAdManager {
//   RewardedAd? _rewardedAd;

//   void loadRewardedAd() {
//     RewardedAd.load(
//       adUnitId: 'ca-app-pub-2860004172284225/5015473864',
//       request: AdRequest(),
//       rewardedAdLoadCallback: RewardedAdLoadCallback(
//         onAdLoaded: (RewardedAd ad) {
//           _rewardedAd = ad;
//           print('Rewarded ad loaded.');
//         },
//         onAdFailedToLoad: (LoadAdError error) {
//           print('Rewarded ad failed to load: $error');
//         },
//       ),
//     );
//   }

//   void showRewardedAd(Function onRewarded) {
//     if (_rewardedAd != null) {
//       _rewardedAd!.show(
//         onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
//           onRewarded(); // Call the function to give the reward
//         },
//       );
//       _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
//         onAdDismissedFullScreenContent: (RewardedAd ad) {
//           ad.dispose();
//           loadRewardedAd(); // Load a new ad after the old one is dismissed
//         },
//         onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
//           ad.dispose();
//         },
//       );
//     } else {
//       print('Rewarded ad is not ready yet.');
//     }
//   }
// }
