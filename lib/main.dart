import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/tarea_provider.dart';
import 'repositories/tarea_repository.dart';
import 'screens/lista_tareas_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => TareaProvider(repository: TareaRepository()),
        ),
      ],
      child: MyApp(), // Sin 'const' aquí
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gestor de Tareas Modular',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Color(0xFF09090B),
        primaryColor: Colors.cyanAccent,
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF181818),
        ),
      ),
      home: ListaTareasScreen(),
    );
  }
}