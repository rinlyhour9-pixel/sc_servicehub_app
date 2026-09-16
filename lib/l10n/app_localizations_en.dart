// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTagline => 'Your Home, Fixed Fast';

  @override
  String get roleClient => 'Client';

  @override
  String get roleTechnician => 'Technician';

  @override
  String get roleAdmin => 'Admin';

  @override
  String get onboarding1Title => 'Find Trusted Experts';

  @override
  String get onboarding1Desc =>
      'Finding the most experienced and trusted people to help you';

  @override
  String get onboarding2Title => 'Schedule Your Way';

  @override
  String get onboarding2Desc => 'Schedule your service at your perfect time';

  @override
  String get onboarding3Title => 'Stay Connected';

  @override
  String get onboarding3Desc =>
      'Chat or call your tasker to fine-tune every detail';

  @override
  String get skip => 'Skip';

  @override
  String get next => 'Next';

  @override
  String get getStarted => 'Get Started';

  @override
  String get loginWelcomeTitle => 'Welcome back';

  @override
  String get loginWelcomeSubtitle =>
      'Sign in to manage your home services with ease.';

  @override
  String get loginTechnicianTitle => 'Technician sign in';

  @override
  String get loginTechnicianSubtitle =>
      'Sign in to view and manage your assigned jobs.';

  @override
  String get loginAdminTitle => 'Admin sign in';

  @override
  String get loginAdminSubtitle =>
      'Sign in to manage bookings, technicians, and customers.';

  @override
  String get phoneNumber => 'Phone number';

  @override
  String get phoneNumberHint => '+855 12 345 678';

  @override
  String get password => 'Password';

  @override
  String get passwordHintSignIn => 'Enter your password';

  @override
  String get passwordHintSignUp => 'Create a password';

  @override
  String get rememberMe => 'Remember me';

  @override
  String get forgotPassword => 'Forgot password?';

  @override
  String get signIn => 'Sign In';

  @override
  String get or => 'OR';

  @override
  String get newToApp => 'New to Soft Creative? ';

  @override
  String get createAnAccount => 'Create an account';

  @override
  String get signUpTitle => 'Create account';

  @override
  String get signUpSubtitle =>
      'Create your account and book trusted service professionals.';

  @override
  String get fullName => 'Full name';

  @override
  String get fullNameHint => 'Enter your full name';

  @override
  String get signUpTerms =>
      'By creating an account, you agree to our Terms of Service and Privacy Policy.';

  @override
  String get createAccount => 'Create Account';

  @override
  String get alreadyHaveAccount => 'Already have an account? Sign in';

  @override
  String get forgotPasswordTitle => 'Forgot password?';

  @override
  String get forgotPasswordSubtitle =>
      'Enter your phone number and we will send you instructions to reset your password.';

  @override
  String get sendResetLink => 'Send Reset Link';

  @override
  String get checkYourPhone => 'Check your phone';

  @override
  String resetInstructionsSent(String phone) {
    return 'We sent password reset instructions via SMS to\n$phone';
  }

  @override
  String get backToSignIn => 'Back to Sign In';

  @override
  String get navHome => 'Home';

  @override
  String get navBooking => 'Booking';

  @override
  String get navUpdates => 'Updates';

  @override
  String get navProfile => 'Profile';

  @override
  String get greetingSubtitleClient => 'Good morning, enjoy your day';

  @override
  String get servicesTitle => 'Services';

  @override
  String servicesAvailable(int count) {
    return '$count available';
  }

  @override
  String get myProfileTitle => 'My Profile';

  @override
  String get myProfileSubtitle => 'Manage your account and store setting';

  @override
  String get accountSettings => 'Account Settings';

  @override
  String get settingsInformation => 'Information';

  @override
  String get settingsInformationSubtitle => 'Manage your details and address';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsContactSupport => 'Contact Support';

  @override
  String get settingsContactSupportSubtitle => 'Our Service Has Support 24/7';

  @override
  String get settingsTermsPolicy => 'Terms of Policy';

  @override
  String get settingsTermsPolicySubtitle => 'Review our Terms & Policy';

  @override
  String get logOut => 'Log Out';

  @override
  String get logOutSubtitle => 'Sign out of your account';

  @override
  String get logOutConfirmTitle => 'Log out?';

  @override
  String get logOutConfirmBody =>
      'You will need to sign in again to access your bookings.';

  @override
  String get cancel => 'Cancel';

  @override
  String get chooseLanguage => 'Choose language';

  @override
  String get validatorPhoneInvalid => 'Enter a valid phone number.';

  @override
  String get validatorPasswordMinLength => 'Use at least 6 characters.';

  @override
  String get validatorNameRequired => 'Enter your name.';

  @override
  String get statusPending => 'Pending';

  @override
  String get statusInProgress => 'In Progress';

  @override
  String get statusComplete => 'Complete';

  @override
  String get statusCompleted => 'Completed';

  @override
  String get statusAssigned => 'Assigned';

  @override
  String get statusAccepted => 'Accepted';

  @override
  String get statusCancelled => 'Cancelled';

  @override
  String get statusOnline => 'Online';

  @override
  String get statusOffline => 'Offline';

  @override
  String get statusUnassigned => 'Unassigned';

  @override
  String get filterAll => 'All';

  @override
  String get filterUnread => 'Unread';

  @override
  String get filterImportant => 'Important';

  @override
  String get viewAll => 'View All';

  @override
  String get takeTask => 'Take Task';

  @override
  String get addPhoto => 'Add Photo';

  @override
  String get startTimeLabel => 'Start Time';

  @override
  String get endTimeLabel => 'End Time';

  @override
  String get totalLabel => 'Total';

  @override
  String get noTasksAssignedRightNow => 'No tasks assigned right now';

  @override
  String get notificationHeaderTitle => 'Notification';

  @override
  String get unableOpenMap => 'Unable to open the map application.';

  @override
  String get labelAddress => 'Address';

  @override
  String get labelService => 'Service';

  @override
  String get labelDescription => 'Description';

  @override
  String get performanceItem => 'Performance';

  @override
  String get callAction => 'Call';

  @override
  String get bookingIdLabel => 'Booking ID';

  @override
  String get thisMonth => 'This Month';

  @override
  String get needAction => 'Need Action';

  @override
  String get ongoing => 'Ongoing';

  @override
  String get technicianAssignedLabel => 'Technician Assigned';

  @override
  String get addClientTitle => 'Add Client';

  @override
  String get customerNameLabel => 'Customer Name';

  @override
  String get enterFullNameHint => 'Enter full name';

  @override
  String get idLabel => 'ID';

  @override
  String get idNumberHint => 'ID number';

  @override
  String get genderLabel => 'Gender';

  @override
  String get genderMale => 'Male';

  @override
  String get genderFemale => 'Female';

  @override
  String get genderOther => 'Other';

  @override
  String get skillLabel => 'Skill';

  @override
  String get skillHint => 'e.g. AC Repair, Plumbing';

  @override
  String get saveCustomer => 'Save Customer';

  @override
  String get totalBookingTitle => 'Total Booking';

  @override
  String bookingsCountSuffix(int count) {
    return '$count bookings';
  }

  @override
  String get customersTitle => 'Customers';

  @override
  String get customerProfileTitle => 'Customer Profile';

  @override
  String serviceHistoryCount(int count) {
    return 'Service History ($count)';
  }

  @override
  String get listCustomerLabel => 'List Customer';

  @override
  String get invoiceLabel => 'Invoice';

  @override
  String get listTechnicianLabel => 'List Technician';

  @override
  String get personLabel => 'Person';

  @override
  String get newBookingRequestTitle => 'New Booking Request';

  @override
  String get newBookingRequestMsg => 'John Smith requested AC repair service';

  @override
  String get technicianAssignedActivityMsg =>
      'Sok Dara assigned to #BK240520001';

  @override
  String get serviceCompletedTitle => 'Service Completed';

  @override
  String get serviceCompletedMsg => 'TV Repair completed for Mary Janeeeee';

  @override
  String get adminGreetingSubtitle => 'Good Morning , Enjoy Your Day';

  @override
  String get adminDashboardTitle => 'Admin Dashboard';

  @override
  String get todaysScheduleTitle => 'Today\'s Schedule';

  @override
  String get noJobsScheduled => 'No jobs scheduled';

  @override
  String get recentActivityTitle => 'Recent Activity';

  @override
  String get adminNotifNewBookingMsg =>
      'John Smith has requested AC repair service';

  @override
  String get adminNotifTechAssignedMsg =>
      'Sokun Theryouk has been assigned to booking #BK240S21001';

  @override
  String get adminNotifServiceCompletedMsg =>
      'Technician completed service for booking #BK240620098';

  @override
  String get techniciansTitle => 'Technicians';

  @override
  String get technicianProfileTitle => 'Technician Profile';

  @override
  String get topProBadge => 'Top pro';

  @override
  String get monthlyLabel => 'Monthly';

  @override
  String get oneServiceLabel => '1 Service';

  @override
  String get skillsExpertiseTitle => 'Skills & Expertise';

  @override
  String get availabilityTitle => 'Availability';

  @override
  String jobsCountSuffix(int count) {
    return '$count Jobs';
  }

  @override
  String get noJobsForFilter => 'No jobs for this filter';

  @override
  String get bookingReceivedStep => 'Booking Received';

  @override
  String get repairInProgressStep => 'Repair in Progress';

  @override
  String get serviceCompleteStep => 'Service Complete';

  @override
  String get assignTechnicianTitle => 'Assign Technician';

  @override
  String get trackBookingTitle => 'Track Booking';

  @override
  String get statusProcessTitle => 'Status Process';

  @override
  String get technicianInformationTitle => 'Technician Information';

  @override
  String get serviceRepairReportTitle => 'Service Repair Report';

  @override
  String get addNoteOptionalHint => 'Add a note (optional)';

  @override
  String get confirmButton => 'Confirm';

  @override
  String get noTechnicianAssignedYet => 'No technician assigned yet';

  @override
  String get skillPrefixLabel => 'Skill : ';

  @override
  String get assignedTasksTitle => 'Assigned Tasks';

  @override
  String get completeJobTitle => 'Complete Job';

  @override
  String get customerPhotosAfterLabel => 'CUSTOMER PHOTOS (AFTER)';

  @override
  String get workDescriptionLabel => 'WORK DESCRIPTION';

  @override
  String get summarizeWorkHint => 'Summarize the work you completed...';

  @override
  String get workDurationLabel => 'WORK DURATION';

  @override
  String get submitReportButton => 'Submit Report';

  @override
  String get reportSubmittedMsg => 'Report submitted. Job marked as complete.';

  @override
  String get completedJobsTitle => 'Completed Jobs';

  @override
  String get noCompletedJobsYet => 'No completed jobs yet';

  @override
  String completedPrefixTemplate(String date, String duration) {
    return 'Completed $date • $duration';
  }

  @override
  String get listTaskLabel => 'List Task';

  @override
  String get assignedAllCaps => 'ASSIGNED';

  @override
  String get completedAllCaps => 'COMPLETED';

  @override
  String get technicianGreetingSubtitle =>
      'Ready to fix and make customer happy';

  @override
  String get todayTaskTitle => 'Today Task';

  @override
  String get taskAssignByAdminTitle => 'Task Assign by Admin';

  @override
  String get jobDetailTitle => 'Job Detail';

  @override
  String get bookingIdAllCaps => 'BOOKING ID';

  @override
  String bookedOnPrefix(String date) {
    return 'Booked on $date';
  }

  @override
  String get dateTimeLabel => 'Date & Time';

  @override
  String get viewLocationButton => 'View Location';

  @override
  String get problemDescriptionLabel => 'PROBLEM DESCRIPTION';

  @override
  String get customerPhotosLabel => 'CUSTOMER PHOTOS';

  @override
  String get startJobButton => 'Start Job';

  @override
  String get customerInformationLabel => 'CUSTOMER INFORMATION';

  @override
  String get serviceInformationLabel => 'SERVICE INFORMATION';

  @override
  String get jobInProgressTitle => 'Job In Progress';

  @override
  String get activeServiceLabel => 'ACTIVE SERVICE';

  @override
  String get startedAtSuffix => ' • Started at ';

  @override
  String get workNotesDetailLabel => 'WORK NOTES DETAIL';

  @override
  String get addNoteCurrentWorkHint =>
      'Add a note about the current service work...';

  @override
  String get uploadProgressPhotosLabel => 'UPLOAD PROGRESS PHOTOS';

  @override
  String get jobReportTitle => 'Job Report';

  @override
  String completedOnPrefix(String date) {
    return 'Completed on $date';
  }

  @override
  String get noWorkDescriptionProvided => 'No work description was provided.';

  @override
  String allCountTemplate(int count) {
    return 'All ($count)';
  }

  @override
  String assignedCountTemplate(int count) {
    return 'Assigned ($count)';
  }

  @override
  String completedCountTemplate(int count) {
    return 'Completed ($count)';
  }

  @override
  String get noTasksYet => 'No tasks yet';

  @override
  String get reminderTitle => 'Reminder';

  @override
  String get jobTomorrowMsg => 'You have a job tomorrow at 10:00 AM.';

  @override
  String get newJobAssignedTitle => 'New Job Assigned';

  @override
  String get newJobAssignedMsg =>
      'Booking #BK240521001 has been assigned to you. Scheduled for 03:00 PM.';

  @override
  String get bookingRequestSendTitle => 'Booking Request Send';

  @override
  String get bookingReceivedBody =>
      'We have received your request.\nOur team will assign a technician shortly';

  @override
  String get viewMyBookingButton => 'View My Booking';

  @override
  String get bookingDetailTitle => 'Booking Detail';

  @override
  String get serviceSuffix => ' Service';

  @override
  String get bookingIdPrefix => 'Booking ID : ';

  @override
  String get dateLabel => 'Date';

  @override
  String get timeLabel => 'Time';

  @override
  String get photoLabel => 'Photo';

  @override
  String photosCountSuffix(int count) {
    return '$count Photos';
  }

  @override
  String get assignedTechnicianLabel => 'Assigned Technician';

  @override
  String get bookingStatusTitle => 'Booking Status';

  @override
  String get payAfterServiceNote => 'You can pay after service is completed';

  @override
  String get selectDateTitle => 'Select Date';

  @override
  String get selectServiceDateHelpText => 'SELECT SERVICE DATE';

  @override
  String get weekdayMon => 'Mon';

  @override
  String get weekdayTue => 'Tue';

  @override
  String get weekdayWed => 'Wed';

  @override
  String get weekdayThu => 'Thu';

  @override
  String get weekdayFri => 'Fri';

  @override
  String get weekdaySat => 'Sat';

  @override
  String get weekdaySun => 'Sun';

  @override
  String get selectTimeTitle => 'Select Time';

  @override
  String selectedTimePrefix(String time) {
    return 'Selected time: $time';
  }

  @override
  String get serviceAddressTitle => 'Service Address';

  @override
  String get homeLabel => 'Home';

  @override
  String get pinnedPrefix => 'Pinned: ';

  @override
  String get mapLabel => 'Map';

  @override
  String get describeIssueHint => 'Describe the issue you are facing...';

  @override
  String get uploadPhotoTitle => 'Upload Photo';

  @override
  String get bookingNowButton => 'Booking Now';

  @override
  String get previousDatesTooltip => 'Previous dates';

  @override
  String get nextDatesTooltip => 'Next dates';

  @override
  String get previousTimeTooltip => 'Previous time';

  @override
  String get nextTimeTooltip => 'Next time';

  @override
  String get bookingConfirmedStep => 'Booking Confirmed';

  @override
  String get serviceInProcessStep => 'Service in Process';

  @override
  String get noDescriptionProvided => 'No description provided.';

  @override
  String get chooseLocationTitle => 'Choose Location';

  @override
  String get pinnedLocationLabel => 'Pinned location';

  @override
  String get confirmLocationButton => 'Confirm Location';

  @override
  String get myBookingTitle => 'My Booking';

  @override
  String get viewServiceBookingSubtitle => 'View Your Service Booking';

  @override
  String get upcomingTab => 'Upcoming';

  @override
  String get historyTab => 'History';

  @override
  String get upcomingBookingsTitle => 'Upcoming Bookings';

  @override
  String get pastBookingsTitle => 'Past Bookings';

  @override
  String get noBookingsYet => 'No bookings yet';

  @override
  String get todayLabel => 'Today';

  @override
  String get yesterdayLabel => 'Yesterday';

  @override
  String get notificationSubtitle =>
      'Stay Updated with your service activities';

  @override
  String get viewBookingButton => 'View booking';

  @override
  String get notifTechnicianArrivedTitle => 'Technician Arrived';

  @override
  String get notifTechnicianAssignedMsg =>
      'SK Therayuk has accepted your AC Repair booking';

  @override
  String get notifTechnicianArrivedMsg =>
      'SK Therayuk has arrived at your location';

  @override
  String get notifServiceCompleteMsg =>
      'Your TV Repair service has been completed';

  @override
  String get informationSavedMsg => 'Information saved';

  @override
  String get yourInformationTitle => 'Your Information';

  @override
  String get nameLabel => 'Name';

  @override
  String get tellUsHint => 'Tell us a bit about yourself...';

  @override
  String get saveButton => 'Save';

  @override
  String couldNotOpenMsg(String uri) {
    return 'Could not open $uri';
  }

  @override
  String get howCanWeHelp => 'How we can help you?';

  @override
  String get chatWithUsTitle => 'Chat with Us';

  @override
  String get chatWithUsSubtitle => 'Talk to our support team in real time';

  @override
  String get emailSupportTitle => 'Email Support';

  @override
  String get emailSupportSubtitle => 'Send us an email and we\'ll respond soon';

  @override
  String get callUsTitle => 'Call Us';

  @override
  String get callUsSubtitle => 'Speak with our support directly';

  @override
  String get faqsTitle => 'FAQs';

  @override
  String get faqsSubtitle => 'Find answers to common questions';

  @override
  String get contactUsTitle => 'Contact Us';

  @override
  String get ourAddressLabel => 'Our Address';

  @override
  String get websiteLabel => 'Website';

  @override
  String get facebookLabel => 'Facebook';

  @override
  String get frequentlyAskedQuestions => 'Frequently Asked Questions';

  @override
  String get faqQ1 => 'How do I book a service?';

  @override
  String get faqA1 =>
      'Pick a category from Home, choose a time, and confirm your address.';

  @override
  String get faqQ2 => 'How do I cancel a booking?';

  @override
  String get faqA2 =>
      'Open the booking from My Bookings and tap Cancel before a technician is assigned.';

  @override
  String get faqQ3 => 'What payment methods are supported?';

  @override
  String get faqA3 =>
      'Cash on service completion, with online payment options coming soon.';

  @override
  String get termsSection1Title => 'Using Soft Creative';

  @override
  String get termsSection1Body =>
      'Soft Creative connects you with independent home-service technicians for electrical, plumbing, appliance, and cleaning work. By creating an account you agree to provide accurate booking details and to be reachable at the phone number on file so a technician can complete the job.';

  @override
  String get termsSection2Title => 'Bookings & Cancellations';

  @override
  String get termsSection2Body =>
      'A booking is confirmed once a technician accepts it. You can cancel free of charge before a technician is assigned; cancelling after assignment may incur a small visit fee to cover the technician\'s travel time.';

  @override
  String get termsSection3Title => 'Payments';

  @override
  String get termsSection3Body =>
      'Service fees are shown before you confirm a booking and are payable to the technician on completion of the job. Soft Creative does not store your payment card details.';

  @override
  String get termsSection4Title => 'Technician Conduct';

  @override
  String get termsSection4Body =>
      'Technicians on Soft Creative are vetted and expected to arrive on time, treat your home with care, and only perform the work you booked. Report any issue from the booking detail screen and our support team will follow up.';

  @override
  String get termsSection5Title => 'Your Privacy';

  @override
  String get termsSection5Body =>
      'We collect your name, phone number, and address only to schedule and deliver your bookings. We never sell your personal information to third parties. You can request account deletion at any time from Contact Support.';

  @override
  String get termsSection6Title => 'Changes to These Terms';

  @override
  String get termsSection6Body =>
      'We may update these terms as Soft Creative adds new features. Continued use of the app after an update means you accept the revised terms.';

  @override
  String get lastUpdatedLabel => 'Last updated: September 2026';

  @override
  String get serviceDetailsTitle => 'Service details';

  @override
  String get verifiedProsSubtitle =>
      'Verified professionals • Response in ~30 mins';

  @override
  String get startingFromLabel => 'Starting from';

  @override
  String get whatsIncludedTitle => 'What\'s included';

  @override
  String get bookThisServiceButton => 'Book this service';

  @override
  String get sharedFromAppMsg => 'Shared from Soft Creative app';

  @override
  String get notificationsTooltip => 'Notifications';

  @override
  String serviceIdPrefix(String id) {
    return 'Service ID: $id';
  }

  @override
  String get categoryElectrician => 'Electrician';

  @override
  String get categoryElectricianDesc =>
      'Experienced electricians for wiring, fixture installs, and safety inspections, done right the first time.';

  @override
  String get categoryPlumber => 'Plumber';

  @override
  String get categoryPlumberDesc =>
      'Reliable plumbing repairs and installations for leaks, clogs, and fittings around your home.';

  @override
  String get categoryAcRepair => 'AC Repair';

  @override
  String get categoryAcRepairDesc =>
      'Experience reliable air conditioning services with our team of highly skilled technicians. We specialize in AC installation, repair, deep cleaning, gas refilling, troubleshooting, and routine maintenance. Using modern equipment and quality parts, we ensure your cooling system delivers maximum comfort, energy efficiency, and long-lasting performance throughout the year.';

  @override
  String get categoryTvRepair => 'TV Repair';

  @override
  String get categoryTvRepairDesc =>
      'Screen, sound, and power issues diagnosed and fixed by certified technicians.';

  @override
  String get categoryPainter => 'Painter';

  @override
  String get categoryPainterDesc =>
      'Interior and exterior painting with clean prep work and quality finishes.';

  @override
  String get categoryHomeCleaning => 'Home Cleaning';

  @override
  String get categoryHomeCleaningDesc =>
      'Deep cleaning for every room, using safe and effective products.';

  @override
  String get categoryCookingRange => 'Cooking Range';

  @override
  String get categoryCookingRangeDesc =>
      'Repairs for gas and electric cooktops, burners, and ignition systems.';

  @override
  String get categoryWashingMachine => 'Washing Machine';

  @override
  String get categoryWashingMachineDesc =>
      'Fixes for drainage, spin cycle, and motor issues on all major brands.';

  @override
  String get categoryFridgeRepair => 'Fridge Repair';

  @override
  String get categoryFridgeRepairDesc =>
      'Cooling, compressor, and seal repairs to keep your fridge running efficiently.';

  @override
  String get includedWiringInspection => 'Wiring Inspection';

  @override
  String get includedFixtureInstallation => 'Fixture Installation';

  @override
  String get includedSafetyCheck => 'Safety Check';

  @override
  String get includedLeakDetection => 'Leak Detection';

  @override
  String get includedPipeRepair => 'Pipe Repair';

  @override
  String get includedFixtureInstall => 'Fixture Install';

  @override
  String get includedAcInspection => 'AC Inspection';

  @override
  String get includedGasLevelCheck => 'Gas Level Check';

  @override
  String get includedCleaningMaintenance => 'Cleaning & Maintenance';

  @override
  String get includedDiagnostics => 'Diagnostics';

  @override
  String get includedScreenBoardRepair => 'Screen/Board Repair';

  @override
  String get includedSoftwareCheck => 'Software Check';

  @override
  String get includedSurfacePrep => 'Surface Prep';

  @override
  String get includedPainting => 'Painting';

  @override
  String get includedCleanup => 'Cleanup';

  @override
  String get includedDusting => 'Dusting';

  @override
  String get includedMopping => 'Mopping';

  @override
  String get includedSanitizing => 'Sanitizing';

  @override
  String get includedBurnerCheck => 'Burner Check';

  @override
  String get includedIgnitionRepair => 'Ignition Repair';

  @override
  String get includedGasLeakCheck => 'Gas Leak Check';

  @override
  String get includedDrainageCheck => 'Drainage Check';

  @override
  String get includedMotorInspection => 'Motor Inspection';

  @override
  String get includedCycleTest => 'Cycle Test';

  @override
  String get includedCoolingCheck => 'Cooling Check';

  @override
  String get includedCompressorTest => 'Compressor Test';

  @override
  String get includedSealRepair => 'Seal Repair';
}
