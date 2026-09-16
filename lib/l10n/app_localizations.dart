import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_km.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('km')
  ];

  /// No description provided for @appTagline.
  ///
  /// In en, this message translates to:
  /// **'Your Home, Fixed Fast'**
  String get appTagline;

  /// No description provided for @roleClient.
  ///
  /// In en, this message translates to:
  /// **'Client'**
  String get roleClient;

  /// No description provided for @roleTechnician.
  ///
  /// In en, this message translates to:
  /// **'Technician'**
  String get roleTechnician;

  /// No description provided for @roleAdmin.
  ///
  /// In en, this message translates to:
  /// **'Admin'**
  String get roleAdmin;

  /// No description provided for @onboarding1Title.
  ///
  /// In en, this message translates to:
  /// **'Find Trusted Experts'**
  String get onboarding1Title;

  /// No description provided for @onboarding1Desc.
  ///
  /// In en, this message translates to:
  /// **'Finding the most experienced and trusted people to help you'**
  String get onboarding1Desc;

  /// No description provided for @onboarding2Title.
  ///
  /// In en, this message translates to:
  /// **'Schedule Your Way'**
  String get onboarding2Title;

  /// No description provided for @onboarding2Desc.
  ///
  /// In en, this message translates to:
  /// **'Schedule your service at your perfect time'**
  String get onboarding2Desc;

  /// No description provided for @onboarding3Title.
  ///
  /// In en, this message translates to:
  /// **'Stay Connected'**
  String get onboarding3Title;

  /// No description provided for @onboarding3Desc.
  ///
  /// In en, this message translates to:
  /// **'Chat or call your tasker to fine-tune every detail'**
  String get onboarding3Desc;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @loginWelcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get loginWelcomeTitle;

  /// No description provided for @loginWelcomeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in to manage your home services with ease.'**
  String get loginWelcomeSubtitle;

  /// No description provided for @loginTechnicianTitle.
  ///
  /// In en, this message translates to:
  /// **'Technician sign in'**
  String get loginTechnicianTitle;

  /// No description provided for @loginTechnicianSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in to view and manage your assigned jobs.'**
  String get loginTechnicianSubtitle;

  /// No description provided for @loginAdminTitle.
  ///
  /// In en, this message translates to:
  /// **'Admin sign in'**
  String get loginAdminTitle;

  /// No description provided for @loginAdminSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in to manage bookings, technicians, and customers.'**
  String get loginAdminSubtitle;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get phoneNumber;

  /// No description provided for @phoneNumberHint.
  ///
  /// In en, this message translates to:
  /// **'+855 12 345 678'**
  String get phoneNumberHint;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @passwordHintSignIn.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get passwordHintSignIn;

  /// No description provided for @passwordHintSignUp.
  ///
  /// In en, this message translates to:
  /// **'Create a password'**
  String get passwordHintSignUp;

  /// No description provided for @rememberMe.
  ///
  /// In en, this message translates to:
  /// **'Remember me'**
  String get rememberMe;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPassword;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'OR'**
  String get or;

  /// No description provided for @newToApp.
  ///
  /// In en, this message translates to:
  /// **'New to Soft Creative? '**
  String get newToApp;

  /// No description provided for @createAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Create an account'**
  String get createAnAccount;

  /// No description provided for @signUpTitle.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get signUpTitle;

  /// No description provided for @signUpSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Create your account and book trusted service professionals.'**
  String get signUpSubtitle;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get fullName;

  /// No description provided for @fullNameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your full name'**
  String get fullNameHint;

  /// No description provided for @signUpTerms.
  ///
  /// In en, this message translates to:
  /// **'By creating an account, you agree to our Terms of Service and Privacy Policy.'**
  String get signUpTerms;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? Sign in'**
  String get alreadyHaveAccount;

  /// No description provided for @forgotPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPasswordTitle;

  /// No description provided for @forgotPasswordSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number and we will send you instructions to reset your password.'**
  String get forgotPasswordSubtitle;

  /// No description provided for @sendResetLink.
  ///
  /// In en, this message translates to:
  /// **'Send Reset Link'**
  String get sendResetLink;

  /// No description provided for @checkYourPhone.
  ///
  /// In en, this message translates to:
  /// **'Check your phone'**
  String get checkYourPhone;

  /// No description provided for @resetInstructionsSent.
  ///
  /// In en, this message translates to:
  /// **'We sent password reset instructions via SMS to\n{phone}'**
  String resetInstructionsSent(String phone);

  /// No description provided for @backToSignIn.
  ///
  /// In en, this message translates to:
  /// **'Back to Sign In'**
  String get backToSignIn;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navBooking.
  ///
  /// In en, this message translates to:
  /// **'Booking'**
  String get navBooking;

  /// No description provided for @navUpdates.
  ///
  /// In en, this message translates to:
  /// **'Updates'**
  String get navUpdates;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// No description provided for @greetingSubtitleClient.
  ///
  /// In en, this message translates to:
  /// **'Good morning, enjoy your day'**
  String get greetingSubtitleClient;

  /// No description provided for @servicesTitle.
  ///
  /// In en, this message translates to:
  /// **'Services'**
  String get servicesTitle;

  /// No description provided for @servicesAvailable.
  ///
  /// In en, this message translates to:
  /// **'{count} available'**
  String servicesAvailable(int count);

  /// No description provided for @myProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'My Profile'**
  String get myProfileTitle;

  /// No description provided for @myProfileSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage your account and store setting'**
  String get myProfileSubtitle;

  /// No description provided for @accountSettings.
  ///
  /// In en, this message translates to:
  /// **'Account Settings'**
  String get accountSettings;

  /// No description provided for @settingsInformation.
  ///
  /// In en, this message translates to:
  /// **'Information'**
  String get settingsInformation;

  /// No description provided for @settingsInformationSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage your details and address'**
  String get settingsInformationSubtitle;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// No description provided for @settingsContactSupport.
  ///
  /// In en, this message translates to:
  /// **'Contact Support'**
  String get settingsContactSupport;

  /// No description provided for @settingsContactSupportSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Our Service Has Support 24/7'**
  String get settingsContactSupportSubtitle;

  /// No description provided for @settingsTermsPolicy.
  ///
  /// In en, this message translates to:
  /// **'Terms of Policy'**
  String get settingsTermsPolicy;

  /// No description provided for @settingsTermsPolicySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Review our Terms & Policy'**
  String get settingsTermsPolicySubtitle;

  /// No description provided for @logOut.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get logOut;

  /// No description provided for @logOutSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign out of your account'**
  String get logOutSubtitle;

  /// No description provided for @logOutConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Log out?'**
  String get logOutConfirmTitle;

  /// No description provided for @logOutConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'You will need to sign in again to access your bookings.'**
  String get logOutConfirmBody;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @chooseLanguage.
  ///
  /// In en, this message translates to:
  /// **'Choose language'**
  String get chooseLanguage;

  /// No description provided for @validatorPhoneInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid phone number.'**
  String get validatorPhoneInvalid;

  /// No description provided for @validatorPasswordMinLength.
  ///
  /// In en, this message translates to:
  /// **'Use at least 6 characters.'**
  String get validatorPasswordMinLength;

  /// No description provided for @validatorNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Enter your name.'**
  String get validatorNameRequired;

  /// No description provided for @statusPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get statusPending;

  /// No description provided for @statusInProgress.
  ///
  /// In en, this message translates to:
  /// **'In Progress'**
  String get statusInProgress;

  /// No description provided for @statusComplete.
  ///
  /// In en, this message translates to:
  /// **'Complete'**
  String get statusComplete;

  /// No description provided for @statusCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get statusCompleted;

  /// No description provided for @statusAssigned.
  ///
  /// In en, this message translates to:
  /// **'Assigned'**
  String get statusAssigned;

  /// No description provided for @statusAccepted.
  ///
  /// In en, this message translates to:
  /// **'Accepted'**
  String get statusAccepted;

  /// No description provided for @statusCancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get statusCancelled;

  /// No description provided for @statusOnline.
  ///
  /// In en, this message translates to:
  /// **'Online'**
  String get statusOnline;

  /// No description provided for @statusOffline.
  ///
  /// In en, this message translates to:
  /// **'Offline'**
  String get statusOffline;

  /// No description provided for @statusUnassigned.
  ///
  /// In en, this message translates to:
  /// **'Unassigned'**
  String get statusUnassigned;

  /// No description provided for @filterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get filterAll;

  /// No description provided for @filterUnread.
  ///
  /// In en, this message translates to:
  /// **'Unread'**
  String get filterUnread;

  /// No description provided for @filterImportant.
  ///
  /// In en, this message translates to:
  /// **'Important'**
  String get filterImportant;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get viewAll;

  /// No description provided for @takeTask.
  ///
  /// In en, this message translates to:
  /// **'Take Task'**
  String get takeTask;

  /// No description provided for @addPhoto.
  ///
  /// In en, this message translates to:
  /// **'Add Photo'**
  String get addPhoto;

  /// No description provided for @startTimeLabel.
  ///
  /// In en, this message translates to:
  /// **'Start Time'**
  String get startTimeLabel;

  /// No description provided for @endTimeLabel.
  ///
  /// In en, this message translates to:
  /// **'End Time'**
  String get endTimeLabel;

  /// No description provided for @totalLabel.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get totalLabel;

  /// No description provided for @noTasksAssignedRightNow.
  ///
  /// In en, this message translates to:
  /// **'No tasks assigned right now'**
  String get noTasksAssignedRightNow;

  /// No description provided for @notificationHeaderTitle.
  ///
  /// In en, this message translates to:
  /// **'Notification'**
  String get notificationHeaderTitle;

  /// No description provided for @unableOpenMap.
  ///
  /// In en, this message translates to:
  /// **'Unable to open the map application.'**
  String get unableOpenMap;

  /// No description provided for @labelAddress.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get labelAddress;

  /// No description provided for @labelService.
  ///
  /// In en, this message translates to:
  /// **'Service'**
  String get labelService;

  /// No description provided for @labelDescription.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get labelDescription;

  /// No description provided for @performanceItem.
  ///
  /// In en, this message translates to:
  /// **'Performance'**
  String get performanceItem;

  /// No description provided for @callAction.
  ///
  /// In en, this message translates to:
  /// **'Call'**
  String get callAction;

  /// No description provided for @bookingIdLabel.
  ///
  /// In en, this message translates to:
  /// **'Booking ID'**
  String get bookingIdLabel;

  /// No description provided for @thisMonth.
  ///
  /// In en, this message translates to:
  /// **'This Month'**
  String get thisMonth;

  /// No description provided for @needAction.
  ///
  /// In en, this message translates to:
  /// **'Need Action'**
  String get needAction;

  /// No description provided for @ongoing.
  ///
  /// In en, this message translates to:
  /// **'Ongoing'**
  String get ongoing;

  /// No description provided for @technicianAssignedLabel.
  ///
  /// In en, this message translates to:
  /// **'Technician Assigned'**
  String get technicianAssignedLabel;

  /// No description provided for @addClientTitle.
  ///
  /// In en, this message translates to:
  /// **'Add Client'**
  String get addClientTitle;

  /// No description provided for @customerNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Customer Name'**
  String get customerNameLabel;

  /// No description provided for @enterFullNameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter full name'**
  String get enterFullNameHint;

  /// No description provided for @idLabel.
  ///
  /// In en, this message translates to:
  /// **'ID'**
  String get idLabel;

  /// No description provided for @idNumberHint.
  ///
  /// In en, this message translates to:
  /// **'ID number'**
  String get idNumberHint;

  /// No description provided for @genderLabel.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get genderLabel;

  /// No description provided for @genderMale.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get genderMale;

  /// No description provided for @genderFemale.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get genderFemale;

  /// No description provided for @genderOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get genderOther;

  /// No description provided for @skillLabel.
  ///
  /// In en, this message translates to:
  /// **'Skill'**
  String get skillLabel;

  /// No description provided for @skillHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. AC Repair, Plumbing'**
  String get skillHint;

  /// No description provided for @saveCustomer.
  ///
  /// In en, this message translates to:
  /// **'Save Customer'**
  String get saveCustomer;

  /// No description provided for @totalBookingTitle.
  ///
  /// In en, this message translates to:
  /// **'Total Booking'**
  String get totalBookingTitle;

  /// No description provided for @bookingsCountSuffix.
  ///
  /// In en, this message translates to:
  /// **'{count} bookings'**
  String bookingsCountSuffix(int count);

  /// No description provided for @customersTitle.
  ///
  /// In en, this message translates to:
  /// **'Customers'**
  String get customersTitle;

  /// No description provided for @customerProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'Customer Profile'**
  String get customerProfileTitle;

  /// No description provided for @serviceHistoryCount.
  ///
  /// In en, this message translates to:
  /// **'Service History ({count})'**
  String serviceHistoryCount(int count);

  /// No description provided for @listCustomerLabel.
  ///
  /// In en, this message translates to:
  /// **'List Customer'**
  String get listCustomerLabel;

  /// No description provided for @invoiceLabel.
  ///
  /// In en, this message translates to:
  /// **'Invoice'**
  String get invoiceLabel;

  /// No description provided for @listTechnicianLabel.
  ///
  /// In en, this message translates to:
  /// **'List Technician'**
  String get listTechnicianLabel;

  /// No description provided for @personLabel.
  ///
  /// In en, this message translates to:
  /// **'Person'**
  String get personLabel;

  /// No description provided for @newBookingRequestTitle.
  ///
  /// In en, this message translates to:
  /// **'New Booking Request'**
  String get newBookingRequestTitle;

  /// No description provided for @newBookingRequestMsg.
  ///
  /// In en, this message translates to:
  /// **'John Smith requested AC repair service'**
  String get newBookingRequestMsg;

  /// No description provided for @technicianAssignedActivityMsg.
  ///
  /// In en, this message translates to:
  /// **'Sok Dara assigned to #BK240520001'**
  String get technicianAssignedActivityMsg;

  /// No description provided for @serviceCompletedTitle.
  ///
  /// In en, this message translates to:
  /// **'Service Completed'**
  String get serviceCompletedTitle;

  /// No description provided for @serviceCompletedMsg.
  ///
  /// In en, this message translates to:
  /// **'TV Repair completed for Mary Janeeeee'**
  String get serviceCompletedMsg;

  /// No description provided for @adminGreetingSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Good Morning , Enjoy Your Day'**
  String get adminGreetingSubtitle;

  /// No description provided for @adminDashboardTitle.
  ///
  /// In en, this message translates to:
  /// **'Admin Dashboard'**
  String get adminDashboardTitle;

  /// No description provided for @todaysScheduleTitle.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Schedule'**
  String get todaysScheduleTitle;

  /// No description provided for @noJobsScheduled.
  ///
  /// In en, this message translates to:
  /// **'No jobs scheduled'**
  String get noJobsScheduled;

  /// No description provided for @recentActivityTitle.
  ///
  /// In en, this message translates to:
  /// **'Recent Activity'**
  String get recentActivityTitle;

  /// No description provided for @adminNotifNewBookingMsg.
  ///
  /// In en, this message translates to:
  /// **'John Smith has requested AC repair service'**
  String get adminNotifNewBookingMsg;

  /// No description provided for @adminNotifTechAssignedMsg.
  ///
  /// In en, this message translates to:
  /// **'Sokun Theryouk has been assigned to booking #BK240S21001'**
  String get adminNotifTechAssignedMsg;

  /// No description provided for @adminNotifServiceCompletedMsg.
  ///
  /// In en, this message translates to:
  /// **'Technician completed service for booking #BK240620098'**
  String get adminNotifServiceCompletedMsg;

  /// No description provided for @techniciansTitle.
  ///
  /// In en, this message translates to:
  /// **'Technicians'**
  String get techniciansTitle;

  /// No description provided for @technicianProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'Technician Profile'**
  String get technicianProfileTitle;

  /// No description provided for @topProBadge.
  ///
  /// In en, this message translates to:
  /// **'Top pro'**
  String get topProBadge;

  /// No description provided for @monthlyLabel.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get monthlyLabel;

  /// No description provided for @oneServiceLabel.
  ///
  /// In en, this message translates to:
  /// **'1 Service'**
  String get oneServiceLabel;

  /// No description provided for @skillsExpertiseTitle.
  ///
  /// In en, this message translates to:
  /// **'Skills & Expertise'**
  String get skillsExpertiseTitle;

  /// No description provided for @availabilityTitle.
  ///
  /// In en, this message translates to:
  /// **'Availability'**
  String get availabilityTitle;

  /// No description provided for @jobsCountSuffix.
  ///
  /// In en, this message translates to:
  /// **'{count} Jobs'**
  String jobsCountSuffix(int count);

  /// No description provided for @noJobsForFilter.
  ///
  /// In en, this message translates to:
  /// **'No jobs for this filter'**
  String get noJobsForFilter;

  /// No description provided for @bookingReceivedStep.
  ///
  /// In en, this message translates to:
  /// **'Booking Received'**
  String get bookingReceivedStep;

  /// No description provided for @repairInProgressStep.
  ///
  /// In en, this message translates to:
  /// **'Repair in Progress'**
  String get repairInProgressStep;

  /// No description provided for @serviceCompleteStep.
  ///
  /// In en, this message translates to:
  /// **'Service Complete'**
  String get serviceCompleteStep;

  /// No description provided for @assignTechnicianTitle.
  ///
  /// In en, this message translates to:
  /// **'Assign Technician'**
  String get assignTechnicianTitle;

  /// No description provided for @trackBookingTitle.
  ///
  /// In en, this message translates to:
  /// **'Track Booking'**
  String get trackBookingTitle;

  /// No description provided for @statusProcessTitle.
  ///
  /// In en, this message translates to:
  /// **'Status Process'**
  String get statusProcessTitle;

  /// No description provided for @technicianInformationTitle.
  ///
  /// In en, this message translates to:
  /// **'Technician Information'**
  String get technicianInformationTitle;

  /// No description provided for @serviceRepairReportTitle.
  ///
  /// In en, this message translates to:
  /// **'Service Repair Report'**
  String get serviceRepairReportTitle;

  /// No description provided for @addNoteOptionalHint.
  ///
  /// In en, this message translates to:
  /// **'Add a note (optional)'**
  String get addNoteOptionalHint;

  /// No description provided for @confirmButton.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirmButton;

  /// No description provided for @noTechnicianAssignedYet.
  ///
  /// In en, this message translates to:
  /// **'No technician assigned yet'**
  String get noTechnicianAssignedYet;

  /// No description provided for @skillPrefixLabel.
  ///
  /// In en, this message translates to:
  /// **'Skill : '**
  String get skillPrefixLabel;

  /// No description provided for @assignedTasksTitle.
  ///
  /// In en, this message translates to:
  /// **'Assigned Tasks'**
  String get assignedTasksTitle;

  /// No description provided for @completeJobTitle.
  ///
  /// In en, this message translates to:
  /// **'Complete Job'**
  String get completeJobTitle;

  /// No description provided for @customerPhotosAfterLabel.
  ///
  /// In en, this message translates to:
  /// **'CUSTOMER PHOTOS (AFTER)'**
  String get customerPhotosAfterLabel;

  /// No description provided for @workDescriptionLabel.
  ///
  /// In en, this message translates to:
  /// **'WORK DESCRIPTION'**
  String get workDescriptionLabel;

  /// No description provided for @summarizeWorkHint.
  ///
  /// In en, this message translates to:
  /// **'Summarize the work you completed...'**
  String get summarizeWorkHint;

  /// No description provided for @workDurationLabel.
  ///
  /// In en, this message translates to:
  /// **'WORK DURATION'**
  String get workDurationLabel;

  /// No description provided for @submitReportButton.
  ///
  /// In en, this message translates to:
  /// **'Submit Report'**
  String get submitReportButton;

  /// No description provided for @reportSubmittedMsg.
  ///
  /// In en, this message translates to:
  /// **'Report submitted. Job marked as complete.'**
  String get reportSubmittedMsg;

  /// No description provided for @completedJobsTitle.
  ///
  /// In en, this message translates to:
  /// **'Completed Jobs'**
  String get completedJobsTitle;

  /// No description provided for @noCompletedJobsYet.
  ///
  /// In en, this message translates to:
  /// **'No completed jobs yet'**
  String get noCompletedJobsYet;

  /// No description provided for @completedPrefixTemplate.
  ///
  /// In en, this message translates to:
  /// **'Completed {date} • {duration}'**
  String completedPrefixTemplate(String date, String duration);

  /// No description provided for @listTaskLabel.
  ///
  /// In en, this message translates to:
  /// **'List Task'**
  String get listTaskLabel;

  /// No description provided for @assignedAllCaps.
  ///
  /// In en, this message translates to:
  /// **'ASSIGNED'**
  String get assignedAllCaps;

  /// No description provided for @completedAllCaps.
  ///
  /// In en, this message translates to:
  /// **'COMPLETED'**
  String get completedAllCaps;

  /// No description provided for @technicianGreetingSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Ready to fix and make customer happy'**
  String get technicianGreetingSubtitle;

  /// No description provided for @todayTaskTitle.
  ///
  /// In en, this message translates to:
  /// **'Today Task'**
  String get todayTaskTitle;

  /// No description provided for @taskAssignByAdminTitle.
  ///
  /// In en, this message translates to:
  /// **'Task Assign by Admin'**
  String get taskAssignByAdminTitle;

  /// No description provided for @jobDetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Job Detail'**
  String get jobDetailTitle;

  /// No description provided for @bookingIdAllCaps.
  ///
  /// In en, this message translates to:
  /// **'BOOKING ID'**
  String get bookingIdAllCaps;

  /// No description provided for @bookedOnPrefix.
  ///
  /// In en, this message translates to:
  /// **'Booked on {date}'**
  String bookedOnPrefix(String date);

  /// No description provided for @dateTimeLabel.
  ///
  /// In en, this message translates to:
  /// **'Date & Time'**
  String get dateTimeLabel;

  /// No description provided for @viewLocationButton.
  ///
  /// In en, this message translates to:
  /// **'View Location'**
  String get viewLocationButton;

  /// No description provided for @problemDescriptionLabel.
  ///
  /// In en, this message translates to:
  /// **'PROBLEM DESCRIPTION'**
  String get problemDescriptionLabel;

  /// No description provided for @customerPhotosLabel.
  ///
  /// In en, this message translates to:
  /// **'CUSTOMER PHOTOS'**
  String get customerPhotosLabel;

  /// No description provided for @startJobButton.
  ///
  /// In en, this message translates to:
  /// **'Start Job'**
  String get startJobButton;

  /// No description provided for @customerInformationLabel.
  ///
  /// In en, this message translates to:
  /// **'CUSTOMER INFORMATION'**
  String get customerInformationLabel;

  /// No description provided for @serviceInformationLabel.
  ///
  /// In en, this message translates to:
  /// **'SERVICE INFORMATION'**
  String get serviceInformationLabel;

  /// No description provided for @jobInProgressTitle.
  ///
  /// In en, this message translates to:
  /// **'Job In Progress'**
  String get jobInProgressTitle;

  /// No description provided for @activeServiceLabel.
  ///
  /// In en, this message translates to:
  /// **'ACTIVE SERVICE'**
  String get activeServiceLabel;

  /// No description provided for @startedAtSuffix.
  ///
  /// In en, this message translates to:
  /// **' • Started at '**
  String get startedAtSuffix;

  /// No description provided for @workNotesDetailLabel.
  ///
  /// In en, this message translates to:
  /// **'WORK NOTES DETAIL'**
  String get workNotesDetailLabel;

  /// No description provided for @addNoteCurrentWorkHint.
  ///
  /// In en, this message translates to:
  /// **'Add a note about the current service work...'**
  String get addNoteCurrentWorkHint;

  /// No description provided for @uploadProgressPhotosLabel.
  ///
  /// In en, this message translates to:
  /// **'UPLOAD PROGRESS PHOTOS'**
  String get uploadProgressPhotosLabel;

  /// No description provided for @jobReportTitle.
  ///
  /// In en, this message translates to:
  /// **'Job Report'**
  String get jobReportTitle;

  /// No description provided for @completedOnPrefix.
  ///
  /// In en, this message translates to:
  /// **'Completed on {date}'**
  String completedOnPrefix(String date);

  /// No description provided for @noWorkDescriptionProvided.
  ///
  /// In en, this message translates to:
  /// **'No work description was provided.'**
  String get noWorkDescriptionProvided;

  /// No description provided for @allCountTemplate.
  ///
  /// In en, this message translates to:
  /// **'All ({count})'**
  String allCountTemplate(int count);

  /// No description provided for @assignedCountTemplate.
  ///
  /// In en, this message translates to:
  /// **'Assigned ({count})'**
  String assignedCountTemplate(int count);

  /// No description provided for @completedCountTemplate.
  ///
  /// In en, this message translates to:
  /// **'Completed ({count})'**
  String completedCountTemplate(int count);

  /// No description provided for @noTasksYet.
  ///
  /// In en, this message translates to:
  /// **'No tasks yet'**
  String get noTasksYet;

  /// No description provided for @reminderTitle.
  ///
  /// In en, this message translates to:
  /// **'Reminder'**
  String get reminderTitle;

  /// No description provided for @jobTomorrowMsg.
  ///
  /// In en, this message translates to:
  /// **'You have a job tomorrow at 10:00 AM.'**
  String get jobTomorrowMsg;

  /// No description provided for @newJobAssignedTitle.
  ///
  /// In en, this message translates to:
  /// **'New Job Assigned'**
  String get newJobAssignedTitle;

  /// No description provided for @newJobAssignedMsg.
  ///
  /// In en, this message translates to:
  /// **'Booking #BK240521001 has been assigned to you. Scheduled for 03:00 PM.'**
  String get newJobAssignedMsg;

  /// No description provided for @bookingRequestSendTitle.
  ///
  /// In en, this message translates to:
  /// **'Booking Request Send'**
  String get bookingRequestSendTitle;

  /// No description provided for @bookingReceivedBody.
  ///
  /// In en, this message translates to:
  /// **'We have received your request.\nOur team will assign a technician shortly'**
  String get bookingReceivedBody;

  /// No description provided for @viewMyBookingButton.
  ///
  /// In en, this message translates to:
  /// **'View My Booking'**
  String get viewMyBookingButton;

  /// No description provided for @bookingDetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Booking Detail'**
  String get bookingDetailTitle;

  /// No description provided for @serviceSuffix.
  ///
  /// In en, this message translates to:
  /// **' Service'**
  String get serviceSuffix;

  /// No description provided for @bookingIdPrefix.
  ///
  /// In en, this message translates to:
  /// **'Booking ID : '**
  String get bookingIdPrefix;

  /// No description provided for @dateLabel.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get dateLabel;

  /// No description provided for @timeLabel.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get timeLabel;

  /// No description provided for @photoLabel.
  ///
  /// In en, this message translates to:
  /// **'Photo'**
  String get photoLabel;

  /// No description provided for @photosCountSuffix.
  ///
  /// In en, this message translates to:
  /// **'{count} Photos'**
  String photosCountSuffix(int count);

  /// No description provided for @assignedTechnicianLabel.
  ///
  /// In en, this message translates to:
  /// **'Assigned Technician'**
  String get assignedTechnicianLabel;

  /// No description provided for @bookingStatusTitle.
  ///
  /// In en, this message translates to:
  /// **'Booking Status'**
  String get bookingStatusTitle;

  /// No description provided for @payAfterServiceNote.
  ///
  /// In en, this message translates to:
  /// **'You can pay after service is completed'**
  String get payAfterServiceNote;

  /// No description provided for @selectDateTitle.
  ///
  /// In en, this message translates to:
  /// **'Select Date'**
  String get selectDateTitle;

  /// No description provided for @selectServiceDateHelpText.
  ///
  /// In en, this message translates to:
  /// **'SELECT SERVICE DATE'**
  String get selectServiceDateHelpText;

  /// No description provided for @weekdayMon.
  ///
  /// In en, this message translates to:
  /// **'Mon'**
  String get weekdayMon;

  /// No description provided for @weekdayTue.
  ///
  /// In en, this message translates to:
  /// **'Tue'**
  String get weekdayTue;

  /// No description provided for @weekdayWed.
  ///
  /// In en, this message translates to:
  /// **'Wed'**
  String get weekdayWed;

  /// No description provided for @weekdayThu.
  ///
  /// In en, this message translates to:
  /// **'Thu'**
  String get weekdayThu;

  /// No description provided for @weekdayFri.
  ///
  /// In en, this message translates to:
  /// **'Fri'**
  String get weekdayFri;

  /// No description provided for @weekdaySat.
  ///
  /// In en, this message translates to:
  /// **'Sat'**
  String get weekdaySat;

  /// No description provided for @weekdaySun.
  ///
  /// In en, this message translates to:
  /// **'Sun'**
  String get weekdaySun;

  /// No description provided for @selectTimeTitle.
  ///
  /// In en, this message translates to:
  /// **'Select Time'**
  String get selectTimeTitle;

  /// No description provided for @selectedTimePrefix.
  ///
  /// In en, this message translates to:
  /// **'Selected time: {time}'**
  String selectedTimePrefix(String time);

  /// No description provided for @serviceAddressTitle.
  ///
  /// In en, this message translates to:
  /// **'Service Address'**
  String get serviceAddressTitle;

  /// No description provided for @homeLabel.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeLabel;

  /// No description provided for @pinnedPrefix.
  ///
  /// In en, this message translates to:
  /// **'Pinned: '**
  String get pinnedPrefix;

  /// No description provided for @mapLabel.
  ///
  /// In en, this message translates to:
  /// **'Map'**
  String get mapLabel;

  /// No description provided for @describeIssueHint.
  ///
  /// In en, this message translates to:
  /// **'Describe the issue you are facing...'**
  String get describeIssueHint;

  /// No description provided for @uploadPhotoTitle.
  ///
  /// In en, this message translates to:
  /// **'Upload Photo'**
  String get uploadPhotoTitle;

  /// No description provided for @bookingNowButton.
  ///
  /// In en, this message translates to:
  /// **'Booking Now'**
  String get bookingNowButton;

  /// No description provided for @previousDatesTooltip.
  ///
  /// In en, this message translates to:
  /// **'Previous dates'**
  String get previousDatesTooltip;

  /// No description provided for @nextDatesTooltip.
  ///
  /// In en, this message translates to:
  /// **'Next dates'**
  String get nextDatesTooltip;

  /// No description provided for @previousTimeTooltip.
  ///
  /// In en, this message translates to:
  /// **'Previous time'**
  String get previousTimeTooltip;

  /// No description provided for @nextTimeTooltip.
  ///
  /// In en, this message translates to:
  /// **'Next time'**
  String get nextTimeTooltip;

  /// No description provided for @bookingConfirmedStep.
  ///
  /// In en, this message translates to:
  /// **'Booking Confirmed'**
  String get bookingConfirmedStep;

  /// No description provided for @serviceInProcessStep.
  ///
  /// In en, this message translates to:
  /// **'Service in Process'**
  String get serviceInProcessStep;

  /// No description provided for @noDescriptionProvided.
  ///
  /// In en, this message translates to:
  /// **'No description provided.'**
  String get noDescriptionProvided;

  /// No description provided for @chooseLocationTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose Location'**
  String get chooseLocationTitle;

  /// No description provided for @pinnedLocationLabel.
  ///
  /// In en, this message translates to:
  /// **'Pinned location'**
  String get pinnedLocationLabel;

  /// No description provided for @confirmLocationButton.
  ///
  /// In en, this message translates to:
  /// **'Confirm Location'**
  String get confirmLocationButton;

  /// No description provided for @myBookingTitle.
  ///
  /// In en, this message translates to:
  /// **'My Booking'**
  String get myBookingTitle;

  /// No description provided for @viewServiceBookingSubtitle.
  ///
  /// In en, this message translates to:
  /// **'View Your Service Booking'**
  String get viewServiceBookingSubtitle;

  /// No description provided for @upcomingTab.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get upcomingTab;

  /// No description provided for @historyTab.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get historyTab;

  /// No description provided for @upcomingBookingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Upcoming Bookings'**
  String get upcomingBookingsTitle;

  /// No description provided for @pastBookingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Past Bookings'**
  String get pastBookingsTitle;

  /// No description provided for @noBookingsYet.
  ///
  /// In en, this message translates to:
  /// **'No bookings yet'**
  String get noBookingsYet;

  /// No description provided for @todayLabel.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get todayLabel;

  /// No description provided for @yesterdayLabel.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get yesterdayLabel;

  /// No description provided for @notificationSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Stay Updated with your service activities'**
  String get notificationSubtitle;

  /// No description provided for @viewBookingButton.
  ///
  /// In en, this message translates to:
  /// **'View booking'**
  String get viewBookingButton;

  /// No description provided for @notifTechnicianArrivedTitle.
  ///
  /// In en, this message translates to:
  /// **'Technician Arrived'**
  String get notifTechnicianArrivedTitle;

  /// No description provided for @notifTechnicianAssignedMsg.
  ///
  /// In en, this message translates to:
  /// **'SK Therayuk has accepted your AC Repair booking'**
  String get notifTechnicianAssignedMsg;

  /// No description provided for @notifTechnicianArrivedMsg.
  ///
  /// In en, this message translates to:
  /// **'SK Therayuk has arrived at your location'**
  String get notifTechnicianArrivedMsg;

  /// No description provided for @notifServiceCompleteMsg.
  ///
  /// In en, this message translates to:
  /// **'Your TV Repair service has been completed'**
  String get notifServiceCompleteMsg;

  /// No description provided for @informationSavedMsg.
  ///
  /// In en, this message translates to:
  /// **'Information saved'**
  String get informationSavedMsg;

  /// No description provided for @yourInformationTitle.
  ///
  /// In en, this message translates to:
  /// **'Your Information'**
  String get yourInformationTitle;

  /// No description provided for @nameLabel.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get nameLabel;

  /// No description provided for @tellUsHint.
  ///
  /// In en, this message translates to:
  /// **'Tell us a bit about yourself...'**
  String get tellUsHint;

  /// No description provided for @saveButton.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get saveButton;

  /// No description provided for @couldNotOpenMsg.
  ///
  /// In en, this message translates to:
  /// **'Could not open {uri}'**
  String couldNotOpenMsg(String uri);

  /// No description provided for @howCanWeHelp.
  ///
  /// In en, this message translates to:
  /// **'How we can help you?'**
  String get howCanWeHelp;

  /// No description provided for @chatWithUsTitle.
  ///
  /// In en, this message translates to:
  /// **'Chat with Us'**
  String get chatWithUsTitle;

  /// No description provided for @chatWithUsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Talk to our support team in real time'**
  String get chatWithUsSubtitle;

  /// No description provided for @emailSupportTitle.
  ///
  /// In en, this message translates to:
  /// **'Email Support'**
  String get emailSupportTitle;

  /// No description provided for @emailSupportSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Send us an email and we\'ll respond soon'**
  String get emailSupportSubtitle;

  /// No description provided for @callUsTitle.
  ///
  /// In en, this message translates to:
  /// **'Call Us'**
  String get callUsTitle;

  /// No description provided for @callUsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Speak with our support directly'**
  String get callUsSubtitle;

  /// No description provided for @faqsTitle.
  ///
  /// In en, this message translates to:
  /// **'FAQs'**
  String get faqsTitle;

  /// No description provided for @faqsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Find answers to common questions'**
  String get faqsSubtitle;

  /// No description provided for @contactUsTitle.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contactUsTitle;

  /// No description provided for @ourAddressLabel.
  ///
  /// In en, this message translates to:
  /// **'Our Address'**
  String get ourAddressLabel;

  /// No description provided for @websiteLabel.
  ///
  /// In en, this message translates to:
  /// **'Website'**
  String get websiteLabel;

  /// No description provided for @facebookLabel.
  ///
  /// In en, this message translates to:
  /// **'Facebook'**
  String get facebookLabel;

  /// No description provided for @frequentlyAskedQuestions.
  ///
  /// In en, this message translates to:
  /// **'Frequently Asked Questions'**
  String get frequentlyAskedQuestions;

  /// No description provided for @faqQ1.
  ///
  /// In en, this message translates to:
  /// **'How do I book a service?'**
  String get faqQ1;

  /// No description provided for @faqA1.
  ///
  /// In en, this message translates to:
  /// **'Pick a category from Home, choose a time, and confirm your address.'**
  String get faqA1;

  /// No description provided for @faqQ2.
  ///
  /// In en, this message translates to:
  /// **'How do I cancel a booking?'**
  String get faqQ2;

  /// No description provided for @faqA2.
  ///
  /// In en, this message translates to:
  /// **'Open the booking from My Bookings and tap Cancel before a technician is assigned.'**
  String get faqA2;

  /// No description provided for @faqQ3.
  ///
  /// In en, this message translates to:
  /// **'What payment methods are supported?'**
  String get faqQ3;

  /// No description provided for @faqA3.
  ///
  /// In en, this message translates to:
  /// **'Cash on service completion, with online payment options coming soon.'**
  String get faqA3;

  /// No description provided for @termsSection1Title.
  ///
  /// In en, this message translates to:
  /// **'Using Soft Creative'**
  String get termsSection1Title;

  /// No description provided for @termsSection1Body.
  ///
  /// In en, this message translates to:
  /// **'Soft Creative connects you with independent home-service technicians for electrical, plumbing, appliance, and cleaning work. By creating an account you agree to provide accurate booking details and to be reachable at the phone number on file so a technician can complete the job.'**
  String get termsSection1Body;

  /// No description provided for @termsSection2Title.
  ///
  /// In en, this message translates to:
  /// **'Bookings & Cancellations'**
  String get termsSection2Title;

  /// No description provided for @termsSection2Body.
  ///
  /// In en, this message translates to:
  /// **'A booking is confirmed once a technician accepts it. You can cancel free of charge before a technician is assigned; cancelling after assignment may incur a small visit fee to cover the technician\'s travel time.'**
  String get termsSection2Body;

  /// No description provided for @termsSection3Title.
  ///
  /// In en, this message translates to:
  /// **'Payments'**
  String get termsSection3Title;

  /// No description provided for @termsSection3Body.
  ///
  /// In en, this message translates to:
  /// **'Service fees are shown before you confirm a booking and are payable to the technician on completion of the job. Soft Creative does not store your payment card details.'**
  String get termsSection3Body;

  /// No description provided for @termsSection4Title.
  ///
  /// In en, this message translates to:
  /// **'Technician Conduct'**
  String get termsSection4Title;

  /// No description provided for @termsSection4Body.
  ///
  /// In en, this message translates to:
  /// **'Technicians on Soft Creative are vetted and expected to arrive on time, treat your home with care, and only perform the work you booked. Report any issue from the booking detail screen and our support team will follow up.'**
  String get termsSection4Body;

  /// No description provided for @termsSection5Title.
  ///
  /// In en, this message translates to:
  /// **'Your Privacy'**
  String get termsSection5Title;

  /// No description provided for @termsSection5Body.
  ///
  /// In en, this message translates to:
  /// **'We collect your name, phone number, and address only to schedule and deliver your bookings. We never sell your personal information to third parties. You can request account deletion at any time from Contact Support.'**
  String get termsSection5Body;

  /// No description provided for @termsSection6Title.
  ///
  /// In en, this message translates to:
  /// **'Changes to These Terms'**
  String get termsSection6Title;

  /// No description provided for @termsSection6Body.
  ///
  /// In en, this message translates to:
  /// **'We may update these terms as Soft Creative adds new features. Continued use of the app after an update means you accept the revised terms.'**
  String get termsSection6Body;

  /// No description provided for @lastUpdatedLabel.
  ///
  /// In en, this message translates to:
  /// **'Last updated: September 2026'**
  String get lastUpdatedLabel;

  /// No description provided for @serviceDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Service details'**
  String get serviceDetailsTitle;

  /// No description provided for @verifiedProsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Verified professionals • Response in ~30 mins'**
  String get verifiedProsSubtitle;

  /// No description provided for @startingFromLabel.
  ///
  /// In en, this message translates to:
  /// **'Starting from'**
  String get startingFromLabel;

  /// No description provided for @whatsIncludedTitle.
  ///
  /// In en, this message translates to:
  /// **'What\'s included'**
  String get whatsIncludedTitle;

  /// No description provided for @bookThisServiceButton.
  ///
  /// In en, this message translates to:
  /// **'Book this service'**
  String get bookThisServiceButton;

  /// No description provided for @sharedFromAppMsg.
  ///
  /// In en, this message translates to:
  /// **'Shared from Soft Creative app'**
  String get sharedFromAppMsg;

  /// No description provided for @notificationsTooltip.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationsTooltip;

  /// No description provided for @serviceIdPrefix.
  ///
  /// In en, this message translates to:
  /// **'Service ID: {id}'**
  String serviceIdPrefix(String id);

  /// No description provided for @categoryElectrician.
  ///
  /// In en, this message translates to:
  /// **'Electrician'**
  String get categoryElectrician;

  /// No description provided for @categoryElectricianDesc.
  ///
  /// In en, this message translates to:
  /// **'Experienced electricians for wiring, fixture installs, and safety inspections, done right the first time.'**
  String get categoryElectricianDesc;

  /// No description provided for @categoryPlumber.
  ///
  /// In en, this message translates to:
  /// **'Plumber'**
  String get categoryPlumber;

  /// No description provided for @categoryPlumberDesc.
  ///
  /// In en, this message translates to:
  /// **'Reliable plumbing repairs and installations for leaks, clogs, and fittings around your home.'**
  String get categoryPlumberDesc;

  /// No description provided for @categoryAcRepair.
  ///
  /// In en, this message translates to:
  /// **'AC Repair'**
  String get categoryAcRepair;

  /// No description provided for @categoryAcRepairDesc.
  ///
  /// In en, this message translates to:
  /// **'Experience reliable air conditioning services with our team of highly skilled technicians. We specialize in AC installation, repair, deep cleaning, gas refilling, troubleshooting, and routine maintenance. Using modern equipment and quality parts, we ensure your cooling system delivers maximum comfort, energy efficiency, and long-lasting performance throughout the year.'**
  String get categoryAcRepairDesc;

  /// No description provided for @categoryTvRepair.
  ///
  /// In en, this message translates to:
  /// **'TV Repair'**
  String get categoryTvRepair;

  /// No description provided for @categoryTvRepairDesc.
  ///
  /// In en, this message translates to:
  /// **'Screen, sound, and power issues diagnosed and fixed by certified technicians.'**
  String get categoryTvRepairDesc;

  /// No description provided for @categoryPainter.
  ///
  /// In en, this message translates to:
  /// **'Painter'**
  String get categoryPainter;

  /// No description provided for @categoryPainterDesc.
  ///
  /// In en, this message translates to:
  /// **'Interior and exterior painting with clean prep work and quality finishes.'**
  String get categoryPainterDesc;

  /// No description provided for @categoryHomeCleaning.
  ///
  /// In en, this message translates to:
  /// **'Home Cleaning'**
  String get categoryHomeCleaning;

  /// No description provided for @categoryHomeCleaningDesc.
  ///
  /// In en, this message translates to:
  /// **'Deep cleaning for every room, using safe and effective products.'**
  String get categoryHomeCleaningDesc;

  /// No description provided for @categoryCookingRange.
  ///
  /// In en, this message translates to:
  /// **'Cooking Range'**
  String get categoryCookingRange;

  /// No description provided for @categoryCookingRangeDesc.
  ///
  /// In en, this message translates to:
  /// **'Repairs for gas and electric cooktops, burners, and ignition systems.'**
  String get categoryCookingRangeDesc;

  /// No description provided for @categoryWashingMachine.
  ///
  /// In en, this message translates to:
  /// **'Washing Machine'**
  String get categoryWashingMachine;

  /// No description provided for @categoryWashingMachineDesc.
  ///
  /// In en, this message translates to:
  /// **'Fixes for drainage, spin cycle, and motor issues on all major brands.'**
  String get categoryWashingMachineDesc;

  /// No description provided for @categoryFridgeRepair.
  ///
  /// In en, this message translates to:
  /// **'Fridge Repair'**
  String get categoryFridgeRepair;

  /// No description provided for @categoryFridgeRepairDesc.
  ///
  /// In en, this message translates to:
  /// **'Cooling, compressor, and seal repairs to keep your fridge running efficiently.'**
  String get categoryFridgeRepairDesc;

  /// No description provided for @includedWiringInspection.
  ///
  /// In en, this message translates to:
  /// **'Wiring Inspection'**
  String get includedWiringInspection;

  /// No description provided for @includedFixtureInstallation.
  ///
  /// In en, this message translates to:
  /// **'Fixture Installation'**
  String get includedFixtureInstallation;

  /// No description provided for @includedSafetyCheck.
  ///
  /// In en, this message translates to:
  /// **'Safety Check'**
  String get includedSafetyCheck;

  /// No description provided for @includedLeakDetection.
  ///
  /// In en, this message translates to:
  /// **'Leak Detection'**
  String get includedLeakDetection;

  /// No description provided for @includedPipeRepair.
  ///
  /// In en, this message translates to:
  /// **'Pipe Repair'**
  String get includedPipeRepair;

  /// No description provided for @includedFixtureInstall.
  ///
  /// In en, this message translates to:
  /// **'Fixture Install'**
  String get includedFixtureInstall;

  /// No description provided for @includedAcInspection.
  ///
  /// In en, this message translates to:
  /// **'AC Inspection'**
  String get includedAcInspection;

  /// No description provided for @includedGasLevelCheck.
  ///
  /// In en, this message translates to:
  /// **'Gas Level Check'**
  String get includedGasLevelCheck;

  /// No description provided for @includedCleaningMaintenance.
  ///
  /// In en, this message translates to:
  /// **'Cleaning & Maintenance'**
  String get includedCleaningMaintenance;

  /// No description provided for @includedDiagnostics.
  ///
  /// In en, this message translates to:
  /// **'Diagnostics'**
  String get includedDiagnostics;

  /// No description provided for @includedScreenBoardRepair.
  ///
  /// In en, this message translates to:
  /// **'Screen/Board Repair'**
  String get includedScreenBoardRepair;

  /// No description provided for @includedSoftwareCheck.
  ///
  /// In en, this message translates to:
  /// **'Software Check'**
  String get includedSoftwareCheck;

  /// No description provided for @includedSurfacePrep.
  ///
  /// In en, this message translates to:
  /// **'Surface Prep'**
  String get includedSurfacePrep;

  /// No description provided for @includedPainting.
  ///
  /// In en, this message translates to:
  /// **'Painting'**
  String get includedPainting;

  /// No description provided for @includedCleanup.
  ///
  /// In en, this message translates to:
  /// **'Cleanup'**
  String get includedCleanup;

  /// No description provided for @includedDusting.
  ///
  /// In en, this message translates to:
  /// **'Dusting'**
  String get includedDusting;

  /// No description provided for @includedMopping.
  ///
  /// In en, this message translates to:
  /// **'Mopping'**
  String get includedMopping;

  /// No description provided for @includedSanitizing.
  ///
  /// In en, this message translates to:
  /// **'Sanitizing'**
  String get includedSanitizing;

  /// No description provided for @includedBurnerCheck.
  ///
  /// In en, this message translates to:
  /// **'Burner Check'**
  String get includedBurnerCheck;

  /// No description provided for @includedIgnitionRepair.
  ///
  /// In en, this message translates to:
  /// **'Ignition Repair'**
  String get includedIgnitionRepair;

  /// No description provided for @includedGasLeakCheck.
  ///
  /// In en, this message translates to:
  /// **'Gas Leak Check'**
  String get includedGasLeakCheck;

  /// No description provided for @includedDrainageCheck.
  ///
  /// In en, this message translates to:
  /// **'Drainage Check'**
  String get includedDrainageCheck;

  /// No description provided for @includedMotorInspection.
  ///
  /// In en, this message translates to:
  /// **'Motor Inspection'**
  String get includedMotorInspection;

  /// No description provided for @includedCycleTest.
  ///
  /// In en, this message translates to:
  /// **'Cycle Test'**
  String get includedCycleTest;

  /// No description provided for @includedCoolingCheck.
  ///
  /// In en, this message translates to:
  /// **'Cooling Check'**
  String get includedCoolingCheck;

  /// No description provided for @includedCompressorTest.
  ///
  /// In en, this message translates to:
  /// **'Compressor Test'**
  String get includedCompressorTest;

  /// No description provided for @includedSealRepair.
  ///
  /// In en, this message translates to:
  /// **'Seal Repair'**
  String get includedSealRepair;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'km'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'km':
      return AppLocalizationsKm();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
