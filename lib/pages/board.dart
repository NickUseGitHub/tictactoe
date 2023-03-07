import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/pages/home.dart';

import '../ctx/user_data.dart';
import '../widgets/boxplay.dart';

class Board extends StatefulWidget {
  static const String id = 'board_screen';

  const Board({super.key});

  @override
  State<Board> createState() => _BoardState();
}

class _BoardState extends State<Board> {
  List<String> _boxTables = ['', '', '', '', '', '', '', '', ''];
  int _countClick = 0;

  @override
  void initState() {
    super.initState();
  }

  String? getPlayerName(BuildContext context) {
    return Provider.of<UserData>(context).getUserData()?.user?.email;
  }

  _onBoxPlayClick(int index) {
    return () {
      if (_countClick >= 9 || _boxTables[index].isNotEmpty) {
        return;
      }

      setState(() {
        _countClick += 1;
        _boxTables[index] = _countClick % 2 == 1 ? 'x' : 'o';
      });
    };
  }

  _onFloatButtonClick() {
    setState(() {
      _boxTables = ['', '', '', '', '', '', '', '', ''];
      _countClick = 0;
    });
  }

  _onFloatBackButtonClick() {
    Navigator.pushReplacementNamed(
      context,
      Home.id,
    );
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      // appBar: AppBar(
      //   // Here we take the value from the MyHomePage object that was created by
      //   // the App.build method, and use it to set our appbar title.
      //   title: Text(widget.title),
      // ),
      body: Flex(
        direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.start,
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        children: <Widget>[
          Container(
            height: 500,
            child: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 3,
              children: _boxTables.asMap().entries.map((character) {
                int idx = character.key;
                String val = character.value;

                return BoxPlay(
                  display: val,
                  onBoxPlayClick: _onBoxPlayClick(idx),
                );
              }).toList(),
            ),
          ),
          Column(
            // Column is also a layout widget. It takes a list of children and
            // arranges them vertically. By default, it sizes itself to fit its
            // children horizontally, and tries to be as tall as its parent.
            //
            // Invoke "debug painting" (press "p" in the console, choose the
            // "Toggle Debug Paint" action from the Flutter Inspector in Android
            // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
            // to see the wireframe for each widget.
            //
            // Column has various properties to control how it sizes itself and
            // how it positions its children. Here we use mainAxisAlignment to
            // center the children vertically; the main axis here is the vertical
            // axis because Columns are vertical (the cross axis would be
            // horizontal).
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const <Widget>[
              Text(
                'You have pushed the button this many times:',
              ),
            ],
          ),
          Text("Hello ${getPlayerName(context)}"),
          FloatingActionButton.extended(
            heroTag: "btnPlayAgain",
            icon: const Icon(Icons.refresh),
            label: const Text('Play again'),
            onPressed: _onFloatButtonClick,
          ),
          const SizedBox(width: double.infinity, height: 20),
          FloatingActionButton.extended(
            heroTag: "backToHome",
            icon: const Icon(Icons.arrow_back),
            label: const Text('Back to home'),
            onPressed: _onFloatBackButtonClick,
          )
        ],
      ),
    );
  }
}
