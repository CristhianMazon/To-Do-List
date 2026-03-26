import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TodoPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// Modelo da tarefa
class Tarefa {
  String titulo;
  bool concluida;

  Tarefa({required this.titulo, this.concluida = false});
}

// Página principal
class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  List<Tarefa> tarefas = [];
  TextEditingController controller = TextEditingController();

  void adicionarTarefa() {
    if (controller.text.isEmpty) return;

    setState(() {
      tarefas.add(Tarefa(titulo: controller.text));
      controller.clear();
    });
  }

  void removerTarefa(int index) {
    setState(() {
      tarefas.removeAt(index);
    });
  }

  void toggleTarefa(int index) {
    setState(() {
      tarefas[index].concluida = !tarefas[index].concluida;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("To-Do List")),
      body: Column(
        children: [
          // Campo de texto
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      hintText: "Digite uma tarefa",
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: adicionarTarefa,
                ),
              ],
            ),
          ),

          // Lista
          Expanded(
            child: tarefas.isEmpty
                ? const Center(child: Text("Nenhuma tarefa ainda"))
                : ListView.builder(
                    itemCount: tarefas.length,
                    itemBuilder: (context, index) {
                      final tarefa = tarefas[index];

                      return ListTile(
                        leading: Checkbox(
                          value: tarefa.concluida,
                          onChanged: (_) => toggleTarefa(index),
                        ),
                        title: Text(
                          tarefa.titulo,
                          style: TextStyle(
                            decoration: tarefa.concluida
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => removerTarefa(index),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: adicionarTarefa,
        child: const Icon(Icons.add),
      ),
    );
  }
}
