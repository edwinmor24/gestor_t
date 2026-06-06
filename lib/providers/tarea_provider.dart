import 'package:flutter/material.dart';
import '../models/tarea_model.dart';
import '../repositories/tarea_repository.dart';

class TareaProvider with ChangeNotifier {
  final TareaRepository _repository = TareaRepository();
  
  List<Tarea> _tareas = [];
  bool _cargando = false;

  List<Tarea> get tareas => _tareas;
  bool get cargando => _cargando;

  // Cargar tareas desde Django
  Future<void> refrescarTareas() async {
    _cargando = true;
    notifyListeners();
    try {
      _tareas = await _repository.obtenerTodas();
    } catch (e) {
      print("Error en Provider: $e");
    } finally {
      _cargando = false;
      notifyListeners();
    }
  }

  // Ejecutar el viaje de estado
  Future<void> viajarAEstado(int id, String nuevoEstado) async {
    bool exito = await _repository.cambiarEstadoBackend(id, nuevoEstado);
    if (exito) {
      // Recargamos el listado para ver el reflejo real de la DB
      await refrescarTareas();
    }
  }
}