import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/tarea_model.dart';

class TareaRepository {
  // Ajusta esta URL según donde corras el emulador (ej: 'http://10.0.2.2:8000')
  final String baseUrl = 'http://127.0.0.1:8000';

  // GET /api/
  Future<List<Tarea>> obtenerTodas() async {
    final response = await http.get(Uri.parse('$baseUrl/api/'));

    if (response.statusCode == 200) {
  List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));
  return body.map((dynamic item) => Tarea.fromJson(item)).toList();
} else {
      throw Exception('Error al conectar con la Matrix de Django');
    }
  }

  // POST o GET para cambiar estado (según definiste tu ruta de Django)
  Future<bool> cambiarEstadoBackend(int tareaId, String nuevoEstado) async {
    final response = await http.get(
      Uri.parse('$baseUrl/cambiar-estado/$tareaId/$nuevoEstado/'),
    );
    return response.statusCode == 200 || response.statusCode == 302;
  }
}