import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  String current = _generateWordPairWithSpace();

  void getNext() {
    current = _generateWordPairWithSpace();
    notifyListeners();
  }

  static String _generateWordPairWithSpace() {
    var pair = WordPair.random();
    return '${_capitalize(pair.first)} ${_capitalize(pair.second)}';
  }

  static String _capitalize(String word) {
    if (word.isEmpty) return word;
    return word[0].toUpperCase() + word.substring(1);
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Scaffold(
      body: Center(
        // Center the column within the screen
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, // Center items vertically
          children: [
            Text('Hello World'),
            Text(
              'Here\'s a random idea:',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center, // Center-align text horizontally
            ),
            SizedBox(height: 10), // Space between text widgets
            Text(
              appState.current,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
              textAlign: TextAlign.center, // Center-align text horizontally
            ),
            SizedBox(height: 20), // Space between text and button
            ElevatedButton(
              onPressed: () {
                appState.getNext();
              },
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
