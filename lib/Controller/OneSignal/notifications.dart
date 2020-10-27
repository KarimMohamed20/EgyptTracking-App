import 'dart:io';

import 'package:app/Controller/API/config.dart';
import 'package:device_info/device_info.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class OneSignalNotifications {
  connect(String email) async {
    if (Platform.isIOS == true) {
      var deviceId = await DeviceInfoPlugin().iosInfo;
      await OneSignal.shared.init(EnvData.oneSignalAppId);
      await OneSignal.shared.setExternalUserId(deviceId.identifierForVendor);
    } else if (Platform.isAndroid == true) {
      var deviceId = await DeviceInfoPlugin().androidInfo;
      await OneSignal.shared.init(EnvData.oneSignalAppId);
      await OneSignal.shared.setExternalUserId(deviceId.androidId);
    }
  }
}
