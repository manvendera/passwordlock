import 'package:flutter/foundation.dart';
import '../models/attempt.dart';
import '../services/attempt_service.dart';

class AttemptProvider with ChangeNotifier {
  final AttemptService _service = AttemptService();
  List<Attempt> _lastAttempts = [];
  bool _isInitialized = false;

  List<Attempt> get lastAttempts => _lastAttempts;
  bool get isInitialized => _isInitialized;

  Future<void> initialize() async {
    await _service.init();
    _lastAttempts = _service.getLastAttempts(3);
    _isInitialized = true;
    notifyListeners();
  }

  Future<void> recordAttempt(String pin, bool isSuccess) async {
    final allAttempts = _service.getAllAttempts();
    final attempt = Attempt(
      attemptNumber: allAttempts.length + 1,
      pin: pin,
      timestamp: DateTime.now(),
      isSuccess: isSuccess,
    );

    await _service.saveAttempt(attempt);
    _lastAttempts = _service.getLastAttempts(3);
    notifyListeners();
  }

  Future<void> clearLogs() async {
    await _service.clearHistory();
    _lastAttempts = [];
    notifyListeners();
  }
}
