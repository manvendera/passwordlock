import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/attempt_provider.dart';
import '../widgets/pin_keypad.dart';
import '../widgets/attempt_history_panel.dart';

class PinScreen extends StatefulWidget {
  const PinScreen({super.key});

  @override
  State<PinScreen> createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
  String _enteredPin = '';
  final String _correctPin = '1234'; // Demo correct PIN
  bool _showPin = true; // Default to true as per requirements for visibility

  void _handleKeyPress(String digit) {
    if (_enteredPin.length < 4) {
      setState(() {
        _enteredPin += digit;
      });
    }
  }

  void _handleDelete() {
    if (_enteredPin.isNotEmpty) {
      setState(() {
        _enteredPin = _enteredPin.substring(0, _enteredPin.length - 1);
      });
    }
  }

  void _handleSubmit() {
    if (_enteredPin.length != 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a 4-digit PIN')),
      );
      return;
    }

    final isSuccess = _enteredPin == _correctPin;
    
    // Record the attempt (Logging logic)
    context.read<AttemptProvider>().recordAttempt(_enteredPin, isSuccess);

    // Custom Unlock Logic: App always opens/allows access regardless of success
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(isSuccess 
          ? 'Authentication Success! Access Granted.' 
          : 'Authentication Failed! Access Granted (Log Recorded).'),
        backgroundColor: isSuccess ? Colors.green : Colors.orange,
        duration: const Duration(seconds: 2),
      ),
    );

    // Reset for next demo attempt
    setState(() {
      _enteredPin = '';
    });
  }

  void _showHistoryPanel() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Consumer<AttemptProvider>(
        builder: (context, provider, _) => AttemptHistoryPanel(
          attempts: provider.lastAttempts,
          onClear: () => provider.clearLogs(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: _showHistoryPanel,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.lock_open_rounded,
                  size: 80,
                  color: Colors.blueAccent,
                ),
                const SizedBox(height: 20),
                const Text(
                  'PinLoggerX',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'Controlled Demo Mode',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 50),
                
                // PIN Display
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(4, (index) {
                    bool isFilled = index < _enteredPin.length;
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      width: 50,
                      height: 60,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: isFilled ? Colors.blueAccent : Colors.grey.shade300,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: isFilled
                            ? Text(
                                _showPin ? _enteredPin[index] : '•',
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : null,
                      ),
                    );
                  }),
                ),
                
                const SizedBox(height: 20),
                TextButton.icon(
                  onPressed: () => setState(() => _showPin = !_showPin),
                  icon: Icon(_showPin ? Icons.visibility_off : Icons.visibility),
                  label: Text(_showPin ? 'Hide PIN' : 'Show PIN'),
                ),
                
                const Spacer(),
                
                // Keypad
                PinKeypad(
                  onKeyPressed: _handleKeyPress,
                  onDelete: _handleDelete,
                  onSubmit: _handleSubmit,
                ),
                
                const SizedBox(height: 20),
                const Text(
                  'Tip: Long press anywhere to view logs',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
