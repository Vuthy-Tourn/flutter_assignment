import 'package:flutter/material.dart';

class AddressPage extends StatelessWidget {
  const AddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),

        /// 📍 CURRENT LOCATION
        ListTile(
          leading: const Icon(Icons.my_location, color: Colors.pink),
          title: const Text("Use Current Location (GPS)"),
          onTap: () {
            Navigator.pop(context, "Current Location Selected");
          },
        ),

        const Divider(),

        /// 🗺 MAP
        ListTile(
          leading: const Icon(Icons.map_outlined, color: Colors.pink),
          title: const Text("Choose Map Location"),
          onTap: () {
            Navigator.pop(context, "Map Selected Address");
          },
        ),

        const Divider(),

        const SizedBox(height: 30),

        const Center(
          child: Text(
            "No saved address",
            style: TextStyle(color: Colors.grey),
          ),
        ),
      ],
    );
  }
}