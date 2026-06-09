class Tarea {
  final int id;
  final String titulo;
  final String descripcion;
  final String estado;
  final String prioridad;
  final String? fechaLimite;

  // Estados exactos desde Django
  static const String estadoPendiente = 'Pendiente';
  static const String estadoProgreso = 'En Progreso';
  static const String estadoCompletada = 'Completada';

  static const List<String> estadosValidos = [
    estadoPendiente,
    estadoProgreso,
    estadoCompletada,
  ];

  Tarea({
    required this.id,
    required this.titulo,
    required this.descripcion,
    required this.estado,
    required this.prioridad,
    this.fechaLimite,
  });

  factory Tarea.fromJson(Map<String, dynamic> json) {
    final rawEstado = json['estado'] as String? ?? estadoPendiente;
    final estadoNormalizado =
        estadosValidos.contains(rawEstado) ? rawEstado : estadoPendiente;

    return Tarea(
      id: json['id'] ?? 0,
      titulo: json['titulo'] ?? 'Sin título',
      descripcion: json['descripcion'] ?? '',
      estado: estadoNormalizado,
      prioridad: json['prioridad'] ?? 'Normal',
      fechaLimite: json['fecha_limite'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'titulo': titulo,
        'descripcion': descripcion,
        'estado': estado,
        'prioridad': prioridad,
        if (fechaLimite != null) 'fecha_limite': fechaLimite,
      };

  Tarea copyWith({
    int? id,
    String? titulo,
    String? descripcion,
    String? estado,
    String? prioridad,
    String? fechaLimite,
  }) {
    return Tarea(
      id: id ?? this.id,
      titulo: titulo ?? this.titulo,
      descripcion: descripcion ?? this.descripcion,
      estado: estado ?? this.estado,
      prioridad: prioridad ?? this.prioridad,
      fechaLimite: fechaLimite ?? this.fechaLimite,
    );
  }
}