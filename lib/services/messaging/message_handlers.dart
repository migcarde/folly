import 'package:folly/services/messaging/app_messaging_types.dart';

Future<void> manageMessage(Map<String, dynamic> message) async {
  final type = AppMessagingTypes.fromString(message['type']);
  switch (type) {
    case AppMessagingTypes.challengeReminder:
      // final messageEntity = ChallengeReminderNotificationEntity.fromJson(
      //   message,
      // );
      // _handleChallengeNotification(messageEntity);
      break;
    case AppMessagingTypes.none:
      break;
  }
}

// Future<void> _handleChallengeNotification(
//   BirthdayReminderNotificationEntity birthdayReminder,
// ) async {
//   final (result, l10n) = await (
//     getIt<GetBirthday>().call(birthdayReminder.birthdayId),
//     AppLocalizations.delegate.load(birthdayReminder.locale),
//   ).wait;

//   result.when(
//     (birthday) async {
//       if (birthday != null) {
//         final greeting = await getIt<GeminiService>().generateGreeting(
//           name: birthday.name,
//           characteristics: birthday.characteristics,
//           userGender: birthdayReminder.userGender.getText(l10n),
//           l10n: l10n,
//         );
//         await getIt<SaveBirthdayGreeting>().call(
//           SaveBirthdayGreetingParams(
//             birthdayId: birthday.id,
//             date: DateTime.now(),
//             text: greeting,
//             uid: birthday.uid,
//           ),
//         );
//         await getIt<TodayCubit>().init();
//       }
//     },
//     (_) {
//       // Does not do nothing
//     },
//   );
// }
