// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get today => 'Hoy';

  @override
  String get required_field => 'Campo obligatorio';

  @override
  String get email => 'Correo';

  @override
  String get password => 'Contraseña';

  @override
  String get username => 'Nombre de usuario';

  @override
  String get tell_something_about_you => 'Cuenta algo sobre ti';

  @override
  String get login => 'Login';

  @override
  String get register => 'Registrar';

  @override
  String get configuration => 'Configuración';

  @override
  String get logout => 'Cerrar sesión';

  @override
  String get repeat_password => 'Repetir contraseña';

  @override
  String get user_already_registered_please_use_another_email =>
      'Usuario registrado, por favor, usa otro correo';

  @override
  String get name_is_required => 'El nombre es obligatorio';

  @override
  String get invalid_credentials_please_try_again =>
      'Las credenciales no son válidas, por favor, inténtalo de nuevo';

  @override
  String get sorry_we_have_problems_please_try_again_later =>
      'Ha ocurrido un problema inesperado, por favor, inténtalo de nuevo más tarde';

  @override
  String get are_you_not_registered_question => '¿No estás registrado?';

  @override
  String get password_does_not_match => 'Las contraseñas no coinciden';

  @override
  String get passwords_is_weak =>
      'La contraseña es débil, por favor, usa contraseña con al menos 8 letras, una de ellas en mayúsculas, un número y un carácter especial (@#\$%^&)';

  @override
  String get email_not_valid => 'Correo no válido';

  @override
  String get username_already_in_use => 'Nombre de usuario en uso';

  @override
  String get name => 'Nombre';

  @override
  String get change_language => 'Cambiar idioma';

  @override
  String get english => 'Inglés';

  @override
  String get spanish => 'Español';

  @override
  String get save => 'Guardar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get delete => 'Borrar';

  @override
  String get delete_account => 'Eliminar cuenta';

  @override
  String get are_you_sure => '¿Estás seguro?';

  @override
  String
  get all_data_related_to_this_account_will_be_deleted_and_cannot_be_recovered =>
      'Toda la información asociada a esta cuenta será borrada y no podrá ser recuperada.';

  @override
  String get you_must_enter_your_credentials_again_to_delete_your_account =>
      'Vuelve a escribir tus credenciales para eliminar tu cuenta.';

  @override
  String get challenge_time => '¡Hora del reto!';

  @override
  String get publish_a_story => 'Publica una historia';

  @override
  String get camera => 'Cámara';

  @override
  String get video => 'Vídeo';

  @override
  String get gallery => 'Galería';

  @override
  String get title => 'Título';

  @override
  String get invalid_file_type => 'Archivo no soportado';

  @override
  String get please_use_one_of_these => 'Por favor, usa uno de estos tipos';

  @override
  String get accept => 'Aceptar';

  @override
  String get story_published => 'Historia publicada';

  @override
  String get challenge => 'Reto';

  @override
  String get cannot_post_story_after_challenge_completed =>
      'No puedes publicar una historia una vez que has completado el reto.';

  @override
  String get user_settings => 'Modificar perfil';

  @override
  String get change_password => 'Cambiar contraseña';

  @override
  String get profile_updated => 'Perfil actualizado';

  @override
  String get password_reset_email_send =>
      'Se le ha enviado un correo para restablecer la contraseña';

  @override
  String you_must_type_at_least_x_characters(int number) {
    return 'Debes escribir al menos $number letras';
  }
}
