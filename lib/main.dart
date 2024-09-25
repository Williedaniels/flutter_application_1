import 'package:flutter/material.dart';

void main() {
  runApp(TemperatureConverterApp());
}

class TemperatureConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperature Converter',
      theme: ThemeData(
        primaryColor: Colors.blue, // Set primary color to blue
        scaffoldBackgroundColor: Colors.white, // Set background color to white
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.blue),
          bodyMedium: TextStyle(color: Colors.blue),
        ),
      ),
      home: TemperatureConverterScreen(),
    );
  }
}

class TemperatureConverterScreen extends StatefulWidget {
  @override
  _TemperatureConverterScreenState createState() => _TemperatureConverterScreenState();
}

class _TemperatureConverterScreenState extends State<TemperatureConverterScreen> {
  String? _conversionType;
  final TextEditingController _temperatureController = TextEditingController();
  String _result = '';
  List<String> _history = [];

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
        title: Text('Temperature Converter'),
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
              decoration: InputDecoration(
                labelText: 'Enter Temperature',
                labelStyle: TextStyle(color: Colors.blue),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.yellow, width: 2.0),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _conversionType = 'FtoC';
                    });
                  },
                  child: Text('Fahrenheit to Celsius'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black, backgroundColor: _conversionType == 'FtoC' ? Colors.yellow : Colors.grey,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _conversionType = 'CtoF';
                    });
                  },
                  child: Text('Celsius to Fahrenheit'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black, backgroundColor: _conversionType == 'CtoF' ? Colors.yellow : Colors.grey,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_conversionType != null) {
                  _convertTemperature();
                }
              },
              child: Text('Convert'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.blue,
              ),
            ),
            SizedBox(height: 20),
            if (_result.isNotEmpty)
              Text(
                'Result: $_result',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
              ),
            SizedBox(height: 20),
            Text('History:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue)),
            Expanded(
              child: ListView.builder(
                itemCount: _history.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_history[index], style: TextStyle(color: Colors.blue)),
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