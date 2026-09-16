// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Khmer Central Khmer (`km`).
class AppLocalizationsKm extends AppLocalizations {
  AppLocalizationsKm([String locale = 'km']) : super(locale);

  @override
  String get appTagline => 'ផ្ទះរបស់អ្នក ជួសជុលលឿន';

  @override
  String get roleClient => 'អតិថិជន';

  @override
  String get roleTechnician => 'ជាងបច្ចេកទេស';

  @override
  String get roleAdmin => 'អ្នកគ្រប់គ្រង';

  @override
  String get onboarding1Title => 'ស្វែងរកអ្នកជំនាញដែលអាចទុកចិត្តបាន';

  @override
  String get onboarding1Desc =>
      'ស្វែងរកអ្នកជំនាញ និងអាចទុកចិត្តបានបំផុតដើម្បីជួយអ្នក';

  @override
  String get onboarding2Title => 'កំណត់ពេលតាមបែបរបស់អ្នក';

  @override
  String get onboarding2Desc =>
      'កំណត់ពេលសេវាកម្មរបស់អ្នកតាមពេលវេលាដ៏ល្អឥតខ្ចោះ';

  @override
  String get onboarding3Title => 'នៅភ្ជាប់ទំនាក់ទំនង';

  @override
  String get onboarding3Desc =>
      'ជជែក ឬហៅទូរស័ព្ទទៅកាន់អ្នកជំនាញរបស់អ្នក ដើម្បីព្រមព្រៀងលម្អិត';

  @override
  String get skip => 'រំលង';

  @override
  String get next => 'បន្ទាប់';

  @override
  String get getStarted => 'ចាប់ផ្ដើម';

  @override
  String get loginWelcomeTitle => 'សូមស្វាគមន៍ការត្រឡប់មកវិញ';

  @override
  String get loginWelcomeSubtitle =>
      'ចូលគណនីដើម្បីគ្រប់គ្រងសេវាកម្មផ្ទះរបស់អ្នកយ៉ាងងាយស្រួល។';

  @override
  String get loginTechnicianTitle => 'ចូលគណនីជាងបច្ចេកទេស';

  @override
  String get loginTechnicianSubtitle =>
      'ចូលគណនីដើម្បីមើល និងគ្រប់គ្រងការងារដែលបានចាត់តាំង។';

  @override
  String get loginAdminTitle => 'ចូលគណនីអ្នកគ្រប់គ្រង';

  @override
  String get loginAdminSubtitle =>
      'ចូលគណនីដើម្បីគ្រប់គ្រងការកក់ ជាងបច្ចេកទេស និងអតិថិជន។';

  @override
  String get phoneNumber => 'លេខទូរស័ព្ទ';

  @override
  String get phoneNumberHint => '+855 12 345 678';

  @override
  String get password => 'ពាក្យសម្ងាត់';

  @override
  String get passwordHintSignIn => 'បញ្ចូលពាក្យសម្ងាត់របស់អ្នក';

  @override
  String get passwordHintSignUp => 'បង្កើតពាក្យសម្ងាត់';

  @override
  String get rememberMe => 'ចងចាំខ្ញុំ';

  @override
  String get forgotPassword => 'ភ្លេចពាក្យសម្ងាត់?';

  @override
  String get signIn => 'ចូលគណនី';

  @override
  String get or => 'ឬ';

  @override
  String get newToApp => 'ថ្មីនៅ Soft Creative? ';

  @override
  String get createAnAccount => 'បង្កើតគណនី';

  @override
  String get signUpTitle => 'បង្កើតគណនី';

  @override
  String get signUpSubtitle =>
      'បង្កើតគណនីរបស់អ្នក ហើយកក់សេវាកម្មអ្នកជំនាញដែលអាចទុកចិត្តបាន។';

  @override
  String get fullName => 'ឈ្មោះពេញ';

  @override
  String get fullNameHint => 'បញ្ចូលឈ្មោះពេញរបស់អ្នក';

  @override
  String get signUpTerms =>
      'ដោយបង្កើតគណនី អ្នកយល់ព្រមតាមលក្ខខណ្ឌប្រើប្រាស់ និងគោលការណ៍ភាពឯកជនរបស់យើង។';

  @override
  String get createAccount => 'បង្កើតគណនី';

  @override
  String get alreadyHaveAccount => 'មានគណនីរួចហើយ? ចូលគណនី';

  @override
  String get forgotPasswordTitle => 'ភ្លេចពាក្យសម្ងាត់?';

  @override
  String get forgotPasswordSubtitle =>
      'បញ្ចូលលេខទូរស័ព្ទរបស់អ្នក ហើយយើងនឹងផ្ញើការណែនាំដើម្បីកំណត់ពាក្យសម្ងាត់ឡើងវិញ។';

  @override
  String get sendResetLink => 'ផ្ញើតំណភ្ជាប់កំណត់ឡើងវិញ';

  @override
  String get checkYourPhone => 'ពិនិត្យទូរស័ព្ទរបស់អ្នក';

  @override
  String resetInstructionsSent(String phone) {
    return 'យើងបានផ្ញើការណែនាំកំណត់ពាក្យសម្ងាត់ឡើងវិញតាម SMS ទៅកាន់\n$phone';
  }

