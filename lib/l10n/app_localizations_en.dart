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

  @override
  String get follow => 'Follow';

  @override
  String get decline => 'Decline';

  @override
  String get pending => 'Pending';

  @override
  String get following => 'Following';

  @override
  String get followers => 'Followers';

  @override
  String reply_to(String name) {
    return 'Reply to $name';
  }

  @override
  String get comments => 'Comments';

  @override
  String get write_a_comment => 'Write a comment';

  @override
  String no_yet(String name) {
    return 'No $name yet';
  }

  @override
  String replying_to(String name) {
    return 'Replying to @$name';
  }

  @override
  String get more_replies => 'More replies';

  @override
  String get send => 'Send';

  @override
  String get password_reset_email_sent_check_your_inbox =>
      'Password reset email sent, check your inbox';

  @override
  String get does_not_remember_your_password =>
      'Don\'t remember your password?';

  @override
  String get password_changed => 'Password changed';

  @override
  String get likes_your_story => 'Likes your story';

  @override
  String get comments_on_your_story => 'Comments your story';

  @override
  String get is_following_you => 'Is following you';

  @override
  String year(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count years',
      one: '$count year',
    );
    return '$_temp0';
  }

  @override
  String month(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count months',
      one: '$count month',
    );
    return '$_temp0';
  }

  @override
  String day(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count days',
      one: '$count day',
    );
    return '$_temp0';
  }

  @override
  String hour(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count hours',
      one: '$count hour',
    );
    return '$_temp0';
  }

  @override
  String minute(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count minutes',
      one: '$count minute',
    );
    return '$_temp0';
  }

  @override
  String get now => 'Now';

  @override
  String get no_stories_yet => 'No stories yet';

  @override
  String get tap_to_search_friends_and_start_sharing_your_stories_toguether =>
      'Tap to search friends and start sharing your stories toguether!';

  @override
  String get search => 'Search';

  @override
  String get unleash_your_creativity_tap_to_upload_your_stories =>
      'Unleash your creativity! Tap to upload your stories ';

  @override
  String get this_user_does_not_publish_any_story_yet =>
      'This user does not publish any story yet';

  @override
  String get show_more => 'Show more';

  @override
  String get show_less => 'Show less';

  @override
  String user(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Users',
      one: 'User',
      zero: 'No users found',
    );
    return '$_temp0';
  }

  @override
  String get oops_something_went_wrong => 'Oops, something went wrong';

  @override
  String get please_try_again_later => 'Please try again later';

  @override
  String get describe_what_happend => 'Describe what happend';

  @override
  String
  get please_add_a_screenshot_or_a_video_of_the_reason_why_you_have_reported_this_user =>
      'Please add a screenshot or a video of the reason why you have reported this user';

  @override
  String get upload_file => 'Upload file';

  @override
  String get report => 'Report';

  @override
  String get report_sent_successfully => 'Report sent successfully';

  @override
  String get this_action_cannot_be_undone => 'This action cannot be undone';
}
