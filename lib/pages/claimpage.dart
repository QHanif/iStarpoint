import 'package:flutter/material.dart';

class ClaimPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of claims'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('RM 5 Off Coconut Shake'),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
          // Put your code here for button 1
                  },
                  child: Text('Claim'),
                 ),
                ],
              ),
            ),
            Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('RM 5 Off Yogurt     '),
                ElevatedButton(
                  onPressed: () {
          // Put your code here for button 2
                  },
                  child: Text('Claim'),
                 ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


