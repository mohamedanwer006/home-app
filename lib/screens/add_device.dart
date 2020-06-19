import 'package:flutter/material.dart';
import 'package:home_app/screens/add_device_page2.dart';

///Add new device with AP mode
class AddDevicePage extends StatefulWidget {
  static const String route = '/addDevice';
  @override
  _AddDevicePageState createState() => _AddDevicePageState();
}

class _AddDevicePageState extends State<AddDevicePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        elevation: 0,
        title: Text(
          'Add device',
          style: Theme.of(context).textTheme.headline6.copyWith(color:Colors.white),
        ),
             leading: Padding(
          padding: const EdgeInsets.all(12.0),
          child: MaterialButton(
            onPressed: () => Navigator.pop(context),
            padding: EdgeInsets.all(0),
            minWidth: 32,
            height: 32,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.elliptical(16.0, 16.0)),
            ),
            child: Center(
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height:250,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal:10,),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(18),
                        color: Theme.of(context).cardColor,
                      ),
                      child: tut()
                    ),
                  ),
                ),
              ),
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 350,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(18),
                        color: Theme.of(context).cardColor,
                      ),
                      child:Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Image.asset('assets/images/ap.jpg',fit: BoxFit.fill
                        ,),
                      )
                    ),
                  ),
              ),
               ),
            ],
          ),
      ),
      floatingActionButton: MaterialButton(
        child: Text('Next',style:Theme.of(context).textTheme.headline6,),
        height: 45,
        minWidth: 120,
        elevation: 0,
        color: Theme.of(context).accentColor,
        onPressed: (){
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => AddDevicePage2(),));
        },
      ),
    );
  }

  Widget tut(){
    var textTheme=Theme.of(context).textTheme.subtitle1;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22,vertical: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('1. Power device',style: textTheme,),
          Text('2. Open Settings>Wi-Fi',style: textTheme,),
          Text('3. Select ACDevice',style: textTheme,),
          Text('3. Enter password MD1234567',style: textTheme,),
          Text('4. Click Next',style: textTheme,),
          // Text('5. Enter your network password'),
        ],
      ),
    );
  }
}
