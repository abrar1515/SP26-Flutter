import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const DiceApp());
}

class DiceApp extends StatelessWidget {
  const DiceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DiceHomePage(),
    );
  }
}

class DiceHomePage extends StatefulWidget {
  const DiceHomePage({super.key});

  @override
  State<DiceHomePage> createState() => _DiceHomePageState();
}

class _DiceHomePageState extends State<DiceHomePage> {
  final Random _random = Random();
  final TextEditingController _guessController = TextEditingController();

  int _dieValue = 1;
  String _resultMessage = 'Enter your guess (1-6), then roll.';

  static const List<String> _diceFaces = ['⚀', '⚁', '⚂', '⚃', '⚄', '⚅'];

  int _rollDie() {
    return _random.nextInt(6) + 1;
  }

  void _rollDice() {
    setState(() {
      _dieValue = _rollDie();

      final guess = int.tryParse(_guessController.text.trim());

      if (guess == null) {
        _resultMessage = 'Please type a number from 1 to 6.';
      } else if (guess < 1 || guess > 6) {
        _resultMessage = 'Guess must be between 1 and 6.';
      } else if (guess == _dieValue) {
        _resultMessage = 'Correct! You guessed $guess.';
      } else {
        _resultMessage = 'Wrong guess. You picked $guess, dice is $_dieValue.';
      }
    });
  }

  @override
  void dispose() {
    _guessController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dice Roll Game')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _DiceFace(value: _dieValue, face: _diceFaces[_dieValue - 1]),
            const SizedBox(height: 20),
            Text('Dice: $_dieValue', style: const TextStyle(fontSize: 28)),
            const SizedBox(height: 16),
            SizedBox(
              width: 220,
              child: TextField(
                controller: _guessController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Your guess (1-6)',
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _rollDice,
              child: const Text('Roll Dice'),
            ),
            const SizedBox(height: 16),
            Text(
              _resultMessage,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class _DiceFace extends StatelessWidget {
  const _DiceFace({required this.value, required this.face});

  final int value;
  final String face;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 92,
      height: 92,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black26),
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(face, style: const TextStyle(fontSize: 42)),
          Text('$value', style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
