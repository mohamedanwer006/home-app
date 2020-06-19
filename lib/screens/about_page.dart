import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  static const route = '/about';
  const AboutPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text('About',style: Theme.of(context).textTheme.headline6.copyWith(color:Colors.white),),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Made with ❤ by : Mohamed anwar'),
          ),
  
          ListTile(
            leading: Icon(Icons.email),
            title: SelectableText('mohamedanwer006@gmail.com '),
          ),
        ],
      ),
    );
  }
}
