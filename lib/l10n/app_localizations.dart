import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

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
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @quran.
  ///
  /// In en, this message translates to:
  /// **'Quran'**
  String get quran;

  /// No description provided for @adhkar.
  ///
  /// In en, this message translates to:
  /// **'Adhkar'**
  String get adhkar;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @continueReading.
  ///
  /// In en, this message translates to:
  /// **'Continue Reading'**
  String get continueReading;

  /// No description provided for @qibla.
  ///
  /// In en, this message translates to:
  /// **'Qibla'**
  String get qibla;

  /// No description provided for @finder.
  ///
  /// In en, this message translates to:
  /// **'Finder'**
  String get finder;

  /// No description provided for @remembrance.
  ///
  /// In en, this message translates to:
  /// **'Remembrance'**
  String get remembrance;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @rateApp.
  ///
  /// In en, this message translates to:
  /// **'Rate App'**
  String get rateApp;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @asrPrayer.
  ///
  /// In en, this message translates to:
  /// **'Asr Prayer'**
  String get asrPrayer;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Minya, Egypt'**
  String get location;

  /// No description provided for @errorLoadingPrayerTimes.
  ///
  /// In en, this message translates to:
  /// **'Error loading prayer times'**
  String get errorLoadingPrayerTimes;

  /// No description provided for @chooseYourLanguage.
  ///
  /// In en, this message translates to:
  /// **'Choose your language'**
  String get chooseYourLanguage;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @arabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get arabic;

  /// No description provided for @prayerTimes.
  ///
  /// In en, this message translates to:
  /// **'Prayer Times'**
  String get prayerTimes;

  /// No description provided for @todayVerse.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Ayah'**
  String get todayVerse;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @morningEvening.
  ///
  /// In en, this message translates to:
  /// **'Morning & Evening'**
  String get morningEvening;

  /// No description provided for @upNext.
  ///
  /// In en, this message translates to:
  /// **'Up Next'**
  String get upNext;

  /// No description provided for @surah.
  ///
  /// In en, this message translates to:
  /// **'Surah'**
  String get surah;

  /// No description provided for @dailyAyah.
  ///
  /// In en, this message translates to:
  /// **'Daily Ayah'**
  String get dailyAyah;

  /// No description provided for @hardshipEase.
  ///
  /// In en, this message translates to:
  /// **'Indeed, with hardship comes ease.'**
  String get hardshipEase;

  /// No description provided for @surahAshSharh.
  ///
  /// In en, this message translates to:
  /// **'Surah Ash-Sharh'**
  String get surahAshSharh;

  /// No description provided for @assalamuAlaikum.
  ///
  /// In en, this message translates to:
  /// **'Assalamu Alaikum'**
  String get assalamuAlaikum;

  /// No description provided for @todayPrayers.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Prayers'**
  String get todayPrayers;

  /// No description provided for @fajr.
  ///
  /// In en, this message translates to:
  /// **'Fajr'**
  String get fajr;

  /// No description provided for @dhuhr.
  ///
  /// In en, this message translates to:
  /// **'Dhuhr'**
  String get dhuhr;

  /// No description provided for @asr.
  ///
  /// In en, this message translates to:
  /// **'Asr'**
  String get asr;

  /// No description provided for @maghrib.
  ///
  /// In en, this message translates to:
  /// **'Maghrib'**
  String get maghrib;

  /// No description provided for @isha.
  ///
  /// In en, this message translates to:
  /// **'Isha'**
  String get isha;

  /// No description provided for @goodMorning.
  ///
  /// In en, this message translates to:
  /// **'Good Morning'**
  String get goodMorning;

  /// No description provided for @goodAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Good Afternoon'**
  String get goodAfternoon;

  /// No description provided for @goodEvening.
  ///
  /// In en, this message translates to:
  /// **'Good Evening'**
  String get goodEvening;

  /// No description provided for @morningAdhkar.
  ///
  /// In en, this message translates to:
  /// **'Morning Adhkar'**
  String get morningAdhkar;

  /// No description provided for @eveningAdhkar.
  ///
  /// In en, this message translates to:
  /// **'Evening Adhkar'**
  String get eveningAdhkar;

  /// No description provided for @morningSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Start your day with remembrance'**
  String get morningSubtitle;

  /// No description provided for @eveningSubtitle.
  ///
  /// In en, this message translates to:
  /// **'End your day with remembrance'**
  String get eveningSubtitle;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @remaining.
  ///
  /// In en, this message translates to:
  /// **'Remaining'**
  String get remaining;

  /// No description provided for @appName.
  String get appName;

  /// No description provided for @appTagline.
  String get appTagline;

  /// No description provided for @morning.
  String get morning;

  /// No description provided for @evening.
  String get evening;

  /// No description provided for @aboutApp.
  String get aboutApp;

  /// No description provided for @aboutAppDescription.
  String get aboutAppDescription;

  /// No description provided for @features.
  String get features;

  /// No description provided for @featuresList.
  String get featuresList;

  /// No description provided for @version.
  String get version;

  /// No description provided for @versionNumber.
  String get versionNumber;

  /// No description provided for @madeWithLove.
  String get madeWithLove;

  /// No description provided for @madeWithLoveDescription.
  String get madeWithLoveDescription;

  /// No description provided for @notificationSettings.
  String get notificationSettings;

  /// No description provided for @prayerTimesNotification.
  String get prayerTimesNotification;

  /// No description provided for @prayerTimesNotificationDescription.
  String get prayerTimesNotificationDescription;

  /// No description provided for @dailyAzkarNotification.
  String get dailyAzkarNotification;

  /// No description provided for @dailyAzkarNotificationDescription.
  String get dailyAzkarNotificationDescription;

  /// No description provided for @dailyQuranNotification.
  String get dailyQuranNotification;

  /// No description provided for @dailyQuranNotificationDescription.
  String get dailyQuranNotificationDescription;

  /// No description provided for @ratePageTitle.
  String get ratePageTitle;

  /// No description provided for @enjoyingApp.
  String get enjoyingApp;

  /// No description provided for @feedbackHelp.
  String get feedbackHelp;

  /// No description provided for @thankYouRating.
  String get thankYouRating;

  /// No description provided for @submitRating.
  String get submitRating;

  /// No description provided for @pleaseFillAllFields.
  String get pleaseFillAllFields;

  /// No description provided for @yourName.
  String get yourName;

  /// No description provided for @saving.
  String get saving;

  /// No description provided for @welcomeToApp.
  String get welcomeToApp;

  /// No description provided for @tellUsYourName.
  String get tellUsYourName;

  /// No description provided for @pleaseEnterYourName.
  String get pleaseEnterYourName;

  /// No description provided for @pleaseEnterYourLocation.
  String get pleaseEnterYourLocation;

  /// No description provided for @pleaseTryAgain.
  String get pleaseTryAgain;

  /// No description provided for @capitalCity.
  String get capitalCity;

  /// No description provided for @searchCapitalCity.
  String get searchCapitalCity;

  /// No description provided for @pleaseChooseCapitalCity.
  String get pleaseChooseCapitalCity;

  /// No description provided for @pleaseSelectCityFromList.
  String get pleaseSelectCityFromList;

  /// No description provided for @unableToCheckDeviceSupport.
  String get unableToCheckDeviceSupport;

  /// No description provided for @compassNotSupported.
  String get compassNotSupported;

  /// No description provided for @deviceDoesNotSupportCompass.
  String get deviceDoesNotSupportCompass;

  /// No description provided for @unableToGetLocationStatus.
  String get unableToGetLocationStatus;

  /// No description provided for @locationServiceDisabled.
  String get locationServiceDisabled;

  /// No description provided for @enableLocationServices.
  String get enableLocationServices;

  /// No description provided for @openLocationSettings.
  String get openLocationSettings;

  /// No description provided for @permissionDeniedForever.
  String get permissionDeniedForever;

  /// No description provided for @locationPermissionRequired.
  String get locationPermissionRequired;

  /// No description provided for @grantLocationPermission.
  String get grantLocationPermission;

  /// No description provided for @allowPermission.
  String get allowPermission;

  /// No description provided for @openAppSettings.
  String get openAppSettings;

  /// No description provided for @unableToReadCompassValues.
  String get unableToReadCompassValues;

  /// No description provided for @qiblaDirection.
  String get qiblaDirection;

  /// No description provided for @pointYourPhoneTowardKaaba.
  String get pointYourPhoneTowardKaaba;

  /// No description provided for @refresh.
  String get refresh;

  /// No description provided for @personalSettings.
  String get personalSettings;

  /// No description provided for @editProfile.
  String get editProfile;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