  @override
  String get backToSignIn => 'ត្រឡប់ទៅចូលគណនី';

  @override
  String get navHome => 'ទំព័រដើម';

  @override
  String get navBooking => 'ការកក់';

  @override
  String get navUpdates => 'ការជូនដំណឹង';

  @override
  String get navProfile => 'គណនី';

  @override
  String get greetingSubtitleClient => 'អរុណសួស្តី សូមរីករាយថ្ងៃនេះ';

  @override
  String get servicesTitle => 'សេវាកម្ម';

  @override
  String servicesAvailable(int count) {
    return '$count សេវាកម្ម';
  }

  @override
  String get myProfileTitle => 'គណនីរបស់ខ្ញុំ';

  @override
  String get myProfileSubtitle => 'គ្រប់គ្រងគណនី និងការកំណត់ហាងរបស់អ្នក';

  @override
  String get accountSettings => 'ការកំណត់គណនី';

  @override
  String get settingsInformation => 'ព័ត៌មាន';

  @override
  String get settingsInformationSubtitle =>
      'គ្រប់គ្រងព័ត៌មាន និងអាសយដ្ឋានរបស់អ្នក';

  @override
  String get settingsLanguage => 'ភាសា';

  @override
  String get settingsContactSupport => 'ទាក់ទងផ្នែកជំនួយ';

  @override
  String get settingsContactSupportSubtitle => 'សេវាកម្មជំនួយរបស់យើងបម្រើ ២៤/៧';

  @override
  String get settingsTermsPolicy => 'លក្ខខណ្ឌ និងគោលការណ៍';

  @override
  String get settingsTermsPolicySubtitle => 'មើលលក្ខខណ្ឌ និងគោលការណ៍របស់យើង';

  @override
  String get logOut => 'ចាកចេញ';

  @override
  String get logOutSubtitle => 'ចាកចេញពីគណនីរបស់អ្នក';

  @override
  String get logOutConfirmTitle => 'ចាកចេញ?';

  @override
  String get logOutConfirmBody =>
      'អ្នកនឹងត្រូវចូលគណនីម្តងទៀត ដើម្បីចូលប្រើការកក់របស់អ្នក។';

  @override
  String get cancel => 'បោះបង់';

  @override
  String get chooseLanguage => 'ជ្រើសរើសភាសា';

  @override
  String get validatorPhoneInvalid => 'សូមបញ្ចូលលេខទូរស័ព្ទដែលត្រឹមត្រូវ។';

  @override
  String get validatorPasswordMinLength => 'ត្រូវការយ៉ាងតិច ៦ តួអក្សរ។';

  @override
  String get validatorNameRequired => 'សូមបញ្ចូលឈ្មោះរបស់អ្នក។';

  @override
  String get statusPending => 'រង់ចាំ';

  @override
  String get statusInProgress => 'កំពុងដំណើរការ';

  @override
  String get statusComplete => 'បញ្ចប់';

  @override
  String get statusCompleted => 'បានបញ្ចប់';

  @override
  String get statusAssigned => 'បានចាត់តាំង';

  @override
  String get statusAccepted => 'បានទទួលយក';

  @override
  String get statusCancelled => 'បានលុបចោល';

  @override
  String get statusOnline => 'កំពុងអនឡាញ';

  @override
  String get statusOffline => 'ក្រៅបណ្តាញ';

  @override
  String get statusUnassigned => 'មិនទាន់ចាត់តាំង';

  @override
  String get filterAll => 'ទាំងអស់';

  @override
  String get filterUnread => 'មិនទាន់អាន';

  @override
  String get filterImportant => 'សំខាន់';

  @override
  String get viewAll => 'មើលទាំងអស់';

  @override
  String get takeTask => 'ទទួលការងារ';

  @override
  String get addPhoto => 'បន្ថែមរូបភាព';

  @override
  String get startTimeLabel => 'ពេលចាប់ផ្តើម';

  @override
  String get endTimeLabel => 'ពេលបញ្ចប់';

  @override
  String get totalLabel => 'សរុប';

  @override
  String get noTasksAssignedRightNow =>
      'មិនទាន់មានការងារត្រូវបានចាត់តាំងទេឥឡូវនេះ';

  @override
  String get notificationHeaderTitle => 'ការជូនដំណឹង';

  @override
  String get unableOpenMap => 'មិនអាចបើកកម្មវិធីផែនទីបានទេ។';

  @override
  String get labelAddress => 'អាសយដ្ឋាន';

  @override
  String get labelService => 'សេវាកម្ម';

  @override
  String get labelDescription => 'ការពិពណ៌នា';

  @override
  String get performanceItem => 'ដំណើរការ';

  @override
  String get callAction => 'ហៅទូរស័ព្ទ';

  @override
  String get bookingIdLabel => 'លេខកក់';

  @override
  String get thisMonth => 'ខែនេះ';

  @override
  String get needAction => 'ត្រូវការសកម្មភាព';

  @override
  String get ongoing => 'កំពុងបន្ត';

  @override
  String get technicianAssignedLabel => 'បានចាត់តាំងជាងបច្ចេកទេស';

  @override
  String get addClientTitle => 'បន្ថែមអតិថិជន';

