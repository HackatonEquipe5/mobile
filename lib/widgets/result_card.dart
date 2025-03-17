import 'package:flutter/material.dart';
import '../themes/colors.dart';

class ResultCard extends StatelessWidget {
  final String text;
  final bool isSuccess;

  const ResultCard({super.key, required this.text, required this.isSuccess});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16,
          fontWeight: isSuccess ? FontWeight.bold : FontWeight.normal,
          color: isSuccess ? AppColors.success_text : AppColors.failure_text,
        ),
      ),
    );
  }
}