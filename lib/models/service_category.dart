import '../core/app_assets.dart';
import '../l10n/app_localizations.dart';

enum ServiceCategoryId {
  electrician,
  plumber,
  acRepair,
  tvRepair,
  painter,
  homeCleaning,
  cookingRange,
  washingMachine,
  fridgeRepair,
}

/// Category name/description/checklist text lives in the ARB files (keyed by
/// [id]) rather than as a plain string here, so it translates with the rest
/// of the app instead of being frozen in whatever language it was written in.
class ServiceCategory {
  final ServiceCategoryId id;
  final String iconAsset;
  final String bannerAsset;

  const ServiceCategory({required this.id, required this.iconAsset, required this.bannerAsset});

  String name(AppLocalizations l10n) => switch (id) {
        ServiceCategoryId.electrician => l10n.categoryElectrician,
        ServiceCategoryId.plumber => l10n.categoryPlumber,
        ServiceCategoryId.acRepair => l10n.categoryAcRepair,
        ServiceCategoryId.tvRepair => l10n.categoryTvRepair,
        ServiceCategoryId.painter => l10n.categoryPainter,
        ServiceCategoryId.homeCleaning => l10n.categoryHomeCleaning,
        ServiceCategoryId.cookingRange => l10n.categoryCookingRange,
        ServiceCategoryId.washingMachine => l10n.categoryWashingMachine,
        ServiceCategoryId.fridgeRepair => l10n.categoryFridgeRepair,
      };

  String description(AppLocalizations l10n) => switch (id) {
        ServiceCategoryId.electrician => l10n.categoryElectricianDesc,
        ServiceCategoryId.plumber => l10n.categoryPlumberDesc,
        ServiceCategoryId.acRepair => l10n.categoryAcRepairDesc,
        ServiceCategoryId.tvRepair => l10n.categoryTvRepairDesc,
        ServiceCategoryId.painter => l10n.categoryPainterDesc,
        ServiceCategoryId.homeCleaning => l10n.categoryHomeCleaningDesc,
        ServiceCategoryId.cookingRange => l10n.categoryCookingRangeDesc,
        ServiceCategoryId.washingMachine => l10n.categoryWashingMachineDesc,
        ServiceCategoryId.fridgeRepair => l10n.categoryFridgeRepairDesc,
      };

  List<String> included(AppLocalizations l10n) => switch (id) {
        ServiceCategoryId.electrician => [
            l10n.includedWiringInspection,
            l10n.includedFixtureInstallation,
            l10n.includedSafetyCheck,
            l10n.performanceItem,
          ],
        ServiceCategoryId.plumber => [
            l10n.includedLeakDetection,
            l10n.includedPipeRepair,
            l10n.includedFixtureInstall,
            l10n.performanceItem,
          ],
        ServiceCategoryId.acRepair => [
            l10n.includedAcInspection,
            l10n.includedGasLevelCheck,
            l10n.includedCleaningMaintenance,
            l10n.performanceItem,
          ],
        ServiceCategoryId.tvRepair => [
            l10n.includedDiagnostics,
            l10n.includedScreenBoardRepair,
            l10n.includedSoftwareCheck,
            l10n.performanceItem,
          ],
        ServiceCategoryId.painter => [
            l10n.includedSurfacePrep,
            l10n.includedPainting,
            l10n.includedCleanup,
            l10n.performanceItem,
          ],
        ServiceCategoryId.homeCleaning => [
            l10n.includedDusting,
            l10n.includedMopping,
            l10n.includedSanitizing,
            l10n.performanceItem,
          ],
        ServiceCategoryId.cookingRange => [
            l10n.includedBurnerCheck,
            l10n.includedIgnitionRepair,
            l10n.includedGasLeakCheck,
            l10n.performanceItem,
          ],
        ServiceCategoryId.washingMachine => [
            l10n.includedDrainageCheck,
            l10n.includedMotorInspection,
            l10n.includedCycleTest,
            l10n.performanceItem,
          ],
        ServiceCategoryId.fridgeRepair => [
            l10n.includedCoolingCheck,
            l10n.includedCompressorTest,
            l10n.includedSealRepair,
            l10n.performanceItem,
          ],
      };

  static const List<ServiceCategory> all = [
    ServiceCategory(
        id: ServiceCategoryId.electrician,
        iconAsset: AppAssets.iconElectrician,
        bannerAsset: AppAssets.bannerElectrician),
    ServiceCategory(
        id: ServiceCategoryId.plumber,
        iconAsset: AppAssets.iconPlumber,
        bannerAsset: AppAssets.bannerPlumber),
    ServiceCategory(
        id: ServiceCategoryId.acRepair,
        iconAsset: AppAssets.iconAcRepair,
        bannerAsset: AppAssets.bannerAcRepair),
    ServiceCategory(
        id: ServiceCategoryId.tvRepair,
        iconAsset: AppAssets.iconTvRepair,
        bannerAsset: AppAssets.bannerTvRepair),
    ServiceCategory(
        id: ServiceCategoryId.painter,
        iconAsset: AppAssets.iconPainter,
        bannerAsset: AppAssets.bannerPainter),
    ServiceCategory(
        id: ServiceCategoryId.homeCleaning,
        iconAsset: AppAssets.iconHomeCleaning,
        bannerAsset: AppAssets.bannerHomeCleaning),
    ServiceCategory(
        id: ServiceCategoryId.cookingRange,
        iconAsset: AppAssets.iconCookingRange,
        bannerAsset: AppAssets.bannerCookingRange),
    ServiceCategory(
        id: ServiceCategoryId.washingMachine,
        iconAsset: AppAssets.iconWashingMachine,
        bannerAsset: AppAssets.bannerWashingMachine),
    ServiceCategory(
        id: ServiceCategoryId.fridgeRepair,
        iconAsset: AppAssets.iconFridgeRepair,
        bannerAsset: AppAssets.bannerFridgeRepair),
  ];
}
