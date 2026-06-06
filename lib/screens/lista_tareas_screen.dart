import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/tarea_provider.dart';

class ListaTareasScreen extends StatefulWidget {
  const ListaTareasScreen({super.key});

  @override
  State<ListaTareasScreen> createState() => _ListaTareasScreenState();
}

class _ListaTareasScreenState extends State<ListaTareasScreen> {
  @override
  void initState() {
    super.initState();
    // Al cargar la vista, le pedimos al proveedor que traiga las tareas de la API
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TareaProvider>().refrescarTareas();
    });
  }

  @override
  Widget build(BuildContext context) {
    final tareaProvider = context.watch<TareaProvider>();

    return Scaffold(
      // Aplicamos el fondo con gradiente psicodélico usando los mismos tonos de tu web
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF120136),
              Color(0xFF03001E),
              Color(0xFF7303C0),
              Color(0xFFEC38BC),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),
              // Título con el efecto de brillo neón rosa clásico de tu app
              Text(
                'Gestor de Tareas Modular',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontFamily: 'Courier New',
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(blurRadius: 5, color: Colors.white, offset: Offset.zero),
                    Shadow(blurRadius: 10, color: const Color(0xFFFF007F), offset: Offset.zero),
                    Shadow(blurRadius: 20, color: const Color(0xFFFF007F), offset: Offset.zero),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              
              // Título de la sección
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Listado de tareas',
                    style: TextStyle(
                      color: const Color(0xFFFF007F),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Courier New',
                      shadows: [
                        Shadow(blurRadius: 8, color: const Color(0xFFFF007F)),
                      ],
                    ),
                  ),
                ),
              ),
              const Divider(color: Color(0xFF00FFCC), thickness: 1, indent: 20, endIndent: 20),

              // Cuerpo de la aplicación (Cargando o Lista de Tarjetas)
              Expanded(
                child: tareaProvider.cargando
                    ? const Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF00FFCC)),
                        ),
                      )
                    : tareaProvider.tareas.isEmpty
                        ? const Center(
                            child: Text(
                              '🛸 El cosmos está vacío.\nNo hay tareas guardadas.',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Color(0xFF00FFCC), fontSize: 16, fontFamily: 'Courier New'),
                            ),
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.all(20),
                            itemCount: tareaProvider.tareas.length,
                            itemBuilder: (context, index) {
                              final tarea = tareaProvider.tareas[index];
                              return Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.05),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: const Color(0xFF00FFCC), width: 2),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFF00FFCC).withOpacity(0.2),
                                      blurRadius: 10,
                                      spreadRadius: 1,
                                    )
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '🔮 ${tarea.titulo}',
                                      style: const TextStyle(
                                        color: Color(0xFFFF007F),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text('⚡ Prioridad: ${tarea.prioridad}', style: const TextStyle(color: Color(0xFFFFFB00))),
                                    const SizedBox(height: 5),
                                    Text('📝 Descripción: ${tarea.descripcion}', style: const TextStyle(color: Colors.white)),
                                    const SizedBox(height: 10),
                                    Text(
                                      'Estado: ${tarea.estado}',
                                      style: const TextStyle(color: Color(0xFF00FFCC), fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 10),
                                    
                                    // Bloque de botones para emular el "Viajar a estado"
                                    const Text('Viajar a estado:', style: TextStyle(color: Colors.grey, fontSize: 12)),
                                    const SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        if (tarea.estado != 'Pendiente')
                                          TextButton(
                                            onPressed: () => tareaProvider.viajarAEstado(tarea.id, 'Pendiente'),
                                            child: const Text('[🌀 Pendiente]', style: TextStyle(color: Colors.cyan)),
                                          ),
                                        if (tarea.estado != 'En Progreso')
                                          TextButton(
                                            onPressed: () => tareaProvider.viajarAEstado(tarea.id, 'En%20Progreso'),
                                            child: const Text('[🔥 Progreso]', style: TextStyle(color: Colors.orange)),
                                          ),
                                        if (tarea.estado != 'Completada')
                                          TextButton(
                                            onPressed: () => tareaProvider.viajarAEstado(tarea.id, 'Completada'),
                                            child: const Text('[✨ Hecho]', style: TextStyle(color: Colors.green)),
                                          ),
                                      ],
                                    )
                                  ],
                                ),
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