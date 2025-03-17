import 'dart:math';
import 'package:flutter/material.dart';
import '../models/coffee_machine.dart';
import '../widgets/record_button.dart';
import '../themes/colors.dart';
import '../widgets/result_card.dart';

class DetailsScreen extends StatefulWidget {
  final CoffeeMachine machine;

  const DetailsScreen({super.key, required this.machine});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late List<Map<String, dynamic>> responses;

  @override
  void initState() {
    super.initState();
    _generateResponses();
  }

  void _generateResponses() {
    setState(() {
      responses = List.generate(
        4,
            (index) {
          bool isSuccess = Random().nextBool();
          String text = isSuccess
              ? "${widget.machine.name} a réussi à faire votre café"
              : "${widget.machine.name} n’a pas réussi à faire votre café";
          return {"text": text, "isSuccess": isSuccess};
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              color: AppColors.primary,
              child: Center(
                child: Text(
                  widget.machine.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                children: responses
                    .map((resp) =>
                    ResultCard(text: resp["text"], isSuccess: resp["isSuccess"]))
                    .toList(),
              ),
            ),
            const RecordButton(),
          ],
        ),
      ),
    );
  }
}