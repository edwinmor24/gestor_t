import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/tarea_provider.dart';
import 'screens/lista_tareas_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TareaProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gestor Modular Cyberpunk',
      theme: ThemeData.dark(), // Base oscura para el estilo
      home: const ListaTareasScreen(),
    );
  }
}