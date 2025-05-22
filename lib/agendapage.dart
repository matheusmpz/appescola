import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'agendas_database.dart';

class Agendapage extends StatefulWidget {
  const Agendapage({super.key});

  @override
  State<Agendapage> createState() => _AgendapageState();
}

class _AgendapageState extends State<Agendapage> {
  final Map<DateTime, List<Map<String, dynamic>>> _events = {};

  @override
  void initState() {
    super.initState();
    _loadEventos();
  }

  void _loadEventos() async {
    final eventos = await DatabaseHelper.getEventos();
    setState(() {
      for (var evento in eventos) {
        final date = DateTime.parse(evento['data']);
        if (_events[date] == null) {
          _events[date] = [];
        }
        _events[date]!.add({'id': evento['id'], 'evento': evento['evento']});
      }
    });
  }

  void _addEvento(String evento, DateTime date) async {
    final formattedDate = date.toIso8601String();
    await DatabaseHelper.adicionarEvento(evento, formattedDate);
    _loadEventos();
  }

  void _showAddEventDialog() {
    final eventController = TextEditingController();
    DateTime selectedDate = DateTime.now();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Adicionar Evento"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: eventController,
                decoration:
                    const InputDecoration(labelText: "Título do Evento"),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2030),
                  );
                  if (pickedDate != null) {
                    selectedDate = pickedDate;
                  }
                },
                child: const Text("Selecionar Data"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                if (eventController.text.isNotEmpty) {
                  _addEvento(eventController.text, selectedDate);
                  Navigator.pop(context);
                }
              },
              child: const Text("Adicionar"),
            ),
          ],
        );
      },
    );
  }

  void confirmarDelete(int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Excluir evento"),
          content: const Text("Você tem certeza que deseja excluir?"),
          actions: [
            TextButton(
              child: const Text("Cancelar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Excluir"),
              onPressed: () {
                _deletarEvento(id);
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  void _deletarEvento(int id) async {
    await DatabaseHelper.deletarEvento(id);
    setState(() {
      _events
          .removeWhere((key, value) => value.any((event) => event['id'] == id));
    });
    _loadEventos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Agenda Virtual",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff061F3E),
        foregroundColor: Colors.white,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(Icons.notifications),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCalendar(),
            const SizedBox(height: 20),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Eventos próximos",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Ver todos",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: _events.entries.expand((entry) {
                  return entry.value.map((eventMap) {
                    return _buildEventCard(
                      title: eventMap['evento'],
                      date:
                          "${entry.key.day}/${entry.key.month}/${entry.key.year}",
                      color: Colors.grey[300]!,
                      onDelete: () async {
                        // Replace with the correct ID of the event
                        confirmarDelete(eventMap['id']);
                      },
                    );
                  });
                }).toList(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddEventDialog,
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF061F3E),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_outlined), label: 'Dashboard'),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month), label: 'Agenda'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_sharp), label: 'Perfil'),
        ],
      ),
    );
  }

  Widget _buildCalendar() {
    return TableCalendar(
      firstDay: DateTime.utc(2020, 1, 1),
      lastDay: DateTime.utc(2030, 12, 31),
      focusedDay: DateTime.now(),
      eventLoader: (day) => _events[day] ?? [],
      calendarStyle: const CalendarStyle(
        todayDecoration: BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
        ),
        selectedDecoration: BoxDecoration(
          color: Color(0xff061F3E),
          shape: BoxShape.circle,
        ),
        markerDecoration: BoxDecoration(
          color: Colors.blue,
          shape: BoxShape.circle,
        ),
      ),
      headerStyle: const HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
      ),
    );
  }

  Widget _buildEventCard({
    required String title,
    required String date,
    required Color color,
    required VoidCallback onDelete,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                date,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}