  @override
  String get customerNameLabel => 'ឈ្មោះអតិថិជន';

  @override
  String get enterFullNameHint => 'បញ្ចូលឈ្មោះពេញ';

  @override
  String get idLabel => 'អត្តលេខ';

  @override
  String get idNumberHint => 'លេខអត្តសញ្ញាណប័ណ្ណ';

  @override
  String get genderLabel => 'ភេទ';

  @override
  String get genderMale => 'ប្រុស';

  @override
  String get genderFemale => 'ស្រី';

  @override
  String get genderOther => 'ផ្សេងទៀត';

  @override
  String get skillLabel => 'ជំនាញ';

  @override
  String get skillHint => 'ឧ. ជួសជុលម៉ាស៊ីនត្រជាក់ ប្រព័ន្ធទឹក';

  @override
  String get saveCustomer => 'រក្សាទុកអតិថិជន';

  @override
  String get totalBookingTitle => 'ការកក់សរុប';

  @override
  String bookingsCountSuffix(int count) {
    return '$count ការកក់';
  }

  @override
  String get customersTitle => 'អតិថិជន';

  @override
  String get customerProfileTitle => 'ប្រវត្តិរូបអតិថិជន';

  @override
  String serviceHistoryCount(int count) {
    return 'ប្រវត្តិសេវាកម្ម ($count)';
  }

  @override
  String get listCustomerLabel => 'បញ្ជីអតិថិជន';

  @override
  String get invoiceLabel => 'វិក្កយបត្រ';

  @override
  String get listTechnicianLabel => 'បញ្ជីជាងបច្ចេកទេស';

  @override
  String get personLabel => 'នាក់';

  @override
  String get newBookingRequestTitle => 'សំណើកក់ថ្មី';

  @override
  String get newBookingRequestMsg =>
      'John Smith បានស្នើសុំសេវាកម្មជួសជុលម៉ាស៊ីនត្រជាក់';

  @override
  String get technicianAssignedActivityMsg =>
      'Sok Dara ត្រូវបានចាត់តាំងទៅលេខកក់ #BK240520001';

  @override
  String get serviceCompletedTitle => 'សេវាកម្មបានបញ្ចប់';

  @override
  String get serviceCompletedMsg =>
      'ការជួសជុលទូរទស្សន៍បានបញ្ចប់សម្រាប់ Mary Janeeeee';

  @override
  String get adminGreetingSubtitle => 'អរុណសួស្តី សូមរីករាយថ្ងៃនេះ';

  @override
  String get adminDashboardTitle => 'ផ្ទាំងគ្រប់គ្រង';

  @override
  String get todaysScheduleTitle => 'កាលវិភាគថ្ងៃនេះ';

  @override
  String get noJobsScheduled => 'មិនមានការងារកំណត់ពេលទេ';

  @override
  String get recentActivityTitle => 'សកម្មភាពថ្មីៗ';

  @override
  String get adminNotifNewBookingMsg =>
      'John Smith បានស្នើសុំសេវាកម្មជួសជុលម៉ាស៊ីនត្រជាក់';

  @override
  String get adminNotifTechAssignedMsg =>
      'Sokun Theryouk ត្រូវបានចាត់តាំងទៅលេខកក់ #BK240S21001';

  @override
  String get adminNotifServiceCompletedMsg =>
      'ជាងបច្ចេកទេសបានបញ្ចប់សេវាកម្មសម្រាប់លេខកក់ #BK240620098';

  @override
  String get techniciansTitle => 'ជាងបច្ចេកទេស';

  @override
  String get technicianProfileTitle => 'ប្រវត្តិរូបជាងបច្ចេកទេស';

  @override
  String get topProBadge => 'អ្នកជំនាញកំពូល';

  @override
  String get monthlyLabel => 'ប្រចាំខែ';

  @override
  String get oneServiceLabel => '១ សេវាកម្ម';

  @override
  String get skillsExpertiseTitle => 'ជំនាញ និងភាពជំនាញ';

  @override
  String get availabilityTitle => 'ពេលវេលាទំនេរ';

  @override
  String jobsCountSuffix(int count) {
    return '$count ការងារ';
  }

  @override
  String get noJobsForFilter => 'មិនមានការងារសម្រាប់តម្រងនេះទេ';

  @override
  String get bookingReceivedStep => 'បានទទួលការកក់';

  @override
  String get repairInProgressStep => 'កំពុងជួសជុល';

  @override
  String get serviceCompleteStep => 'សេវាកម្មបានបញ្ចប់';

  @override
  String get assignTechnicianTitle => 'ចាត់តាំងជាងបច្ចេកទេស';

  @override
  String get trackBookingTitle => 'តាមដានការកក់';

  @override
  String get statusProcessTitle => 'ដំណើរការស្ថានភាព';

  @override
  String get technicianInformationTitle => 'ព័ត៌មានជាងបច្ចេកទេស';

  @override
  String get serviceRepairReportTitle => 'របាយការណ៍ជួសជុលសេវាកម្ម';

  @override
  String get addNoteOptionalHint => 'បន្ថែមកំណត់ចំណាំ (ស្រេចចិត្ត)';

  @override
  String get confirmButton => 'បញ្ជាក់';

