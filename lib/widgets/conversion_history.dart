import 'package:flutter/material.dart';

class ConversionHistory extends StatelessWidget {
  final List<String> history;

  ConversionHistory({required this.history});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Conversion History',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        Expanded(
          child: ListView.builder(
            itemCount: history.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: Text(history[index]),
                  leading: const Icon(Icons.history),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}