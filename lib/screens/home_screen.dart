import 'package:flutter/material.dart';
import 'package:mobile/services/services_api.dart';
import 'package:mobile/themes/colors.dart';
import '../models/coffee_machine.dart';
import '../widgets/coffee_card.dart';
import '../widgets/header_widget.dart';
import 'details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CoffeeMachine> machines = [];

  @override
  void initState() {
    super.initState();
    _getMachines();
  }

  void _getMachines() {
    ApiService().connectObject().then((result) {
      setState(() {
        machines = result;
      });
    }).catchError((error) {
      print('Erreur lors de la récupération des machines: $error');
    });
  }

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
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              HeaderWidget(title: "VirtuCafé"),
              const SizedBox(height: 10),
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
      ),
    );
  }
}