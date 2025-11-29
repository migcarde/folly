// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get today => 'Today';

  @override
  String get required_field => 'Required field';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get username => 'Username';

  @override
  String get tell_something_about_you => 'Tell something about you';

  @override
  String get login => 'Login';

  @override
  String get register => 'Register';

  @override
  String get configuration => 'Configuration';

  @override
  String get logout => 'Logout';

  @override
  String get repeat_password => 'Repeat password';

  @override
  String get user_already_registered_please_use_another_email =>
      'User is already registered, please, use another email';

  @override
  String get name_is_required => 'Name is required';

  @override
  String get invalid_credentials_please_try_again =>
      'Invalid credentials, please, try again';

  @override
  String get sorry_we_have_problems_please_try_again_later =>
      'Sorry we have problems, please, try again later';

  @override
  String get are_you_not_registered_question => 'Are you not registered?';

  @override
  String get password_does_not_match => 'Passwords doesn\'t match';

  @override
  String get passwords_is_weak =>
      'Password is weak, please use a password that has at least 8 letters, one of them in upper case and another one in lowe case, one number and one special character (@#\$%^&)';

  @override
  String get email_not_valid => 'Email not valid';

  @override
  String get username_already_in_use => 'Username already in use';

  @override
  String get name => 'Name';

  @override
  String get change_language => 'Change language';

  @override
  String get english => 'English';

  @override
  String get spanish => 'Spanish';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get delete_account => 'Delete account';

  @override
  String get are_you_sure => 'Are you sure?';

  @override
  String
  get all_data_related_to_this_account_will_be_deleted_and_cannot_be_recovered =>
      'All data related to this account will be deleted and cannot be recovered.';

  @override
  String get you_must_enter_your_credentials_again_to_delete_your_account =>
      'You must delete your credentials again to delete your account.';

  @override
  String get challenge_time => 'Challenge time!';

  @override
  String get publish_a_story => 'Publish a story';

  @override
  String get camera => 'Camera';

  @override
  String get video => 'Video';

  @override
  String get gallery => 'Gallery';

  @override
  String get title => 'Title';

  @override
  String get invalid_file_type => 'Invalid file type';

  @override
  String get please_use_one_of_these => 'Please, use one of these';

  @override
  String get accept => 'Accept';

  @override
  String get story_published => 'Story published';

  @override
  String get challenge => 'Challenge';

  @override
  String get cannot_post_story_after_challenge_completed =>
      'You cannot post a story after you have completed the challenge.';

  @override
  String get user_settings => 'User settings';

  @override
  String get change_password => 'Change password';

  @override
  String get profile_updated => 'Profile updated';

  @override
  String get password_reset_email_send => 'Password reset email sent';

  @override
  String you_must_type_at_least_x_characters(int number) {
    return 'You must type at least $number characters';
  }

  @override
  String get user_banned => 'User banned';
}
