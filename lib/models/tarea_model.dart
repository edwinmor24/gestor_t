class Tarea {
  final int id;
  final String titulo;
  final String descripcion;
  final String prioridad;
  final String estado;

  Tarea({
    required this.id,
    required this.titulo,
    required this.descripcion,
    required this.prioridad,
    required this.estado,
  });

  // Factoría para convertir el JSON de Django a un Objeto de Flutter
  factory Tarea.fromJson(Map<String, dynamic> json) {
    return Tarea(
      id: json['id'],
      titulo: json['titulo'],
      descripcion: json['descripcion'] ?? '',
      prioridad: json['prioridad'],
      estado: json['estado'],
    );
  }
}