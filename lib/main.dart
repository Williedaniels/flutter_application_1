import 'package:flutter/material.dart';

void main() {
  runApp(const TemperatureConverterApp());
}

class TemperatureConverterApp extends StatelessWidget {
  const TemperatureConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperature Converter',
      theme: ThemeData(
        primaryColor: Colors.blue, // Set primary color to blue
        scaffoldBackgroundColor: Colors.white, // Set background color to white
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.blue),
          bodyMedium: TextStyle(color: Colors.blue),
        ),
      ),
      home: const TemperatureConverterScreen(),
    );
  }
}

class TemperatureConverterScreen extends StatefulWidget {
  const TemperatureConverterScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TemperatureConverterScreenState createState() => _TemperatureConverterScreenState();
}

class _TemperatureConverterScreenState extends State<TemperatureConverterScreen> {
  String? _conversionType;
  final TextEditingController _temperatureController = TextEditingController();
  String _result = '';
  final List<String> _history = [];

  void _convertTemperature() {
    double temperature = double.tryParse(_temperatureController.text) ?? 0.0;
    double convertedTemp;

    if (_conversionType == 'FtoC') {
      convertedTemp = (temperature - 32) * 5 / 9;
      _result = '${temperature.toStringAsFixed(1)} °F => ${convertedTemp.toStringAsFixed(2)} °C';
    } else if (_conversionType == 'CtoF') {
      convertedTemp = temperature * 9 / 5 + 32;
      _result = '${temperature.toStringAsFixed(1)} °C => ${convertedTemp.toStringAsFixed(2)} °F';
    }

    setState(() {
      _history.insert(0, _result);
    });
    _temperatureController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Temperature Converter'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _temperatureController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter Temperature',
                labelStyle: TextStyle(color: Colors.blue),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.yellow, width: 2.0),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _conversionType = 'FtoC';
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black, backgroundColor: _conversionType == 'FtoC' ? Colors.yellow : Colors.grey,
                  ),
                  child: const Text('Fahrenheit to Celsius'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _conversionType = 'CtoF';
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black, backgroundColor: _conversionType == 'CtoF' ? Colors.yellow : Colors.grey,
                  ),
                  child: const Text('Celsius to Fahrenheit'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_conversionType != null) {
                  _convertTemperature();
                }
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.blue,
              ),
              child: const Text('Convert'),
            ),
            const SizedBox(height: 20),
            if (_result.isNotEmpty)
              Text(
                'Result: $_result',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
              ),
            const SizedBox(height: 20),
            const Text('History:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue)),
            Expanded(
              child: ListView.builder(
                itemCount: _history.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_history[index], style: const TextStyle(color: Colors.blue)),
                    tileColor:
                        index.isEven ? Colors.grey[200] : Colors.white, // Alternate row colors for better readability
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}