  @override
  String get noTechnicianAssignedYet =>
      'មិនទាន់មានជាងបច្ចេកទេសត្រូវបានចាត់តាំងទេ';

  @override
  String get skillPrefixLabel => 'ជំនាញ៖ ';

  @override
  String get assignedTasksTitle => 'ការងារបានចាត់តាំង';

  @override
  String get completeJobTitle => 'បញ្ចប់ការងារ';

  @override
  String get customerPhotosAfterLabel => 'រូបភាពអតិថិជន (បន្ទាប់ពីធ្វើរួច)';

  @override
  String get workDescriptionLabel => 'ការពិពណ៌នាការងារ';

  @override
  String get summarizeWorkHint => 'សរុបសេចក្តីអំពីការងារដែលអ្នកបានបញ្ចប់...';

  @override
  String get workDurationLabel => 'រយៈពេលធ្វើការ';

  @override
  String get submitReportButton => 'ដាក់ស្នើរបាយការណ៍';

  @override
  String get reportSubmittedMsg =>
      'របាយការណ៍ត្រូវបានដាក់ស្នើ។ ការងារបានកំណត់ថាបានបញ្ចប់។';

  @override
  String get completedJobsTitle => 'ការងារបានបញ្ចប់';

  @override
  String get noCompletedJobsYet => 'មិនទាន់មានការងារបានបញ្ចប់ទេ';

  @override
  String completedPrefixTemplate(String date, String duration) {
    return 'បានបញ្ចប់ $date • $duration';
  }

  @override
  String get listTaskLabel => 'បញ្ជីការងារ';

  @override
  String get assignedAllCaps => 'បានចាត់តាំង';

  @override
  String get completedAllCaps => 'បានបញ្ចប់';

  @override
  String get technicianGreetingSubtitle =>
      'ត្រៀមខ្លួនដើម្បីជួសជុល និងធ្វើឱ្យអតិថិជនរីករាយ';

  @override
  String get todayTaskTitle => 'ការងារថ្ងៃនេះ';

  @override
  String get taskAssignByAdminTitle => 'ការងារបានចាត់តាំងដោយអ្នកគ្រប់គ្រង';

  @override
  String get jobDetailTitle => 'ព័ត៌មានលម្អិតការងារ';

  @override
  String get bookingIdAllCaps => 'លេខកក់';

  @override
  String bookedOnPrefix(String date) {
    return 'បានកក់នៅ $date';
  }

  @override
  String get dateTimeLabel => 'កាលបរិច្ឆេទ និងម៉ោង';

  @override
  String get viewLocationButton => 'មើលទីតាំង';

  @override
  String get problemDescriptionLabel => 'ការពិពណ៌នាបញ្ហា';

  @override
  String get customerPhotosLabel => 'រូបភាពអតិថិជន';

  @override
  String get startJobButton => 'ចាប់ផ្តើមការងារ';

  @override
  String get customerInformationLabel => 'ព័ត៌មានអតិថិជន';

  @override
  String get serviceInformationLabel => 'ព័ត៌មានសេវាកម្ម';

  @override
  String get jobInProgressTitle => 'ការងារកំពុងដំណើរការ';

  @override
  String get activeServiceLabel => 'សេវាកម្មសកម្ម';

  @override
  String get startedAtSuffix => ' • បានចាប់ផ្តើមនៅ ';

  @override
  String get workNotesDetailLabel => 'ព័ត៌មានលម្អិតកំណត់ចំណាំការងារ';

  @override
  String get addNoteCurrentWorkHint =>
      'បន្ថែមកំណត់ចំណាំអំពីការងារបច្ចុប្បន្ន...';

  @override
  String get uploadProgressPhotosLabel => 'បញ្ចូលរូបភាពដំណើរការ';

  @override
  String get jobReportTitle => 'របាយការណ៍ការងារ';

  @override
  String completedOnPrefix(String date) {
    return 'បានបញ្ចប់នៅ $date';
  }

  @override
  String get noWorkDescriptionProvided =>
      'មិនមានការពិពណ៌នាការងារត្រូវបានផ្តល់ឱ្យទេ។';

  @override
  String allCountTemplate(int count) {
    return 'ទាំងអស់ ($count)';
  }

  @override
  String assignedCountTemplate(int count) {
    return 'បានចាត់តាំង ($count)';
  }

  @override
  String completedCountTemplate(int count) {
    return 'បានបញ្ចប់ ($count)';
  }

  @override
  String get noTasksYet => 'មិនទាន់មានការងារទេ';

  @override
  String get reminderTitle => 'ការរំលឹក';

  @override
  String get jobTomorrowMsg => 'អ្នកមានការងារនៅថ្ងៃស្អែក ម៉ោង ១០:០០ ព្រឹក។';

  @override
  String get newJobAssignedTitle => 'ការងារថ្មីត្រូវបានចាត់តាំង';

  @override
  String get newJobAssignedMsg =>
      'ការកក់ #BK240521001 ត្រូវបានចាត់តាំងទៅឱ្យអ្នក។ កំណត់ពេលនៅម៉ោង ០៣:០០ រសៀល។';

  @override
  String get bookingRequestSendTitle => 'សំណើកក់ត្រូវបានផ្ញើ';

