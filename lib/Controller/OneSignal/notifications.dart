import 'package:app/Controller/API/config.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class OneSignalNotifications {
  connect(String email) async {
    await OneSignal.shared.init(EnvData.oneSignalAppId);
    await OneSignal.shared.setEmail(email: email);
  }
}
