import 'package:flutter/material.dart';

class PinKeypad extends StatelessWidget {
  final Function(String) onKeyPressed;
  final VoidCallback onDelete;
  final VoidCallback onSubmit;

  const PinKeypad({
    super.key,
    required this.onKeyPressed,
    required this.onDelete,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.5,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemCount: 12,
      itemBuilder: (context, index) {
        if (index == 9) {
          return _buildKey(
            icon: Icons.backspace_outlined,
            onTap: onDelete,
          );
        } else if (index == 10) {
          return _buildKey(text: '0', onTap: () => onKeyPressed('0'));
        } else if (index == 11) {
          return _buildKey(
            icon: Icons.check_circle_outline,
            onTap: onSubmit,
            color: Colors.green.shade700,
          );
        } else {
          final text = '${index + 1}';
          return _buildKey(text: text, onTap: () => onKeyPressed(text));
        }
      },
    );
  }

  Widget _buildKey({
    String? text,
    IconData? icon,
    required VoidCallback onTap,
    Color? color,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        decoration: BoxDecoration(
          color: color?.withValues(alpha: 0.1) ?? Colors.grey.withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: text != null
              ? Text(
                  text,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : Icon(icon, size: 28, color: color),
        ),
      ),
    );
  }
}
