import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import '../models/coffee_machine.dart';
import '../services/services_api.dart';
import '../themes/colors.dart';

class RecordButton extends StatefulWidget {
  final CoffeeMachine machine;
  const RecordButton({super.key, required this.machine});

  @override
  State<RecordButton> createState() => _RecordButtonState();
}

class _RecordButtonState extends State<RecordButton> {
  bool isRecording = false;
  List<int> soundLevels = List.generate(6, (index) => 2);
  Timer? _timer;
  final AudioRecorder _record = AudioRecorder();
  String? audioPath;

  @override
  void initState() {
    super.initState();
  }

  void _toggleRecording() async {
    setState(() {
      isRecording = !isRecording;
    });

    if (isRecording) {
      if (await _record.hasPermission()) {
        _startSoundAnimation();
        await _startRecording();
      } else {
        print("Permission non accordée");
      }
    } else {
      _timer?.cancel();
      await _stopRecording();
    }
  }

  Future<void> _startRecording() async {
    try {
      Directory dir = await getApplicationDocumentsDirectory();
      String path = '${dir.path}/myOrder.wav';
      await _record.start(
        const RecordConfig(encoder: AudioEncoder.wav),
        path: path,
      );
    } catch (e) {
      print("Erreur lors du démarrage de l'enregistrement: $e");
    }
  }

  Future<void> _stopRecording() async {
    try {
      final path = await _record.stop();
      print("Enregistrement arrêté, fichier sauvegardé à: $path");
      setState(() {
        isRecording = false;
      });
      _postAudioFile();
    } catch (e) {
      print("Erreur lors de l'arrêt de l'enregistrement: $e");
    }
  }

  Future<void> _postAudioFile() async {
      await ApiService().postOrder(widget.machine);
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
    _record.dispose();
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