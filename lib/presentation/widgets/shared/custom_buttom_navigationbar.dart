import 'package:flutter/material.dart';

class CustomButtomNavigation extends StatefulWidget {
  const CustomButtomNavigation({super.key});

  @override
  State<CustomButtomNavigation> createState() => _CustomButtomNavigationState();
}

class _CustomButtomNavigationState extends State<CustomButtomNavigation> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 0,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_max), label: 'Inicio'),
        BottomNavigationBarItem(
            icon: Icon(Icons.label_outline), label: 'Categorias'),
        BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline), label: 'Favoritos')
      ],
    );
  }
}
