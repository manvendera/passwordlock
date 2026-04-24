import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/attempt.dart';

class AttemptHistoryPanel extends StatelessWidget {
  final List<Attempt> attempts;
  final VoidCallback onClear;

  const AttemptHistoryPanel({
    super.key,
    required this.attempts,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Attempt History (Plain Text)',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                ),
              ),
              IconButton(
                onPressed: onClear,
                icon: const Icon(Icons.delete_outline, color: Colors.grey),
              ),
            ],
          ),
          const Divider(),
          if (attempts.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Center(child: Text('No attempts recorded yet.')),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              itemCount: attempts.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                final attempt = attempts[index];
                final time = DateFormat('HH:mm:ss').format(attempt.timestamp);
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: attempt.isSuccess
                        ? Colors.green.shade100
                        : Colors.red.shade100,
                    child: Icon(
                      attempt.isSuccess ? Icons.check : Icons.close,
                      color: attempt.isSuccess ? Colors.green : Colors.red,
                    ),
                  ),
                  title: Text(
                    'Attempt ${attempt.attemptNumber} → ${attempt.pin}',
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    'Status: ${attempt.isSuccess ? "Success" : "Failed"} • $time',
                    style: TextStyle(
                      color: attempt.isSuccess ? Colors.green : Colors.red,
                    ),
                  ),
                );
              },
            ),
          const SizedBox(height: 20),
          Center(
            child: Text(
              'DEBUG MODE: Plain text logging enabled',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade500,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
