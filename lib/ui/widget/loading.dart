import 'package:flutter/material.dart';


class Loading extends StatelessWidget {
  const Loading();

  @override
  Widget build(BuildContext context) {

    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
        ),
      ),
      color: Colors.white.withOpacity(0.7),
    );
  }
}
