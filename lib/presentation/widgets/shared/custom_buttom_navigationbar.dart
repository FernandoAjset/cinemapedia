import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomButtomNavigation extends StatefulWidget {
  const CustomButtomNavigation({super.key});

  @override
  State<CustomButtomNavigation> createState() => _CustomButtomNavigationState();
}

void onItemTapped(BuildContext context, int index) {
  switch (index) {
    case 0:
      context.go('/');
      break;
    case 1:
      context.go('/categories');
      break;
    case 2:
      context.go('/favorites');
      break;
    default:
  }
}

int getCurrentIndex(BuildContext context) {
  final String location = GoRouterState.of(context).uri.toString();
  switch (location) {
    case '/':
      return 0;
    case '/categories':
      return 1;
    case '/favorites':
      return 2;
    default:
      return 0;
  }
}

class _CustomButtomNavigationState extends State<CustomButtomNavigation> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 0,
      currentIndex: getCurrentIndex(context),
      onTap: (value) {
        onItemTapped(context, value);
      },
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
