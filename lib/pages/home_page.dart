
import 'dart:math';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _diceList = <String>[
    'images/d1.PNG',
    'images/d2.PNG',
    'images/d3.PNG',
    'images/d4.PNG',
    'images/d5.PNG',
    'images/d6.PNG',
  ];
  int _index1 = 0, _index2 = 0, _diceSum = 0, _point = 0;
  bool _hasGameStarted = false;
  bool _isGameOver = false;
  String _statusMsg = '';
  final _random = Random.secure();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Dice Game'),
      ),
      body: Center(
        child: _hasGameStarted ? _gameSection() : _startGameSection(),
      ),
    );
  }

  Widget _gameSection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              _diceList[_index1],
              width: 100,
              height: 100,
            ),
            const SizedBox(
              width: 5,
            ),
            Image.asset(
              _diceList[_index2],
              width: 100,
              height: 100,
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        ElevatedButton(onPressed: _rollTheDice, child: const Text('ROLL')),
        const SizedBox(
          height: 5,
        ),
        Text(
          'Dice Sum : $_diceSum',
          style: const TextStyle(fontSize: 22),
        ),
        const SizedBox(
          height: 5,
        ),
        if(_point > 0)Text(
          'Your Point: $_point',
          style: const TextStyle(fontSize: 22, color: Colors.greenAccent),
        ),
        const SizedBox(
          height: 5,
        ),
        if(_point > 0 && !_isGameOver)const Text(
          'Keep rolling until you match your point',
          style: TextStyle(
              fontSize: 20,
              color: Colors.black26,
              backgroundColor: Colors.white),
        ),
        const SizedBox(height: 5,),
        if(_isGameOver)Text(
          _statusMsg,
          style:const TextStyle(
            fontSize: 30,
            color: Colors.cyan
          ),
        ),
        const SizedBox(height: 5,),
        if(_isGameOver)ElevatedButton(
            onPressed: _resetGame,
            child: const Text('Play Again'))
      ],
    );
  }

  Widget _startGameSection() {
    return ElevatedButton(
        onPressed: () {
          setState(() {
            _hasGameStarted = true;
          });
        },
        child: const Text('START'));
  }

 void _rollTheDice() {
    setState((){
      _index1 = _random.nextInt(6);
      _index2 = _random.nextInt(6);

      _diceSum = _index1 + _index2 +2;

      if(_point > 0){
        _checkSecondThrow();
      }
      else{
        _checkFirstThrow();
      }
    });
 }

  void _checkFirstThrow() {
    switch(_diceSum){
      case 7:
      case 11:
        _statusMsg ='You Win!!!';
        _isGameOver =true;
        break;

      case 2:
      case 3:
      case 12:
        _statusMsg ='You Loose!!!!';
        _isGameOver =true;
        break;
      default:
        _point = _diceSum;
        break;

    }
  }

  void _checkSecondThrow() {
    if(_diceSum==_point){
      _statusMsg ='You Win!!!';
      _isGameOver =true;

    }else if(_diceSum == 7){
      _statusMsg ='You Loose!!!!';
      _isGameOver =true;
    }
  }


  void _resetGame() {
    setState((){
      _index1 =0;
      _index2 = 0;
      _diceSum = 0;
      _point = 0;
      _hasGameStarted = false;
      _isGameOver = false;
    });
  }
}
