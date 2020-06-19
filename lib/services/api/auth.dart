import 'dart:convert';
import 'package:home_app/models/credentials.dart';
import 'package:home_app/models/user.dart';
import 'package:home_app/services/api/api.dart';
import 'package:home_app/services/api/pref_services.dart';
import 'package:http/http.dart' as http;

class AuthServices extends PrefServices{
  // Login 
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    String url = Api.authUrl;
    Map body = {'email': email, 'password': password};
    http.Response response = await http.post(url, body: body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      saveCredentials(credentialsToJson(Credentials(email: email,password: password)));
      setToken(data['token']);
      saveUserData(json.encode(data['user']));
      return User.fromMap(data['user']);
    } else {
      throw Exception('Error ${response.statusCode}');
    }
  }

  Future<bool> logOut()async {
    await removToken();
    await removUser();
    await removeCredentials();
    return true;
  }

  Future<User> createUserWithEmailAndPassword(
      String name, String email, String password) async {
    String url = Api.userUrl;
    Map body = {"name": name, " email": email, "password": password};
    http.Response response = await http.post(url, body: body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      saveCredentials(credentialsToJson(Credentials(email: email,password: password)));
      setToken(data['token']);
      saveUserData(json.encode(data['user']));
      return User.fromMap(data['user']);
    } else {
      throw Exception('Error ${response.statusCode}');
    }
  }

  Future<User> user() async {
    try{
      return  User.fromMap(jsonDecode( await getUserData()));
    }catch(e){
      return null ;
    }
  }
  

}


//  Form(
//                           key: _formKey,
//                           child: Column(
//                             children: <Widget>[
//                               Padding(
//                                 padding: const EdgeInsets.only(
//                                     left: 10.0, right: 10.0),
//                                 child: TextFormField(
//                                   keyboardType: TextInputType.emailAddress,
//                                   decoration: InputDecoration(
//                                       hintText: 'Your name',
//                                       hintStyle: TextStyle(color: Colors.white),
//                                       prefixIcon: Icon(Icons.person),
//                                       enabledBorder: OutlineInputBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(15),
//                                           borderSide: BorderSide(
//                                               width: 2,
//                                               color: Colors.lightBlue,
//                                               style: BorderStyle.solid)),
//                                       border: OutlineInputBorder(
//                                         borderRadius: BorderRadius.circular(10),
//                                       )),
//                                   validator: (val) {
//                                     if (val.isEmpty) {
//                                       return 'Please Enter Your name';
//                                     }else{return null;}
//                                   },
//                                   onSaved: (val) => _name = val,
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: 15,
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(
//                                     left: 10.0, right: 10.0),
//                                 child: TextFormField(
//                                   keyboardType: TextInputType.emailAddress,
//                                   decoration: InputDecoration(
//                                       hintText: 'Email',
//                                        hintStyle: TextStyle(color: Colors.white),
//                                       prefixIcon: Icon(Icons.email),
//                                       enabledBorder: OutlineInputBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(15),
//                                           borderSide: BorderSide(
//                                               width: 2,
//                                               color: Colors.lightBlue,
//                                               style: BorderStyle.solid)),
//                                       border: OutlineInputBorder(
//                                         borderRadius: BorderRadius.circular(10),
//                                       )),
//                                   validator: (val) {
//                                     if (val.isEmpty) {
//                                       return 'Please Enter Your Email';
//                                     }else{return null;}
//                                   },
//                                   onSaved: (val) => _email = val,
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: 15,
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(
//                                     left: 10.0, right: 10.0),
//                                 child: TextFormField(
//                                   obscureText: passSecure,
//                                   decoration: InputDecoration(
//                                       hintText: 'Password',
//                                       hintStyle: TextStyle(color: Colors.white),
//                                       prefixIcon: Icon(Icons.lock),
//                                       suffixIcon: IconButton(
//                                         icon: Icon(Icons.remove_red_eye),
//                                         onPressed: () {
//                                           setState(() {
//                                             passSecure = !passSecure;
//                                           });
//                                         },
//                                       ),
//                                       enabledBorder: OutlineInputBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(15),
//                                           borderSide: BorderSide(
//                                               width: 2,
//                                               color: Colors.lightBlue,
//                                               style: BorderStyle.solid)),
//                                       border: OutlineInputBorder(
//                                         borderRadius: BorderRadius.circular(10),
//                                       )),
//                                   validator: (val) {
//                                     if (val.isEmpty) {
//                                       return 'Please Enter Your Password';
//                                     } else if (val.length < 6) {
//                                       return 'password need to be least 6 character';
//                                     }else{return null;}
//                                   },
//                                   onSaved: (val) => _password = val,
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: 45,
//                               ),
//                               Container(
//                                 width: width,
//                                 alignment: Alignment.center,
//                                 child: RaisedButton(
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(10),
//                                   ),
//                                   color: Colors.lightBlue,
//                                   child: Padding(
//                                     padding: const EdgeInsets.only(
//                                         left: 45,
//                                         right: 45,
//                                         top: 10,
//                                         bottom: 10),
//                                     child: Text('Sign Up'),
//                                   ),
//                                   onPressed: () {
//                                     signUp();
//                                   },
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),

// Future<void> signUp() async {
//     final formState = _formKey.currentState;
//     if (formState.validate()) {
//       formState.save();
//       setState(() {
//          isLoading = true;
//       });
//       _firebaseServices
//           .signUp(_name, _email, _password)
//           .then((user) {
//             _firebaseServices.userToDB(user)
//                 .then((val){
//               Navigator.of(context).pushReplacement(MaterialPageRoute(
//                 builder: (context) => SignInScreen()
//               ));
//             }).catchError((e)=>print(e));
//       })
//           .catchError((e) {
//         print(e);
//       });
//     }
//   }