  @override
  String get bookingReceivedBody =>
      'យើងបានទទួលសំណើរបស់អ្នកហើយ។\nក្រុមការងាររបស់យើងនឹងចាត់តាំងជាងបច្ចេកទេសក្នុងពេលឆាប់ៗនេះ';

  @override
  String get viewMyBookingButton => 'មើលការកក់របស់ខ្ញុំ';

  @override
  String get bookingDetailTitle => 'ព័ត៌មានលម្អិតការកក់';

  @override
  String get serviceSuffix => ' សេវាកម្ម';

  @override
  String get bookingIdPrefix => 'លេខកក់ ៖ ';

  @override
  String get dateLabel => 'កាលបរិច្ឆេទ';

  @override
  String get timeLabel => 'ម៉ោង';

  @override
  String get photoLabel => 'រូបភាព';

  @override
  String photosCountSuffix(int count) {
    return '$count រូបភាព';
  }

  @override
  String get assignedTechnicianLabel => 'ជាងបច្ចេកទេសដែលបានចាត់តាំង';

  @override
  String get bookingStatusTitle => 'ស្ថានភាពការកក់';

  @override
  String get payAfterServiceNote =>
      'អ្នកអាចបង់ប្រាក់បន្ទាប់ពីសេវាកម្មបានបញ្ចប់';

  @override
  String get selectDateTitle => 'ជ្រើសរើសកាលបរិច្ឆេទ';

  @override
  String get selectServiceDateHelpText => 'ជ្រើសរើសកាលបរិច្ឆេទសេវាកម្ម';

  @override
  String get weekdayMon => 'ចន្ទ';

  @override
  String get weekdayTue => 'អង្គារ';

  @override
  String get weekdayWed => 'ពុធ';

  @override
  String get weekdayThu => 'ព្រហស្បតិ៍';

  @override
  String get weekdayFri => 'សុក្រ';

  @override
  String get weekdaySat => 'សៅរ៍';

  @override
  String get weekdaySun => 'អាទិត្យ';

  @override
  String get selectTimeTitle => 'ជ្រើសរើសម៉ោង';

  @override
  String selectedTimePrefix(String time) {
    return 'ម៉ោងបានជ្រើសរើស៖ $time';
  }

  @override
  String get serviceAddressTitle => 'អាសយដ្ឋានសេវាកម្ម';

  @override
  String get homeLabel => 'ផ្ទះ';

  @override
  String get pinnedPrefix => 'បានចំណាំ៖ ';

  @override
  String get mapLabel => 'ផែនទី';

  @override
  String get describeIssueHint => 'ពិពណ៌នាបញ្ហាដែលអ្នកកំពុងជួប...';

  @override
  String get uploadPhotoTitle => 'បញ្ចូលរូបភាព';

  @override
  String get bookingNowButton => 'កក់ឥឡូវនេះ';

  @override
  String get previousDatesTooltip => 'កាលបរិច្ឆេទមុន';

  @override
  String get nextDatesTooltip => 'កាលបរិច្ឆេទបន្ទាប់';

  @override
  String get previousTimeTooltip => 'ម៉ោងមុន';

  @override
  String get nextTimeTooltip => 'ម៉ោងបន្ទាប់';

  @override
  String get bookingConfirmedStep => 'ការកក់បានបញ្ជាក់';

  @override
  String get serviceInProcessStep => 'សេវាកម្មកំពុងដំណើរការ';

  @override
  String get noDescriptionProvided => 'មិនមានការពិពណ៌នាត្រូវបានផ្តល់ឱ្យទេ។';

  @override
  String get chooseLocationTitle => 'ជ្រើសរើសទីតាំង';

  @override
  String get pinnedLocationLabel => 'ទីតាំងបានចំណាំ';

  @override
  String get confirmLocationButton => 'បញ្ជាក់ទីតាំង';

  @override
  String get myBookingTitle => 'ការកក់របស់ខ្ញុំ';

  @override
  String get viewServiceBookingSubtitle => 'មើលការកក់សេវាកម្មរបស់អ្នក';

  @override
  String get upcomingTab => 'នាពេលខាងមុខ';

  @override
  String get historyTab => 'ប្រវត្តិ';

  @override
  String get upcomingBookingsTitle => 'ការកក់នាពេលខាងមុខ';

  @override
  String get pastBookingsTitle => 'ការកក់កន្លងមក';

  @override
  String get noBookingsYet => 'មិនទាន់មានការកក់ទេ';

  @override
  String get todayLabel => 'ថ្ងៃនេះ';

  @override
  String get yesterdayLabel => 'ម្សិលមិញ';

  @override
  String get notificationSubtitle =>
      'ទទួលបានព័ត៌មានថ្មីអំពីសកម្មភាពសេវាកម្មរបស់អ្នក';

  @override
  String get viewBookingButton => 'មើលការកក់';

  @override
  String get notifTechnicianArrivedTitle => 'ជាងបច្ចេកទេសបានមកដល់';

  @override
  String get notifTechnicianAssignedMsg =>
      'SK Therayuk បានទទួលយកការកក់ជួសជុលម៉ាស៊ីនត្រជាក់របស់អ្នក';

