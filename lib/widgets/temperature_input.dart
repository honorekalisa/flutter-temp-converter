import 'package:flutter/material.dart';

class TemperatureInput extends StatelessWidget {
  final Function(String) onConvert;

  const TemperatureInput({required this.onConvert});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();

    return Column(
      children: [
        TextField(
          controller: _controller,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
            labelText: 'Enter temperature',
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () => _controller.clear(),
            ),
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () => onConvert(_controller.text),
          child: const Text('Convert'),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          ),
        ),
      ],
    );
  }
}