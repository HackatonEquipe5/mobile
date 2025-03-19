#!/bin/bash

# Vérification si Flutter est installé
if ! command -v flutter &> /dev/null
then
    echo "Erreur: Flutter n'est pas installé. Veuillez installer Flutter avant de continuer."
    exit 1
fi

# Installation des dépendances Flutter
echo "Installation des dépendances Flutter..."
flutter pub get

# Lancement de l'application mobile
echo "Lancement de l'application mobile..."
flutter run
