import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool ohTurn = true;
  int ohScore = 0;
  int ehScore = 0;
  int filledBoxes = 0;
  List<String> displayEhox = ['', '', '', '', '', '', '', '', ''];

  var MytextStyle =
      TextStyle(color: Colors.white, fontSize: 24.00, fontFamily: 'RussoOne');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Player X',
                          style: MytextStyle,
                        ),
                        Text(
                          ehScore.toString(),
                          style: MytextStyle,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Player O',
                          style: MytextStyle,
                        ),
                        Text(
                          ohScore.toString(),
                          style: MytextStyle,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: GridView.builder(
                padding: EdgeInsets.all(20.00),
                itemCount: 9,
                gridDelegate: 
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      _tapped(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Center(
                        child: Text(
                          displayEhox[index],
                          style: TextStyle(color: Colors.white, fontSize: 40),
                        ),
                      ),
                    ),
                  );
                }),
          ),
          Expanded(child: Container(
            child: Center(child: Text('TIC TAC TOE',style: TextStyle(color: Colors.grey[300],fontSize: 24),)),
          )),
        ],
      ),
    );
  }

  void _tapped(int index) {
    setState(() {
      if (ohTurn && displayEhox[index] == '') {
        displayEhox[index] = 'O';
        filledBoxes++;
      } else if (!ohTurn && displayEhox[index] == '') {
        displayEhox[index] = 'X';
        filledBoxes++;
      }
      ohTurn = !ohTurn;
      checkWinner();
    });
  }

  void checkWinner() {
    if (displayEhox[0] == displayEhox[1] &&
        displayEhox[0] == displayEhox[2] &&
        displayEhox[0] != '') {
      _showDialog(displayEhox[0]);
    }

    //2nd row
    else if (displayEhox[3] == displayEhox[4] &&
        displayEhox[3] == displayEhox[5] &&
        displayEhox[3] != '') {
      _showDialog(displayEhox[3]);
    }

    //3rd row
    else if (displayEhox[6] == displayEhox[7] &&
        displayEhox[6] == displayEhox[8] &&
        displayEhox[6] != '') {
      _showDialog(displayEhox[6]);
    }

    //1st column
    else if (displayEhox[0] == displayEhox[3] &&
        displayEhox[0] == displayEhox[6] &&
        displayEhox[0] != '') {
      _showDialog(displayEhox[0]);
    }

    //2nd column
    else if (displayEhox[1] == displayEhox[4] &&
        displayEhox[1] == displayEhox[7] &&
        displayEhox[1] != '') {
      _showDialog(displayEhox[1]);
    }
    //3rd column
    else if (displayEhox[2] == displayEhox[5] &&
        displayEhox[2] == displayEhox[8] &&
        displayEhox[2] != '') {
      _showDialog(displayEhox[2]);
    }

    //1st vector
    else if (displayEhox[0] == displayEhox[4] &&
        displayEhox[0] == displayEhox[8] &&
        displayEhox[0] != '') {
      _showDialog(displayEhox[0]);
    }
    //2nd vector
    else if (displayEhox[2] == displayEhox[4] &&
        displayEhox[2] == displayEhox[6] &&
        displayEhox[2] != '') {
      _showDialog(displayEhox[2]);
    } 
    //draw
    else if (filledBoxes == 9) {
      _showdrawDailog();
    }
  }

  void _showdrawDailog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: ((context) {
          return AlertDialog(
            title: Text('It,s a Draw !!'),
            actions: <Widget>[
              TextButton(
                  onPressed: (() {
                    _clearboard();
                    Navigator.of(context).pop();
                  }),
                  child: Text("Play Again"))
            ],
          );
        }));
  }

  void _showDialog(String winner) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: ((context) {
          return AlertDialog(
            title: Text('Winner is ${winner}'),
            actions: <Widget>[
              TextButton(
                  onPressed: (() {
                    _clearboard();
                    Navigator.of(context).pop();
                  }),
                  child: Text("Play Again"))
            ],
          );
        }));

    if (winner == 'O') {
      ohScore++;
    } else {
      ehScore++;
    }
  }

  void _clearboard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayEhox[i] = '';
      }
      ohTurn = true;
    });
    filledBoxes = 0;
  }
}