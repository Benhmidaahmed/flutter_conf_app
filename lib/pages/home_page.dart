import 'package:flutter/material.dart';
import '../widgets/custom_drawer.dart';
import 'list_page.dart';
import 'add_event_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      drawer: _buildDrawer(context),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(
        "Conference App",
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.blue,
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return MyCustomDrawer(
      onHomeTap: () {
        Navigator.pop(context);
        if (ModalRoute.of(context)?.settings.name != '/') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        }
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
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AddEventPage()),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildHeaderIcon(),
          _buildWelcomeText(),
          _buildActionButtons(context),
        ],
      ),
    );
  }

  Widget _buildHeaderIcon() {
    return const Icon(
      Icons.event,
      size: 100,
      color: Colors.blue,
    );
  }

  Widget _buildWelcomeText() {
    return const Column(
      children: [
        SizedBox(height: 20),
        Text(
          "Bienvenue dans Conference App",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10),
        Text(
          "Gérez vos conférences et événements",
          style: TextStyle(fontSize: 16, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 40),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildActionButton(
          context: context,
          text: "Voir les événements",
          icon: Icons.list,
          page: const ListPage(),
        ),
        _buildActionButton(
          context: context,
          text: "Ajouter un événement",
          icon: Icons.add,
          page: const AddEventPage(),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required BuildContext context,
    required String text,
    required IconData icon,
    required Widget page,
  }) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(20),
          ),
          child: IconButton(
            icon: Icon(icon, size: 40, color: Colors.blue),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => page),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: 100,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12),
          ),
        ),
      ],
    );
  }
}