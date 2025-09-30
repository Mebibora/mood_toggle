import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => MoodModel(),
      child: MyApp(),
    ),
  );
}

// Mood Model - The "Brain" of our app
class MoodModel with ChangeNotifier {
  String _currentMood = '\u{1F601} ';
  Color _bgColor = Colors.white;
  Color get backgroundColor => _bgColor;
  String get currentMood => _currentMood;
  int happyCount = 0;
  int sadCount = 0;
  int excitedCount = 0;
  int randomInt = 0;
  int randomCount = 0;

  void setHappy() {    
    _currentMood = '\u{1F601} ';
    _bgColor = Colors.yellow;
    happyCount += 1;
    notifyListeners();  
  }

  void setSad() {
    _currentMood = '\u{1F61F} ';
    _bgColor = Colors.blue;
    sadCount += 1;
    notifyListeners();
  }

  void setExcited() {
    _currentMood = '\u{1F929} ';
    _bgColor = Colors.orange;
    excitedCount += 1;
    notifyListeners();
  }

  void setRandom() {
    randomInt = Random().nextInt(3);
    switch (randomInt){
      case 0:
        _currentMood = '\u{1F601} ';
        _bgColor = Colors.yellow;
      case 1:
        _currentMood = '\u{1F61F} ';
        _bgColor = Colors.blue;        
      case 2:
        _currentMood = '\u{1F929} ';
        _bgColor = Colors.orange;       
    }
    randomCount += 1;
    notifyListeners();
  }
}

// Main App Widget
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: 'Mood Toggle Challenge',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
    );
  }
}

// Home Page
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Provider.of<MoodModel>(context).backgroundColor,
      appBar: AppBar(title: Text('Mood Toggle Challenge')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('How are you feeling?', style: TextStyle(fontSize: 24)),
            SizedBox(height: 30),
            MoodDisplay(),
            SizedBox(height: 50),
            MoodButtons(),
          ],
        ),
      ),
    );
  }
}

// Widget that displays the current mood
class MoodDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MoodModel>(
      builder: (context, moodModel, child) {
        return Text(moodModel.currentMood, style: TextStyle(fontSize: 100));
      },
    );
  }
}

// Widget with buttons to change the mood
class MoodButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Provider.of<MoodModel>(context, listen: false).setHappy();
              },
              child: Text('Happy \u{1F601} '),
            ),
            Text('${Provider.of<MoodModel>(context).happyCount}'),
          ],
        ),
        Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Provider.of<MoodModel>(context, listen: false).setSad();
              },
              child: Text('Sad \u{1F61F} '),
            ),
            Text('${Provider.of<MoodModel>(context).sadCount}'),
          ],
        ),
        Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Provider.of<MoodModel>(context, listen: false).setExcited();
              },
              child: Text('Excited \u{1F929} '),
            ),
            Text('${Provider.of<MoodModel>(context).excitedCount}'),
          ],
        ),
        Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Provider.of<MoodModel>(context, listen: false).setRandom();
              },
              child: Text('Random \u{1F914} '),
            ),
            Text('${Provider.of<MoodModel>(context).randomCount}'),
          ],
        ),
      ],
    );
  }
}
