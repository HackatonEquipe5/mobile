import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../themes/colors.dart';

class RecordButton extends StatefulWidget {
  const RecordButton({super.key});

  @override
  State<RecordButton> createState() => _RecordButtonState();
}

class _RecordButtonState extends State<RecordButton> {
  bool isRecording = false;
  List<int> soundLevels = List.generate(6, (index) => 2);
  Timer? _timer;

  void _toggleRecording() {
    setState(() {
      isRecording = !isRecording;
    });

    if (isRecording) {
      _startSoundAnimation();
    } else {
      _timer?.cancel();
    }
  }

  void _startSoundAnimation() {
    _timer = Timer.periodic(const Duration(milliseconds: 300), (timer) {
      setState(() {
        soundLevels = List.generate(6, (index) => Random().nextInt(6) + 1);
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleRecording,
      child: SizedBox(
        width: 339,
        height: 100,
        child: Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          decoration: BoxDecoration(
            color: AppColors.secondary,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.mic, color: AppColors.etat_machine_not_work),
              const SizedBox(width: 10),
              isRecording
                  ? Row(
                children: soundLevels.map((level) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: Container(
                      width: 5,
                      height: level * 5.0,
                      decoration: BoxDecoration(
                        color: AppColors.etat_machine_not_work,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  );
                }).toList(),
              )
                  : const Text(
                "Appuyez pour enregistrer",
                style: TextStyle(color: AppColors.etat_machine_not_work),
              ),
            ],
          ),
        ),
      ),
    );
  }
}