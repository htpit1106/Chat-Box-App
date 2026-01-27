import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainTabChild();
  }
}

class MainTabChild extends StatefulWidget {
  const MainTabChild({super.key});

  @override
  State<MainTabChild> createState() => _MainTabChildState();
}

class _MainTabChildState extends State<MainTabChild> {
  final List<Widget> _pages = [

  ];
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
