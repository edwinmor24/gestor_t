import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/tarea_provider.dart';
import 'repositories/tarea_repository.dart';
import 'screens/lista_tareas_screen.dart';
import 'theme/cyberpunk_theme.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => TareaProvider(repository: TareaRepository()),
        ),
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
      title: 'Gestor de Tareas Cyberpunk',
      theme: cyberTheme(),
      home: const ListaTareasScreen(),
    );
  }
}