  @override
  String get notifTechnicianArrivedMsg => 'SK Therayuk បានមកដល់ទីតាំងរបស់អ្នក';

  @override
  String get notifServiceCompleteMsg =>
      'សេវាកម្មជួសជុលទូរទស្សន៍របស់អ្នកបានបញ្ចប់ហើយ';

  @override
  String get informationSavedMsg => 'ព័ត៌មានត្រូវបានរក្សាទុក';

  @override
  String get yourInformationTitle => 'ព័ត៌មានរបស់អ្នក';

  @override
  String get nameLabel => 'ឈ្មោះ';

  @override
  String get tellUsHint => 'ប្រាប់យើងបន្តិចអំពីខ្លួនអ្នក...';

  @override
  String get saveButton => 'រក្សាទុក';

  @override
  String couldNotOpenMsg(String uri) {
    return 'មិនអាចបើក $uri បានទេ';
  }

  @override
  String get howCanWeHelp => 'តើយើងអាចជួយអ្នកយ៉ាងដូចម្តេច?';

  @override
  String get chatWithUsTitle => 'ជជែកជាមួយយើង';

  @override
  String get chatWithUsSubtitle =>
      'និយាយជាមួយក្រុមជំនួយរបស់យើងក្នុងពេលវេលាជាក់ស្តែង';

  @override
  String get emailSupportTitle => 'ជំនួយតាមអ៊ីមែល';

  @override
  String get emailSupportSubtitle => 'ផ្ញើអ៊ីមែលមកយើង ហើយយើងនឹងឆ្លើយតបវិញឆាប់ៗ';

  @override
  String get callUsTitle => 'ហៅមកយើង';

  @override
  String get callUsSubtitle => 'និយាយដោយផ្ទាល់ជាមួយក្រុមជំនួយរបស់យើង';

  @override
  String get faqsTitle => 'សំណួរញឹកញាប់';

  @override
  String get faqsSubtitle => 'ស្វែងរកចម្លើយចំពោះសំណួរទូទៅ';

  @override
  String get contactUsTitle => 'ទាក់ទងយើង';

  @override
  String get ourAddressLabel => 'អាសយដ្ឋានរបស់យើង';

  @override
  String get websiteLabel => 'គេហទំព័រ';

  @override
  String get facebookLabel => 'ហ្វេសប៊ុក';

  @override
  String get frequentlyAskedQuestions => 'សំណួរដែលសួរញឹកញាប់';

  @override
  String get faqQ1 => 'តើខ្ញុំកក់សេវាកម្មម្តងម្កាលដោយរបៀបណា?';

  @override
  String get faqA1 =>
      'ជ្រើសរើសប្រភេទសេវាកម្មពីទំព័រដើម ជ្រើសរើសពេលវេលា ហើយបញ្ជាក់អាសយដ្ឋានរបស់អ្នក។';

  @override
  String get faqQ2 => 'តើខ្ញុំលុបចោលការកក់ដោយរបៀបណា?';

  @override
  String get faqA2 =>
      'បើកការកក់ពី \"ការកក់របស់ខ្ញុំ\" ហើយចុច \"លុបចោល\" មុនពេលជាងបច្ចេកទេសត្រូវបានចាត់តាំង។';

  @override
  String get faqQ3 => 'តើមានវិធីបង់ប្រាក់អ្វីខ្លះដែលគាំទ្រ?';

  @override
  String get faqA3 =>
      'សាច់ប្រាក់នៅពេលបញ្ចប់សេវាកម្ម ជាមួយនឹងជម្រើសបង់ប្រាក់អនឡាញនឹងមកដល់ឆាប់ៗនេះ។';

  @override
  String get termsSection1Title => 'ការប្រើប្រាស់ Soft Creative';

  @override
  String get termsSection1Body =>
      'Soft Creative ភ្ជាប់អ្នកជាមួយជាងបច្ចេកទេសសេវាកម្មផ្ទះឯករាជ្យសម្រាប់ការងារអគ្គិសនី ប្រព័ន្ធទឹក ឧបករណ៍ និងសម្អាត។ ដោយបង្កើតគណនី អ្នកយល់ព្រមផ្តល់ព័ត៌មានកក់ត្រឹមត្រូវ និងអាចទាក់ទងបានតាមលេខទូរស័ព្ទដែលបានចុះឈ្មោះ ដើម្បីឱ្យជាងបច្ចេកទេសអាចបញ្ចប់ការងារ។';

  @override
  String get termsSection2Title => 'ការកក់ និងការលុបចោល';

  @override
  String get termsSection2Body =>
      'ការកក់មួយត្រូវបានបញ្ជាក់នៅពេលជាងបច្ចេកទេសយល់ព្រម។ អ្នកអាចលុបចោលដោយឥតគិតថ្លៃមុនពេលជាងបច្ចេកទេសត្រូវបានចាត់តាំង។ ការលុបចោលបន្ទាប់ពីចាត់តាំងអាចមានថ្លៃសេវាតូចមួយសម្រាប់ការធ្វើដំណើររបស់ជាងបច្ចេកទេស។';

  @override
  String get termsSection3Title => 'ការទូទាត់ប្រាក់';

