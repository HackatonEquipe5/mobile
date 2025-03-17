import 'package:flutter/material.dart';
import 'package:mobile/themes/colors.dart';
import '../models/coffee_machine.dart';
import '../widgets/coffee_card.dart';
import 'details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CoffeeMachine> machines = [
    CoffeeMachine(
      name: "Machine à café Emma",
      isWorking: true,
    ),
    CoffeeMachine(
      name: "Machine à café Hugo",
      isWorking: false,
    ),
    CoffeeMachine(
      name: "Machine à café Gabriel",
      isWorking: true,
    ),
    CoffeeMachine(
      name: "Machine à café Jade",
      isWorking: false,
    ),
    CoffeeMachine(
      name: "Machine à café Bernard",
      isWorking: false,
    ),
  ];

  void toggleFavorite(int index) {
    setState(() {
      machines[index].isFavorite = !machines[index].isFavorite;
      machines.sort((a, b) => (b.isFavorite ? 1 : 0).compareTo(a.isFavorite ? 1 : 0));
    });
  }

  void navigateToDetails(CoffeeMachine machine) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailsScreen(machine: machine),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text("VirtuCafé", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              "Choisissez votre machine à café",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                itemCount: machines.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.8,
                ),
                itemBuilder: (context, index) {
                  return CoffeeCard(
                    machine: machines[index],
                    onFavoriteToggle: () => toggleFavorite(index),
                    onTap: () => navigateToDetails(machines[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}