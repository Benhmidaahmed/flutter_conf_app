import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_drawer.dart';
import 'home_page.dart';
import 'list_page.dart';

class AddEventPage extends StatefulWidget {
  const AddEventPage({super.key});

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  final _formKey = GlobalKey<FormState>();
  final confNameController = TextEditingController();
  final speakerNameController = TextEditingController();
  String selectedConfType = 'Talk';
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulaire'),
        backgroundColor: Colors.blue,
      ),
      drawer: _buildDrawer(context),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Nom de Conférence',
                    hintText: "Entrer le nom de la conférence",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Tu dois remplir ce champ";
                    }
                    return null;
                  },
                  controller: confNameController,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Nom du speaker',
                    hintText: "Entrer le nom du speaker",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Tu dois remplir ce champ";
                    }
                    return null;
                  },
                  controller: speakerNameController,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: DropdownButtonFormField(
                  items: const [
                    DropdownMenuItem(value: 'Talk', child: Text("Talk show")),
                    DropdownMenuItem(value: 'demo', child: Text("Demo code")),
                    DropdownMenuItem(value: 'partener', child: Text("Partener")),
                  ],
                  decoration: const InputDecoration(
                    labelText: 'Type de conférence',
                    border: OutlineInputBorder(),
                  ),
                  value: selectedConfType,
                  onChanged: (value) {
                    setState(() {
                      selectedConfType = value!;
                    });
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: DateTimeFormField(
                  decoration: const InputDecoration(
                    hintText: 'Sélectionner la date et heure',
                    labelText: 'Date et heure de la conférence',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.event_note),
                  ),
                  mode: DateTimeFieldPickerMode.dateAndTime,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                  onChanged: (DateTime? value) {
                    setState(() {
                      selectedDate = value;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Envoi en cours..."),
                          duration: Duration(seconds: 2),
                        ),
                      );
                      final confName = confNameController.text;
                      final speakerName = speakerNameController.text;

                      CollectionReference eventRef = FirebaseFirestore.instance.collection("events");
                      eventRef.add({
                        'speaker': speakerName,
                        'subject': confName,
                        'date': selectedDate,
                        'avatar': 'teacher',
                        'type': selectedConfType
                      }).then((value) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Événement ajouté avec succès!")),
                        );

                        // Redirection vers la liste après succès
                        Future.delayed(const Duration(seconds: 1), () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const ListPage()),
                          );
                        });
                      }).catchError((error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Erreur: $error")),
                        );
                      });
                    }
                  },
                  child: const Text("Envoyer"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return MyCustomDrawer(
      onHomeTap: () {
        Navigator.pop(context);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      },
      onListTap: () {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ListPage()),
        );
      },
      onAddTap: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  void dispose() {
    confNameController.dispose();
    speakerNameController.dispose();
    super.dispose();
  }
}