  @override
  String get termsSection3Body =>
      'ថ្លៃសេវាកម្មនឹងបង្ហាញមុនពេលអ្នកបញ្ជាក់ការកក់ ហើយត្រូវបង់ទៅជាងបច្ចេកទេសនៅពេលបញ្ចប់ការងារ។ Soft Creative មិនរក្សាទុកព័ត៌មានប័ណ្ណទូទាត់របស់អ្នកទេ។';

  @override
  String get termsSection4Title => 'ការប្រព្រឹត្តរបស់ជាងបច្ចេកទេស';

  @override
  String get termsSection4Body =>
      'ជាងបច្ចេកទេសនៅលើ Soft Creative ត្រូវបានពិនិត្យផ្ទៀងផ្ទាត់ និងត្រូវមកដល់ទាន់ពេលវេលា ថែរក្សាផ្ទះរបស់អ្នកដោយប្រុងប្រយ័ត្ន ហើយធ្វើតែការងារដែលអ្នកបានកក់ប៉ុណ្ណោះ។ សូមរាយការណ៍បញ្ហាណាមួយពីទំព័រព័ត៌មានលម្អិតការកក់ ហើយក្រុមជំនួយរបស់យើងនឹងតាមដាន។';

  @override
  String get termsSection5Title => 'ភាពឯកជនរបស់អ្នក';

  @override
  String get termsSection5Body =>
      'យើងប្រមូលឈ្មោះ លេខទូរស័ព្ទ និងអាសយដ្ឋានរបស់អ្នកតែសម្រាប់កំណត់ពេល និងផ្តល់សេវាកម្មប៉ុណ្ណោះ។ យើងមិនដែលលក់ព័ត៌មានផ្ទាល់ខ្លួនរបស់អ្នកទៅភាគីទីបីឡើយ។ អ្នកអាចស្នើសុំលុបគណនីនៅពេលណាក៏បានពី \"ទាក់ទងផ្នែកជំនួយ\"។';

  @override
  String get termsSection6Title => 'ការផ្លាស់ប្តូរលក្ខខណ្ឌទាំងនេះ';

  @override
  String get termsSection6Body =>
      'យើងអាចធ្វើបច្ចុប្បន្នភាពលក្ខខណ្ឌទាំងនេះនៅពេល Soft Creative បន្ថែមមុខងារថ្មី។ ការបន្តប្រើប្រាស់កម្មវិធីបន្ទាប់ពីការធ្វើបច្ចុប្បន្នភាព មានន័យថាអ្នកយល់ព្រមតាមលក្ខខណ្ឌដែលបានកែប្រែ។';

  @override
  String get lastUpdatedLabel => 'បានធ្វើបច្ចុប្បន្នភាពចុងក្រោយ៖ កញ្ញា ២០២៦';

  @override
  String get serviceDetailsTitle => 'ព័ត៌មានលម្អិតសេវាកម្ម';

  @override
  String get verifiedProsSubtitle =>
      'អ្នកជំនាញដែលបានផ្ទៀងផ្ទាត់ • ឆ្លើយតបក្នុងរយៈពេលប្រហែល ៣០ នាទី';

  @override
  String get startingFromLabel => 'ចាប់ផ្តើមពី';

  @override
  String get whatsIncludedTitle => 'អ្វីដែលរួមបញ្ចូល';

  @override
  String get bookThisServiceButton => 'កក់សេវាកម្មនេះ';

  @override
  String get sharedFromAppMsg => 'បានចែករំលែកពីកម្មវិធី Soft Creative';

  @override
  String get notificationsTooltip => 'ការជូនដំណឹង';

  @override
  String serviceIdPrefix(String id) {
    return 'លេខសេវាកម្ម៖ $id';
  }

  @override
  String get categoryElectrician => 'ជាងអគ្គិសនី';

  @override
  String get categoryElectricianDesc =>
      'ជាងអគ្គិសនីមានបទពិសោធន៍សម្រាប់ខ្សែភ្លើង ការដំឡើងឧបករណ៍ និងការត្រួតពិនិត្យសុវត្ថិភាព ធ្វើឱ្យបានត្រឹមត្រូវតាំងពីលើកទីមួយ។';

  @override
  String get categoryPlumber => 'ជាងទឹក';

  @override
  String get categoryPlumberDesc =>
      'ការជួសជុល និងតម្លើងប្រព័ន្ធទឹកដ៏អាចទុកចិត្តបានសម្រាប់ការលេចធ្លាយ ការស្ទះ និងគ្រឿងបន្លាស់នៅជុំវិញផ្ទះរបស់អ្នក។';

  @override
  String get categoryAcRepair => 'ជួសជុលម៉ាស៊ីនត្រជាក់';

  @override
  String get categoryAcRepairDesc =>
      'ទទួលបទពិសោធន៍សេវាកម្មម៉ាស៊ីនត្រជាក់ដ៏អាចទុកចិត្តបានជាមួយក្រុមជាងបច្ចេកទេសដ៏ជំនាញរបស់យើង។ យើងឯកទេសខាងតម្លើង ជួសជុល សម្អាតស៊ីជម្រៅ បញ្ចូលហ្គាស ស្វែងរកបញ្ហា និងថែទាំជាប្រចាំ។ ដោយប្រើឧបករណ៍ទំនើប និងគ្រឿងបន្លាស់គុណភាព យើងធានាថាប្រព័ន្ធត្រជាក់របស់អ្នកផ្តល់នូវផាសុកភាពអតិបរមា ប្រសិទ្ធភាពថាមពល និងដំណើរការយូរអង្វែងពេញមួយឆ្នាំ។';

