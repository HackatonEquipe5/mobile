import 'package:flutter/material.dart';
import '../models/coffee_machine.dart';
import '../themes/colors.dart';

class CoffeeCard extends StatelessWidget {
  final CoffeeMachine machine;
  final VoidCallback onFavoriteToggle;
  final VoidCallback onTap;

  const CoffeeCard({
    super.key,
    required this.machine,
    required this.onFavoriteToggle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.secondary,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.star,
                    color: machine.isFavorite ? AppColors.primary : Colors.grey,
                    size: 30,
                  ),
                  onPressed: onFavoriteToggle,
                ),
                Icon(
                  Icons.circle,
                  color: machine.isWorking ? AppColors.etat_machine_work : AppColors.etat_machine_not_work,
                  size: 30,
                ),
              ],
            ),

            machine.imageUrl != null ? Image.asset(machine.imageUrl!, height: 80) : const Spacer(),
            const SizedBox(height: 8),
            Text(
              machine.name,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}