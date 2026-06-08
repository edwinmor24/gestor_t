import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/tarea_provider.dart';

class CrearTareaScreen extends StatefulWidget {
  @override
  _CrearTareaScreenState createState() => _CrearTareaScreenState();
}

class _CrearTareaScreenState extends State<CrearTareaScreen> {
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  
  String _prioridadSeleccionada = 'Alta';
  String _estadoSeleccionado = 'Pendiente';

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TareaProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text("Nueva Tarea", style: TextStyle(color: Colors.cyanAccent)), backgroundColor: Colors.black),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLabel("Título Cósmico:"),
            TextField(controller: _tituloController, style: TextStyle(color: Colors.white), decoration: _inputDecoration()),
            SizedBox(height: 20),
            _buildLabel("Descripción Mental:"),
            TextField(controller: _descController, maxLines: 3, style: TextStyle(color: Colors.white), decoration: _inputDecoration()),
            SizedBox(height: 20),
            
            _buildLabel("Urgenica en el Espacio-Tiempo:"),
            _buildDropdown(['Alta', 'Media', 'Baja'], _prioridadSeleccionada, (val) => setState(() => _prioridadSeleccionada = val!)),
            
            SizedBox(height: 20),
            _buildLabel("Estado de la Realidad:"),
            _buildDropdown(['Pendiente', 'En Progreso', 'Completada'], _estadoSeleccionado, (val) => setState(() => _estadoSeleccionado = val!)),
            
            SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.purpleAccent, padding: EdgeInsets.symmetric(vertical: 15)),
                onPressed: () async {
                  await provider.agregarTarea(_tituloController.text, _descController.text, _estadoSeleccionado, _prioridadSeleccionada);
                  Navigator.pop(context);
                },
                child: Text("Guardar Tarea en el Universo", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) => Padding(padding: EdgeInsets.only(bottom: 8), child: Text(text, style: TextStyle(color: Colors.cyanAccent, fontWeight: FontWeight.bold)));

  InputDecoration _inputDecoration() => InputDecoration(enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.cyanAccent)));

  Widget _buildDropdown(List<String> items, String value, Function(String?) onChanged) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(border: Border.all(color: Colors.cyanAccent), borderRadius: BorderRadius.circular(5)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          dropdownColor: Colors.black,
          icon: Icon(Icons.arrow_drop_down, color: Colors.cyanAccent),
          items: items.map((i) => DropdownMenuItem(value: i, child: Text(i, style: TextStyle(color: Colors.white)))).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}