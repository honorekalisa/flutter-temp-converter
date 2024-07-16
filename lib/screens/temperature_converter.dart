import 'package:flutter/material.dart';
import '../widgets/temperature_input.dart';
import '../widgets/conversion_history.dart';
import '../utils/temperature_converter.dart';

class TemperatureConverterScreen extends StatefulWidget {
  const TemperatureConverterScreen({super.key});

  @override
  _TemperatureConverterScreenState createState() => _TemperatureConverterScreenState();
}

class _TemperatureConverterScreenState extends State<TemperatureConverterScreen> {
  bool isFahrenheitToCelsius = true;
  String _result = '';
  final List<String> _history = [];

  void _convert(String input) {
    if (input.isEmpty) return;

    double inputTemp = double.parse(input);
    double convertedTemp = isFahrenheitToCelsius
        ? TemperatureConverter.fahrenheitToCelsius(inputTemp)
        : TemperatureConverter.celsiusToFahrenheit(inputTemp);

    String operation = isFahrenheitToCelsius ? 'F to C' : 'C to F';

    setState(() {
      _result = convertedTemp.toStringAsFixed(2);
      _history.insert(0, '$operation: ${inputTemp.toStringAsFixed(1)} => $_result');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Temperature Converter'),
        centerTitle: true,
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: orientation == Orientation.portrait
                  ? _buildPortraitLayout()
                  : _buildLandscapeLayout(),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPortraitLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildConversionToggle(),
        const SizedBox(height: 20),
        TemperatureInput(onConvert: _convert),
        const SizedBox(height: 20),
        _buildResultDisplay(),
        const SizedBox(height: 20),
        Expanded(child: ConversionHistory(history: _history)),
      ],
    );
  }

  Widget _buildLandscapeLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Column(
            children: [
              _buildConversionToggle(),
              const SizedBox(height: 20),
              TemperatureInput(onConvert: _convert),
              const SizedBox(height: 20),
              _buildResultDisplay(),
            ],
          ),
        ),
        const SizedBox(width: 20),
        Expanded(child: ConversionHistory(history: _history)),
      ],
    );
  }

  Widget _buildConversionToggle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('F to C'),
        Switch(
          value: isFahrenheitToCelsius,
          onChanged: (value) {
            setState(() {
              isFahrenheitToCelsius = value;
            });
          },
        ),
        const Text('C to F'),
      ],
    );
  }

  Widget _buildResultDisplay() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        'Result: $_result',
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }
}