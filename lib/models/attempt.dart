class Attempt {
  final int attemptNumber;
  final String pin;
  final DateTime timestamp;
  final bool isSuccess;

  Attempt({
    required this.attemptNumber,
    required this.pin,
    required this.timestamp,
    required this.isSuccess,
  });

  Map<String, dynamic> toJson() => {
        'attemptNumber': attemptNumber,
        'pin': pin,
        'timestamp': timestamp.toIso8601String(),
        'isSuccess': isSuccess,
      };

  factory Attempt.fromJson(Map<String, dynamic> json) => Attempt(
        attemptNumber: json['attemptNumber'],
        pin: json['pin'],
        timestamp: DateTime.parse(json['timestamp']),
        isSuccess: json['isSuccess'],
      );
}
