import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/tarea_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'crear_tarea_screen.dart'; 

class ListaTareasScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Escuchamos el provider para reaccionar a cambios
    final provider = Provider.of<TareaProvider>(context);
    
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Gestor de Tareas Modular", style: TextStyle(color: Colors.cyanAccent)),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Header Neón (Crear + Filtro)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton.icon(
                  onPressed: () async {
                    // MANTENEMOS ESTA ESTRUCTURA PARA RECARGAR AL VOLVER
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CrearTareaScreen()),
                    );
                    // Al volver de crear, refrescamos la lista automáticamente
                    Provider.of<TareaProvider>(context, listen: false).obtenerTareas();
                  },
                  icon: Icon(Icons.add_circle_outline, color: Colors.cyanAccent),
                  label: Text("Crear nueva tarea", style: TextStyle(color: Colors.cyanAccent)),
                ),
                SizedBox(width: 20),
                TextButton.icon(
                  onPressed: () => provider.toggleFiltro(),
                  icon: Icon(provider.soloPendientes ? Icons.visibility : Icons.visibility_off, color: Colors.cyanAccent),
                  label: Text(provider.soloPendientes ? "Ver todas" : "Solo pendientes", style: TextStyle(color: Colors.cyanAccent)),
                ),
              ],
            ),
          ),
          Divider(color: Colors.cyanAccent.withOpacity(0.5), thickness: 1),
          
          // Listado de tareas
          Expanded(
            child: provider.cargando 
                ? Center(child: CircularProgressIndicator(color: Colors.cyanAccent))
                : ListView.builder(
                    itemCount: provider.tareas.length,
                    itemBuilder: (context, index) {
                      final tarea = provider.tareas[index];
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.cyanAccent.withOpacity(0.5)),
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey[900],
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(tarea.titulo, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                              subtitle: Text("Estado: ${tarea.estado} | Prioridad: ${tarea.prioridad}", 
                                          style: TextStyle(color: Colors.cyanAccent)),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _buildNeonButton(Icons.history, Colors.amberAccent, 'Pendiente', () => provider.actualizarEstado(tarea.id, 'Pendiente')),
                                _buildNeonButton(Icons.rocket, Colors.orangeAccent, 'En Progreso', () => provider.actualizarEstado(tarea.id, 'En Progreso')),
                                _buildNeonButton(Icons.check_circle, Colors.greenAccent, 'Completada', () => provider.actualizarEstado(tarea.id, 'Completada')),
                              ],
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(10),
        color: Colors.black,
        child: TextButton.icon(
          icon: Icon(Icons.hub, color: Colors.greenAccent),
          label: Text("🌌 ENTRAR A LA MATRIX (JSON)", style: TextStyle(color: Colors.greenAccent)),
          onPressed: () => launchUrl(Uri.parse('http://127.0.0.1:8000/api/')),
        ),
      ),
    );
  }

  Widget _buildNeonButton(IconData icon, Color color, String label, VoidCallback onPressed) {
    return Column(
      children: [
        IconButton(icon: Icon(icon, color: color, size: 28), onPressed: onPressed),
        Text(label, style: TextStyle(color: color, fontSize: 10)),
      ],
    );
  }
}