  @override
  String get categoryTvRepair => 'ជួសជុលទូរទស្សន៍';

  @override
  String get categoryTvRepairDesc =>
      'បញ្ហាអេក្រង់ សំឡេង និងថាមពលត្រូវបានធ្វើរោគវិនិច្ឆ័យ និងជួសជុលដោយជាងបច្ចេកទេសដែលមានវិញ្ញាបនបត្រ។';

  @override
  String get categoryPainter => 'ជាងលាបថ្នាំ';

  @override
  String get categoryPainterDesc =>
      'ការលាបថ្នាំខាងក្នុង និងខាងក្រៅជាមួយការរៀបចំស្អាត និងលទ្ធផលចុងក្រោយប្រកបដោយគុណភាព។';

  @override
  String get categoryHomeCleaning => 'សម្អាតផ្ទះ';

  @override
  String get categoryHomeCleaningDesc =>
      'សម្អាតស៊ីជម្រៅគ្រប់បន្ទប់ ដោយប្រើផលិតផលដែលមានសុវត្ថិភាព និងមានប្រសិទ្ធភាព។';

  @override
  String get categoryCookingRange => 'ជួសជុលចង្ក្រានចម្អិនអាហារ';

  @override
  String get categoryCookingRangeDesc =>
      'ការជួសជុលចង្ក្រានហ្គាស និងអគ្គិសនី ភ្លើងឆេះ និងប្រព័ន្ធបញ្ឆេះ។';

  @override
  String get categoryWashingMachine => 'ជួសជុលម៉ាស៊ីនបោកគក់';

  @override
  String get categoryWashingMachineDesc =>
      'ការជួសជុលបញ្ហាបង្ហូរទឹក ការបង្វិល និងម៉ូទ័រសម្រាប់គ្រប់ម៉ាកធំៗ។';

  @override
  String get categoryFridgeRepair => 'ជួសជុលទូទឹកកក';

  @override
  String get categoryFridgeRepairDesc =>
      'ការជួសជុលភាពត្រជាក់ ឧបករណ៍បង្ហាប់ និងជ័របិទជិត ដើម្បីរក្សាទូទឹកកករបស់អ្នកដំណើរការល្អ។';

  @override
  String get includedWiringInspection => 'ត្រួតពិនិត្យខ្សែភ្លើង';

  @override
  String get includedFixtureInstallation => 'ការដំឡើងឧបករណ៍';

  @override
  String get includedSafetyCheck => 'ត្រួតពិនិត្យសុវត្ថិភាព';

  @override
  String get includedLeakDetection => 'រកឃើញការលេចធ្លាយ';

  @override
  String get includedPipeRepair => 'ជួសជុលបំពង់ទឹក';

  @override
  String get includedFixtureInstall => 'ដំឡើងគ្រឿងបន្លាស់';

  @override
  String get includedAcInspection => 'ត្រួតពិនិត្យម៉ាស៊ីនត្រជាក់';

  @override
  String get includedGasLevelCheck => 'ត្រួតពិនិត្យកម្រិតហ្គាស';

  @override
  String get includedCleaningMaintenance => 'សម្អាត និងថែទាំ';

  @override
  String get includedDiagnostics => 'រោគវិនិច្ឆ័យ';

  @override
  String get includedScreenBoardRepair => 'ជួសជុលអេក្រង់/បន្ទះសៀគ្វី';

  @override
  String get includedSoftwareCheck => 'ត្រួតពិនិត្យកម្មវិធី';

  @override
  String get includedSurfacePrep => 'រៀបចំផ្ទៃ';

  @override
  String get includedPainting => 'លាបថ្នាំ';

  @override
  String get includedCleanup => 'សម្អាតបន្ទាប់ពីធ្វើការ';

  @override
  String get includedDusting => 'ជូតធូលី';

  @override
  String get includedMopping => 'ជូតរឺឆក់ជាន់';

  @override
  String get includedSanitizing => 'សម្លាប់មេរោគ';

  @override
  String get includedBurnerCheck => 'ត្រួតពិនិត្យក្បាលភ្លើង';

  @override
  String get includedIgnitionRepair => 'ជួសជុលប្រព័ន្ធបញ្ឆេះ';

  @override
  String get includedGasLeakCheck => 'ត្រួតពិនិត្យការលេចធ្លាយហ្គាស';

  @override
  String get includedDrainageCheck => 'ត្រួតពិនិត្យបង្ហូរទឹក';

  @override
  String get includedMotorInspection => 'ត្រួតពិនិត្យម៉ូទ័រ';

  @override
  String get includedCycleTest => 'សាកល្បងវដ្ត';

  @override
  String get includedCoolingCheck => 'ត្រួតពិនិត្យភាពត្រជាក់';

  @override
  String get includedCompressorTest => 'សាកល្បងឧបករណ៍បង្ហាប់';

  @override
  String get includedSealRepair => 'ជួសជុលជ័របិទជិត';
}
