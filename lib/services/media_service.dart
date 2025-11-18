import 'package:domain/base/result.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as p;

enum MediaErrors {
  noFileSelected,
  invalidImageExtension,
  invalidVideoExtension,
}

class MediaService {
  static const supportedImageExtensions = [
    '.jpg',
    '.jpeg',
    '.png',
    '.gif',
    '.webp',
    '.bmp',
    '.tiff',
  ];

  static const supportedVideoExtensions = [
    '.mp4',
    '.mov',
    '.3gp',
    '.webm',
    '.mkv',
    '.avi',
    '.m4v',
  ];

  static Future<XFile?> openCamera() async {
    final permission = await Permission.camera.status;

    if (!permission.isGranted) {
      final requestPermission = await Permission.camera.request();

      if (!requestPermission.isGranted) {
        return null;
      }
    }

    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.camera);

    return image;
  }

  static Future<XFile?> openVideo() async {
    final permission = await Permission.camera.status;

    if (!permission.isGranted) {
      final requestPermission = await Permission.camera.request();

      if (!requestPermission.isGranted) {
        return null;
      }
    }

    final picker = ImagePicker();
    final image = await picker.pickVideo(source: ImageSource.camera);

    return image;
  }

  static Future<Result<XFile>> openGallery() async {
    final picker = ImagePicker();
    final media = await picker.pickMedia();
    final fileExtension = p.extension(media?.path ?? '').toLowerCase();

    if (!supportedImageExtensions.contains(fileExtension) &&
        !supportedVideoExtensions.contains(fileExtension)) {
      return Result.failure(MediaErrors.invalidImageExtension);
    } else if (media != null) {
      return Result.success(media);
    } else {
      return Result.failure(MediaErrors.noFileSelected);
    }
  }

  static Future<XFile?> openImageGallery() async {
    final picker = ImagePicker();
    final media = await picker.pickImage(source: ImageSource.gallery);

    return media;
  }

  static bool isVideo(String url) {
    final fileExtension = p.extension(url).toLowerCase();
    return supportedVideoExtensions.contains(fileExtension);
  }
}
