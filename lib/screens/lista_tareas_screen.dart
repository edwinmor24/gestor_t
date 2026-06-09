import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/tarea_provider.dart';
import '../theme/cyberpunk_theme.dart';
import '../models/tarea_model.dart';
import 'crear_tarea_screen.dart';

class ListaTareasScreen extends StatelessWidget {
  const ListaTareasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CyberColors.bgDark,
      appBar: AppBar(
        title: Text(
          "GESTOR DE TAREAS CYBERPUNK",
          style: TextStyle(
            color: CyberColors.cyan,
            fontWeight: FontWeight.bold,
            letterSpacing: 2.0,
            shadows: [
              Shadow(color: CyberColors.cyan.withOpacity(0.8), blurRadius: 10),
            ],
          ),
        ),
        backgroundColor: CyberColors.bgDark,
        elevation: 0,
        centerTitle: true,
      ),
      body: Consumer<TareaProvider>(
        builder: (context, provider, _) => Column(
          children: [
            // Header Neón
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _NeonButton(
                    label: "➕ CREAR",
                    color: CyberColors.cyan,
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => CrearTareaScreen()),
                      );
                      provider.obtenerTareas();
                    },
                  ),
                  _NeonButton(
                    label: "🔄 RECARGAR",
                    color: CyberColors.purple,
                    onPressed: provider.obtenerTareas,
                  ),
                ],
              ),
            ),
            Divider(color: CyberColors.cyan.withOpacity(0.3), thickness: 1),

            // Listado de tareas
            Expanded(
              child: provider.cargando
                  ? Center(
                      child: CircularProgressIndicator(
                        color: CyberColors.cyan,
                      ),
                    )
                  : provider.tareas.isEmpty
                      ? Center(
                          child: Text(
                            "SIN TAREAS",
                            style: TextStyle(
                              color: CyberColors.textSecondary,
                              fontSize: 18,
                              letterSpacing: 2.0,
                            ),
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.all(12),
                          itemCount: provider.tareas.length,
                          itemBuilder: (context, index) {
                            final tarea = provider.tareas[index];
                            return _TareaCard(tarea: tarea);
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TareaCard extends StatelessWidget {
  final Tarea tarea;

  const _TareaCard({required this.tarea});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<TareaProvider>();

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: CyberColors.bgCard,
        border: Border.all(
          color: CyberColors.cyan,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(8),
        boxShadow: CyberGlow.of(CyberColors.cyan, intensity: 0.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título
            Text(
              tarea.titulo,
              style: TextStyle(
                color: CyberColors.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 8),

            // Descripción
            if (tarea.descripcion.isNotEmpty)
              Text(
                tarea.descripcion,
                style: TextStyle(
                  color: CyberColors.textSecondary,
                  fontSize: 13,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            const SizedBox(height: 10),

            // Estado y Prioridad
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: tarea.estado.estadoColor.withOpacity(0.1),
                    border: Border.all(
                      color: tarea.estado.estadoColor,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    tarea.estado.emoji,
                    style: TextStyle(
                      color: tarea.estado.estadoColor,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: CyberColors.purple.withOpacity(0.1),
                    border: Border.all(
                      color: CyberColors.purple,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    tarea.prioridad,
                    style: const TextStyle(
                      color: CyberColors.purple,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Botones de estado
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _StateButton(
                  label: "[💤 EN ESPERA 💤]",
                  color: CyberColors.magenta,
                  onPressed: () => provider.actualizarEstado(tarea.id, 'Pendiente'),
                ),
                _StateButton(
                  label: "[🚀 COMPLETADA 🚀]",
                  color: Colors.greenAccent,
                  onPressed: () => provider.actualizarEstado(tarea.id, 'Completada'),
                ),
                _StateButton(
                  label: "[🛸💀🛸 BORRAR]",
                  color: Colors.redAccent,
                  onPressed: () => provider.eliminarTarea(tarea.id),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StateButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onPressed;

  const _StateButton({
    required this.label,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: color.withOpacity(0.1),
            side: BorderSide(color: color, width: 1.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            padding: const EdgeInsets.symmetric(vertical: 8),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}

class _NeonButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onPressed;

  const _NeonButton({
    required this.label,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color.withOpacity(0.1),
        side: BorderSide(color: color, width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}