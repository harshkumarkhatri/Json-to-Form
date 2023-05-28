import 'package:flutter/material.dart';
import 'package:json_to_form/screens/form_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Json to Form",
        ),
      ),
      body: Center(
        child: SizedBox(
          height: 50,
          width: 70,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const FormScreen(),
                ),
              );
            },
            child: const Text(
              "Start",
            ),
          ),
        ),
      ),
    );
  }
}
