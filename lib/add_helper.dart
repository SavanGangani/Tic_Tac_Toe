import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdHelper {

  late RewardedAd _rewardedAd;
  static BannerAd myBanner = BannerAd(
    adUnitId: 'ca-app-pub-9595685189565837/7512090442',
    size: AdSize.banner,
    request: AdRequest(),
    listener: BannerAdListener(),
  );

  static BannerAd myBanner1 = BannerAd(
      size: AdSize.banner,
      adUnitId: 'ca-app-pub-9595685189565837/4411833124',
      listener: BannerAdListener(),
      request: AdRequest());

  void loadRewardeAd(){
    RewardedAd.load(
        adUnitId: 'ca-app-pub-3940256099942544/5224354917',
        request: AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
            onAdLoaded: (ad){
              this._rewardedAd = ad;
            },
            onAdFailedToLoad: (LoadAdError error){
              // loadRewardeAd();
            }));
  }

   void showRewardeAd(){
     _rewardedAd.fullScreenContentCallback = FullScreenContentCallback(
       onAdShowedFullScreenContent: (RewardedAd ad) =>
           print('$ad onAdShowedFullScreenContent.'),
       onAdDismissedFullScreenContent: (RewardedAd ad) {
         print('$ad onAdDismissedFullScreenContent.');
         ad.dispose();
       },
       onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
         print('$ad onAdFailedToShowFullScreenContent: $error');
         ad.dispose();
       },
       onAdImpression: (RewardedAd ad) => print('$ad impression occurred.'),
     );
   _rewardedAd.fullScreenContentCallback = FullScreenContentCallback(
     onAdShowedFullScreenContent: (RewardedAd ad){
       print("AD IS SHOW");
     },
     onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error){
       ad.dispose();
     },
   );
  }
}
