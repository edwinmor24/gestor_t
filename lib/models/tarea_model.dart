class Tarea {
  final int id;
  final String titulo;
  final String descripcion;
  final String estado;
  final String prioridad;

  Tarea({
    required this.id,
    required this.titulo,
    required this.descripcion,
    required this.estado,
    required this.prioridad,
  });

  factory Tarea.fromJson(Map<String, dynamic> json) {
    return Tarea(
      id: json['id'] ?? 0,
      titulo: json['titulo'] ?? 'Sin título',
      descripcion: json['descripcion'] ?? '',
      estado: json['estado'] ?? 'Pendiente',
      prioridad: json['prioridad'] ?? 'Normal',
    );
  }
}