import 'package:hive_flutter/hive_flutter.dart';

const String dataFinger = "DataFinger";

class HiveHelper {
  static init() async {
    await Hive.initFlutter();

    await openDataFingerBox();
  }

  static Future<Box> openDataFingerBox() async {
    return await Hive.openBox(dataFinger);
  }

  Future<void> closeBoxs() async {
    return await Hive.close();
  }

  getData(String key) {
    final prayerBox = Hive.box(dataFinger);
    return prayerBox.get(key);
  }

  removeData(String key) {
    final prayerBox = Hive.box(dataFinger);
    return prayerBox.delete(key);
  }

  Future<void> putData(String key, dynamic value) async {
    final prayerBox = Hive.box(dataFinger);
    return prayerBox.put(key, value);
  }
}
