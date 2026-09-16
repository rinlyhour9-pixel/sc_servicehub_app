/// Central paths for bundled application assets.
///
/// Keep image files in `assets/images/` and add their paths here before use.
class AppAssets {
  AppAssets._();

  static const String imagesPath = 'assets/images';
  static const String onboardingImagesPath = 'assets/images_onboardingscreen';

  static const String banner1 = '$imagesPath/banner_1.png';
  static const String banner2 = '$imagesPath/banner_2.png';
  static const String banner3 = '$imagesPath/banner_3.png';
  static const String infoBanner = '$imagesPath/info_banner.png';
  static const String profileClient = '$imagesPath/profile_client.jpg';

  static const String onboarding1 = '$onboardingImagesPath/screen_1.png';
  static const String onboarding2 = '$onboardingImagesPath/Screen_2.png';
  static const String onboarding3 = '$onboardingImagesPath/Screen_3.png';

  static const String logoSoftCreative = '$onboardingImagesPath/Logo_softcreative.png';

  static const String categoryIconsPath = 'assets/clientdashbord_icon';
  static const String iconElectrician = '$categoryIconsPath/electric_icon.png';
  static const String iconPlumber = '$categoryIconsPath/plumber_icon.png';
  static const String iconAcRepair = '$categoryIconsPath/ac_icon.png';
  static const String iconTvRepair = '$categoryIconsPath/tv_icon.png';
  static const String iconPainter = '$categoryIconsPath/painter_icon.png';
  static const String iconHomeCleaning = '$categoryIconsPath/homeclean_icon.png';
  static const String iconCookingRange = '$categoryIconsPath/cookingrange_icon.png';
  static const String iconWashingMachine = '$categoryIconsPath/washingmachine_icon.png';
  static const String iconFridgeRepair = '$categoryIconsPath/fridge_icon.png';

  /// Full-bleed hero banners shown at the top of the service detail screen.
  static const String serviceBannersPath = 'assets/service_detail_banner';
  static const String bannerElectrician = '$serviceBannersPath/electronic_banner.png';
  static const String bannerPlumber = '$serviceBannersPath/plumber_banner.png';
  static const String bannerAcRepair = '$serviceBannersPath/acrepair_banner.png';
  static const String bannerTvRepair = '$serviceBannersPath/tvrepair_banner.png';
  static const String bannerPainter = '$serviceBannersPath/painter_banner.png';
  static const String bannerHomeCleaning = '$serviceBannersPath/homecleaning_banner.png';
  static const String bannerCookingRange = '$serviceBannersPath/cookingrange_banner.png';
  static const String bannerWashingMachine = '$serviceBannersPath/washingbanner_banner.png';
  static const String bannerFridgeRepair = '$serviceBannersPath/fridgerepair_banner.png';
}
