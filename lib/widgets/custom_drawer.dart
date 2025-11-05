import 'package:flutter/material.dart';

class MyDrawerItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const MyDrawerItem({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward),
      onTap: onTap,
    );
  }
}

class CustomDrawerHeader extends StatelessWidget {
  const CustomDrawerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, Theme.of(context).primaryColor],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildCircleAvatar(),
          _buildCircleAvatar(),
        ],
      ),
    );
  }

  Widget _buildCircleAvatar() {
    return const CircleAvatar(
      radius: 40,
      backgroundColor: Colors.blue,
      child: Icon(Icons.person, color: Colors.white, size: 40),
    );
  }
}

class MyCustomDrawer extends StatelessWidget {
  final VoidCallback onHomeTap;
  final VoidCallback onListTap;
  final VoidCallback onAddTap;

  const MyCustomDrawer({
    super.key,
    required this.onHomeTap,
    required this.onListTap,
    required this.onAddTap,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const CustomDrawerHeader(),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                MyDrawerItem(
                  title: "Accueil",
                  icon: Icons.home,
                  onTap: onHomeTap,
                ),
                const Divider(color: Colors.red),
                MyDrawerItem(
                  title: "Liste des Événements",
                  icon: Icons.list,
                  onTap: onListTap,
                ),
                MyDrawerItem(
                  title: "Ajouter un Événement",
                  icon: Icons.add,
                  onTap: onAddTap,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}