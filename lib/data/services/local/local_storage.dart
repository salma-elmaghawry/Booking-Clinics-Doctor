import 'package:hive_flutter/adapters.dart';

// ! Don't forget to write the type of [T] only in service_locator.dart for each box you open.
final class LocalStorage<T> {
  // ? _____ Open Boxes in main.dart as Many as We Need  _____ ? //
  Future<void> open(String boxName) async {
    await Hive.openBox<T>(boxName);
  }

  // ? _____ Put or Update Data _____ ? //
  Future<void> save({
    required String box,
    required String key,
    required T data,
  }) async {
    await _getBox(box).put(key, data);
  }

  // ? _____ Read Data From Box _____ ? //
  T? invoke({required String box, required String key}) =>
      _getBox(box).get(key);

  // ? _____ Get Box _____ ? //
  Box<T> _getBox(String boxName) => Hive.box<T>(boxName);
}
