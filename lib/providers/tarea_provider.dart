import 'package:flutter/material.dart';
import '../models/tarea_model.dart';
import '../repositories/tarea_repository.dart';

class TareaProvider with ChangeNotifier {
  final TareaRepository repository;
  List<Tarea> _tareas = [];
  bool _cargando = false;
  bool _soloPendientes = false;

  TareaProvider({required this.repository}) {
    obtenerTareas();
  }

  List<Tarea> get tareas => _soloPendientes 
      ? _tareas.where((t) => t.estado == "Pendiente").toList() 
      : _tareas;

  bool get cargando => _cargando;
  bool get soloPendientes => _soloPendientes;

  void toggleFiltro() {
    _soloPendientes = !_soloPendientes;
    notifyListeners();
  }

  Future<void> obtenerTareas() async {
    _cargando = true;
    notifyListeners();
    _tareas = await repository.obtenerTodas();
    _cargando = false;
    notifyListeners();
  }

  Future<void> agregarTarea(String titulo, String descripcion, String estado, String prioridad) async {
    _cargando = true;
    notifyListeners();
    
    bool exito = await repository.guardarNuevaTarea(titulo, descripcion, prioridad, estado);
    
    if (exito) {
      await obtenerTareas(); 
    }
    
    _cargando = false;
    notifyListeners();
  }

  Future<void> actualizarEstado(int id, String nuevoEstado) async {
    bool exito = await repository.cambiarEstadoBackend(id, nuevoEstado);
    if (exito) await obtenerTareas();
  }

  Future<void> eliminarTarea(int id) async {
    _cargando = true;
    notifyListeners();

    bool exito = await repository.eliminarTarea(id);

    if (exito) {
      await obtenerTareas();
    }

    _cargando = false;
    notifyListeners();
  }
}