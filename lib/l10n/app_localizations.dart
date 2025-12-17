import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

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

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
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
    Locale('es'),
  ];

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @required_field.
  ///
  /// In en, this message translates to:
  /// **'Required field'**
  String get required_field;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// No description provided for @tell_something_about_you.
  ///
  /// In en, this message translates to:
  /// **'Tell something about you'**
  String get tell_something_about_you;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @configuration.
  ///
  /// In en, this message translates to:
  /// **'Configuration'**
  String get configuration;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @repeat_password.
  ///
  /// In en, this message translates to:
  /// **'Repeat password'**
  String get repeat_password;

  /// No description provided for @user_already_registered_please_use_another_email.
  ///
  /// In en, this message translates to:
  /// **'User is already registered, please, use another email'**
  String get user_already_registered_please_use_another_email;

  /// No description provided for @name_is_required.
  ///
  /// In en, this message translates to:
  /// **'Name is required'**
  String get name_is_required;

  /// No description provided for @invalid_credentials_please_try_again.
  ///
  /// In en, this message translates to:
  /// **'Invalid credentials, please, try again'**
  String get invalid_credentials_please_try_again;

  /// No description provided for @sorry_we_have_problems_please_try_again_later.
  ///
  /// In en, this message translates to:
  /// **'Sorry we have problems, please, try again later'**
  String get sorry_we_have_problems_please_try_again_later;

  /// No description provided for @are_you_not_registered_question.
  ///
  /// In en, this message translates to:
  /// **'Are you not registered?'**
  String get are_you_not_registered_question;

  /// No description provided for @password_does_not_match.
  ///
  /// In en, this message translates to:
  /// **'Passwords doesn\'t match'**
  String get password_does_not_match;

  /// No description provided for @passwords_is_weak.
  ///
  /// In en, this message translates to:
  /// **'Password is weak, please use a password that has at least 8 letters, one of them in upper case and another one in lowe case, one number and one special character (@#\$%^&)'**
  String get passwords_is_weak;

  /// No description provided for @email_not_valid.
  ///
  /// In en, this message translates to:
  /// **'Email not valid'**
  String get email_not_valid;

  /// No description provided for @username_already_in_use.
  ///
  /// In en, this message translates to:
  /// **'Username already in use'**
  String get username_already_in_use;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @change_language.
  ///
  /// In en, this message translates to:
  /// **'Change language'**
  String get change_language;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @spanish.
  ///
  /// In en, this message translates to:
  /// **'Spanish'**
  String get spanish;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @delete_account.
  ///
  /// In en, this message translates to:
  /// **'Delete account'**
  String get delete_account;

  /// No description provided for @are_you_sure.
  ///
  /// In en, this message translates to:
  /// **'Are you sure?'**
  String get are_you_sure;

  /// No description provided for @all_data_related_to_this_account_will_be_deleted_and_cannot_be_recovered.
  ///
  /// In en, this message translates to:
  /// **'All data related to this account will be deleted and cannot be recovered.'**
  String
  get all_data_related_to_this_account_will_be_deleted_and_cannot_be_recovered;

  /// No description provided for @you_must_enter_your_credentials_again_to_delete_your_account.
  ///
  /// In en, this message translates to:
  /// **'You must delete your credentials again to delete your account.'**
  String get you_must_enter_your_credentials_again_to_delete_your_account;

  /// No description provided for @challenge_time.
  ///
  /// In en, this message translates to:
  /// **'Challenge time!'**
  String get challenge_time;

  /// No description provided for @publish_a_story.
  ///
  /// In en, this message translates to:
  /// **'Publish a story'**
  String get publish_a_story;

  /// No description provided for @camera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get camera;

  /// No description provided for @video.
  ///
  /// In en, this message translates to:
  /// **'Video'**
  String get video;

  /// No description provided for @gallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get gallery;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title;

  /// No description provided for @invalid_file_type.
  ///
  /// In en, this message translates to:
  /// **'Invalid file type'**
  String get invalid_file_type;

  /// No description provided for @please_use_one_of_these.
  ///
  /// In en, this message translates to:
  /// **'Please, use one of these'**
  String get please_use_one_of_these;

  /// No description provided for @accept.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get accept;

  /// No description provided for @story_published.
  ///
  /// In en, this message translates to:
  /// **'Story published'**
  String get story_published;

  /// No description provided for @challenge.
  ///
  /// In en, this message translates to:
  /// **'Challenge'**
  String get challenge;

  /// No description provided for @cannot_post_story_after_challenge_completed.
  ///
  /// In en, this message translates to:
  /// **'You cannot post a story after you have completed the challenge.'**
  String get cannot_post_story_after_challenge_completed;

  /// No description provided for @user_settings.
  ///
  /// In en, this message translates to:
  /// **'User settings'**
  String get user_settings;

  /// No description provided for @change_password.
  ///
  /// In en, this message translates to:
  /// **'Change password'**
  String get change_password;

  /// No description provided for @profile_updated.
  ///
  /// In en, this message translates to:
  /// **'Profile updated'**
  String get profile_updated;

  /// No description provided for @password_reset_email_send.
  ///
  /// In en, this message translates to:
  /// **'Password reset email sent'**
  String get password_reset_email_send;

  /// No description provided for @you_must_type_at_least_x_characters.
  ///
  /// In en, this message translates to:
  /// **'You must type at least {number} characters'**
  String you_must_type_at_least_x_characters(int number);

  /// No description provided for @user_banned.
  ///
  /// In en, this message translates to:
  /// **'User banned'**
  String get user_banned;

  /// No description provided for @follow.
  ///
  /// In en, this message translates to:
  /// **'Follow'**
  String get follow;

  /// No description provided for @decline.
  ///
  /// In en, this message translates to:
  /// **'Decline'**
  String get decline;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// No description provided for @following.
  ///
  /// In en, this message translates to:
  /// **'Following'**
  String get following;

  /// No description provided for @followers.
  ///
  /// In en, this message translates to:
  /// **'Followers'**
  String get followers;

  /// No description provided for @reply_to.
  ///
  /// In en, this message translates to:
  /// **'Reply to {name}'**
  String reply_to(String name);

  /// No description provided for @comments.
  ///
  /// In en, this message translates to:
  /// **'Comments'**
  String get comments;

  /// No description provided for @write_a_comment.
  ///
  /// In en, this message translates to:
  /// **'Write a comment'**
  String get write_a_comment;

  /// No description provided for @no_yet.
  ///
  /// In en, this message translates to:
  /// **'No {name} yet'**
  String no_yet(String name);
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
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
