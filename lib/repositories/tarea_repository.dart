import 'dart:convert';
import 'dart:io'; // Necesario para detectar si es Android o iOS (Platform)
import 'package:flutter/foundation.dart'; // Necesario para detectar si es Web (kIsWeb)
import 'package:http/http.dart' as http;
import '../models/tarea_model.dart';

class TareaRepository {
  // Función inteligente que calcula la URL correcta dinámicamente
  String get baseUrl {
    if (kIsWeb) {
      // Si corres la app en el navegador de la PC (Chrome)
      return 'http://127.0.0.1:8000';
    } else if (Platform.isAndroid || Platform.isIOS) {
      // Si corres la app en el celular físico con Vysor 
      // (Recuerda cambiar las XX por el número real de tu ipconfig)
      return 'http://192.168.80.17:8000';
    } else {
      // Caso por defecto (Por ejemplo, si la corres como app de escritorio Windows)
      return 'http://127.0.0.1:8000';
    }
  }

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