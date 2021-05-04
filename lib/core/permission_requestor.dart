import 'package:photo_manager/photo_manager.dart';

class PermissionRequestor {
  Future<void> init() async {
    await _requestPhotoManager();
  }

  Future<void> _requestPhotoManager() async {
    var result = await PhotoManager.requestPermission();

    /// if result is fail, you can call `PhotoManager.openSetting();`  to open android/ios applicaton's setting to get permission
    if (!result) {
      PhotoManager.openSetting();
    }
  }
}
