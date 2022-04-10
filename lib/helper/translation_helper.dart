import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';


//kullanılan yapılarda telefonun dil seçeneğine göre yapının dilini değiştiren method yazıldı
class TranslationHelper {
  TranslationHelper._();

  static getDeviceLocal(BuildContext context) {
    var deviceLanguage = context.deviceLocale.countryCode!.toLowerCase();

    switch (deviceLanguage) {
      case "tr":
        return LocaleType.tr;
      case "en":
        return LocaleType.en;
    }
  }
}
