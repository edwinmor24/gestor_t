import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/tarea_model.dart';

class TareaRepository {
  final String baseUrl = 'http://192.168.1.3:8000/api';

 Future<List<Tarea>> obtenerTodas() async {
  try {
    final response = await http.get(Uri.parse('$baseUrl/tareas/'));
    print("Respuesta del servidor: ${response.statusCode}"); // <--- ESTO ES CLAVE
    // ...
  } catch (e) {
    print("ERROR DE CONEXIÓN: $e"); // <--- SI HAY ERROR, APARECERÁ AQUÍ
  }
  return [];
}

  Future<bool> guardarNuevaTarea(String titulo, String descripcion, String prioridad, String estado) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/crear/'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'titulo': titulo,
          'descripcion': descripcion,
          'prioridad': prioridad,
          'estado': estado,
        }),
      );
      return response.statusCode == 201 || response.statusCode == 200;
    } catch (e) {
      print("Error al guardar: $e");
      return false;
    }
  }

  Future<bool> cambiarEstadoBackend(int id, String nuevoEstado) async {
    try {
      final response = await http.patch(
        Uri.parse('$baseUrl/actualizar/$id/'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'estado': nuevoEstado}),
      );
      return response.statusCode == 200;
    } catch (e) {
      print("Error al cambiar estado: $e");
      return false;
    }
  }

  Future<bool> eliminarTarea(int id) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/eliminar/$id/'),
        headers: {'Content-Type': 'application/json'},
      );
      return response.statusCode == 200 || response.statusCode == 204;
    } catch (e) {
      print("Error al eliminar tarea: $e");
      return false;
    }
  }
}