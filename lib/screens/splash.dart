import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: true,
        body: Container(
          color: Theme.of(context).backgroundColor,
          child: Center(
            child: Text('Smart Home',style: Theme.of(context).textTheme.headline2,),
          ),
        ));
  }
}
