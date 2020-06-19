import 'package:flutter/material.dart';
import 'package:home_app/components/show_loading.dart';
import 'package:home_app/main.dart';
import 'package:home_app/screens/home_page.dart';
import 'package:home_app/services/ap_mode/add_device_services.dart';
import 'package:home_app/theme/theme_changer.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

///Add new device with AP mode
class AddDevicePage2 extends StatefulWidget {
  @override
  _AddDevicePage2State createState() => _AddDevicePage2State();
}

class _AddDevicePage2State extends State<AddDevicePage2> {
  TextEditingController _ssidController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  SharedPreferences sharedPreferences;
  final _formKey = GlobalKey<FormState>();
  APModeServices _apModeServices = APModeServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        elevation: 0,
        title: Text(
          'Add device',
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(color: Colors.white),
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
      body: Consumer<ThemeChanger>(
        builder: (context, theme, child) => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: 100,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: Theme.of(context).cardColor,
                      ),
                      child: tut()),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 250,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: Theme.of(context).cardColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: form(),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: MaterialButton(
        child: Text(
          'Next',
          style: Theme.of(context).textTheme.headline6,
        ),
        height: 45,
        minWidth: 120,
        elevation: 0,
        color: Theme.of(context).accentColor,
        onPressed: sendData,
      ),
    );
  }

  Widget form() {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _ssidController,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
              decoration: InputDecoration(
                hintText: 'Wi_Fi SSID',
                hintStyle: Theme.of(context).textTheme.subtitle1,
              ),
              validator: (val) {
                if (val.isEmpty) {
                  return 'Please Enter Your Wi_Fi SSID';
                } else {
                  return null;
                }
              },
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              keyboardType: TextInputType.visiblePassword,
              controller: _passController,
              obscureText: true,
              style: TextStyle(
                
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
              decoration: InputDecoration(
                hintText: 'Wi_Fi Password',
                hintStyle: Theme.of(context).textTheme.subtitle1,
              ),
              validator: (val) {
                if (val.isEmpty) {
                  return 'Please Enter Your Wi_Fi Password';
                } else if (val.length < 6) {
                  return 'password need to be least 8 character';
                } else {
                  return null;
                }
              },
            ),
          ],
        ));
  }

  Widget tut() {
    var textTheme = Theme.of(context).textTheme.headline6;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            '1. Enter you network ssid',
            style: textTheme,
          ),
          Text(
            '2. Enter you network pass',
            style: textTheme,
          ),
          Text(
            '3. Click Next',
            style: textTheme,
          ),
          // Text('5. Enter your network password'),
        ],
      ),
    );
  }

  sendData() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      try {
        //TODO:if not connect to server after 10 s;
        showLoading(context);
        var res = await _apModeServices.sendData(
            _ssidController.text, _passController.text);
        if (res != null) {
          if (res) {
            Navigator.pushReplacementNamed(context, HomePage.route);
          } else {
            showError();
          }
        }
      } catch (e) {
        showError();
      }
    }
  }


  showError() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        actions: [
          RaisedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Text('Ok'),
          )
        ],
        title: Center(
          child: Text(
            'Error',
          ),
        ),
        content: Text(
            'Oh no!🤦‍♂️ can\'t add device , please make sure you connect to ACDevice'),
        contentTextStyle: TextStyle(color: Colors.black),
      ),
    );
  }
}
