import 'package:hive_flutter/hive_flutter.dart';
import '../models/attempt.dart';

class AttemptService {
  static const String _boxName = 'attempts_box';

  Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(_boxName);
  }

  Box get _box => Hive.box(_boxName);

  Future<void> saveAttempt(Attempt attempt) async {
    await _box.add(attempt.toJson());
  }

  List<Attempt> getAllAttempts() {
    return _box.values
        .map((e) => Attempt.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  List<Attempt> getLastAttempts(int count) {
    final all = getAllAttempts();
    if (all.isEmpty) return [];
    return all.reversed.take(count).toList();
  }

  Future<void> clearHistory() async {
    await _box.clear();
  }
}
