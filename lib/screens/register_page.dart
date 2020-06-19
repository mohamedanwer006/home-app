import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:home_app/components/show_loading.dart';
import 'package:home_app/screens/home_page.dart';
import 'package:home_app/screens/login_screen.dart';
import 'package:home_app/services/api/auth.dart';
import 'package:home_app/services/provider/user_provider.dart';
import 'package:home_app/theme/color.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  static const String route = '/register';
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  AuthServices _authServices = AuthServices();
  final _formKey = GlobalKey<FormState>();
  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  final userProvider = UserProvider();

  bool isVisiable=true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Container(),
      ),
      resizeToAvoidBottomPadding: true,
      body: Stack(
        children: <Widget>[
          Positioned(
           top: 0,
            left: 0,
            child:  Container(
                height: 100,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    direction: Axis.vertical,
                    children: [
                      Text(
                        'Hello!,',
                        style: Theme.of(context)
                            .textTheme
                            .headline3
                            .copyWith(color: AppColors.accentColor_dark),
                      ),
                      Text(
                        'Create new account!',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ],
                  ),
                )
                ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.15,
            left: MediaQuery.of(context).size.width > 450
                ? MediaQuery.of(context).size.width * 0.25
                : 0,
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              alignment: WrapAlignment.start,
              direction: Axis.vertical,
              children: [
                Container(
                  height: 300,
                      width: MediaQuery.of(context).size.width > 450
                          ? MediaQuery.of(context).size.width * 0.5
                          : MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                      ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          child: Column(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                    color: Theme.of(context).backgroundColor,
                                child: Padding(
                                 padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                  child: TextFormField(
                                    controller: _name,
                                    style: TextStyle(
                                          fontSize: 22,
                                          color: AppColors.accentColor_dark,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        decoration: InputDecoration(
                                            hintText: 'Your name',
                                            hintStyle: Theme.of(context)
                                                .textTheme
                                                .subtitle1,
                                            border: InputBorder.none),
                                    validator: (val) {
                                      if (val.isEmpty) {
                                        return 'Please Enter Your name';
                                      } else {
                                        return null;
                                      }
                                    },
                                    // onSaved: (val) => _name = val,
                                  ),
                                ),
                              ),
                               SizedBox(
                                    height: 22,
                                  ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                    color: Theme.of(context).backgroundColor,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                  child: TextFormField(
                                    controller: _email,
                                    keyboardType: TextInputType.emailAddress,
                                    style: TextStyle(
                                          fontSize: 22,
                                          color: AppColors.accentColor_dark,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        decoration: InputDecoration(
                                            hintText: 'Email',
                                            hintStyle: Theme.of(context)
                                                .textTheme
                                                .subtitle1,
                                            border: InputBorder.none),
                                    validator: (email) {
                                      bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
                                      if (!emailValid) {
                                        return 'Please Enter  Valid Email';
                                      } else {
                                        return null;
                                      }
                                    },
        
                                  ),
                                ),
                              ),
                               SizedBox(
                                    height: 22,
                                  ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                    color: Theme.of(context).backgroundColor,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                  child: TextFormField(
                                    keyboardType: TextInputType.visiblePassword,
                                    controller: _password,
                                     obscureText: isVisiable,
                                        style: TextStyle(
                                          fontSize: 22,
                                          color: AppColors.accentColor_dark,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        decoration: InputDecoration(
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              Icons.remove_red_eye,
                                              color: isVisiable
                                                  ? null
                                                  : AppColors.accentColor_dark,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                isVisiable = !isVisiable;
                                              });
                                            },
        
                                          ),
                                          hintText: 'Password',
                                          hintStyle:
                                              Theme.of(context).textTheme.subtitle1,
                                          border: InputBorder.none,
                                        ),
                                    validator: (val) {
                                      if (val.isEmpty) {
                                        return 'Please Enter Your Password';
                                      } else if (val.length < 6) {
                                        return 'password need to be least 6 character';
                                      } else {
                                        return null;
                                      }
                                    },
                                   
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                       
                       
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
           Positioned(
              top: MediaQuery.of(context).size.height * 0.6,
              left: 0,
              right: 0,
              child: Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                child: Center(
                    child: Wrap(
                  spacing: 50,
                  direction: Axis.vertical,
                  alignment: WrapAlignment.spaceAround,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    MaterialButton(
                      color: AppColors.primaryColor_dark,
                      onPressed: _signUp,
                      minWidth: 178,
                      height: 52,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Text(
                        'Create',
                        style: Theme.of(context).textTheme.headline6.copyWith(
                              color: AppColors.accentColor_dark,
                            ),
                      ),
                    ),
                    Wrap(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: 52,
                          child: Text(
                            'Have account ',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                        Container(
                          child: FlatButton(
                            child: Text(
                              'Log in! ',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .copyWith(color: AppColors.accentColor_dark),
                            ),
                             onPressed: () {
                              Navigator.of(context).pushReplacementNamed(LoginPage.route);
                            },
                            splashColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            color: Colors.transparent,
                            highlightColor: Colors.transparent,
                          ),
                        ),
                      ],
                    )
                  ],
                )),
              ))
          
        ],
      ),
    );
  }

  Future<void> _signUp() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      showLoading(context);
      try {
        var user = await _authServices.createUserWithEmailAndPassword(
            _name.text, _email.text, _password.text);
        if (user != null) {
          Provider.of<UserProvider>(context).setUser(user);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        }
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Center(
              child: Text(
                'Error',
              ),
            ),
            content: Text('Oh no!🤦‍♂️ can\'t Create account , please try again later'),
            contentTextStyle: TextStyle(color: Colors.black),
          ),
        );
      }
    }
  }
}
