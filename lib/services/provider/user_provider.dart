import 'package:flutter/material.dart';
import 'package:home_app/models/user.dart';
import 'package:home_app/services/api/auth.dart';
// import 'package:home_app/services/api/auth.dart';

class UserProvider with ChangeNotifier {
  AuthServices _authServices = AuthServices();

  String _error;
  bool _isLoading;
  User _user ;

  String get error => _error;
  bool get isLoading => _isLoading;
  User get user => _user;

  setError(String error) {
    this._error = error;
    notifyListeners();
  }

  setIsLoading(bool isLoading) {
    this._isLoading = isLoading;
  }

  setUser(User user) {
    this._user = user;
    notifyListeners();
  }
/// todo : signIn with provider
  Future<bool> signInWithEmailAndPassword(String email, String password) async{
    // setIsLoading(true);
    // try{
    //  var user =   await _authServices.signInWithEmailAndPassword(email, password);
    //  if(user != null){
    //   setUser(user);
    //  }
    // }catch(e){
    //   setError('Oh no!🤦‍♂️ can\'t login so please try again later');
    // }
      
    // }).catchError((error) {
    //   setError('Oh no!🤦‍♂️ can\'t login so please try again later');
    // });
    return null;
  }
//todo : create with provider
  Future<bool> createUserWithEmailAndPassword(
      String name, String email, String password)async {
    // setIsLoading(true);
    // var value =await _authServices
    //     .createUserWithEmailAndPassword(name, email, password);
    // //     .then((value) {
    //   setUser(value);
    // //   setIsLoading(false);
 
    // // }).catchError((error) {
    // //   setError('Oh no!🤦‍♂️ can\'t register so please try again later');
   
    // // });
    // return isUser();
     return null;
  }

   Future<User > currentUser()async {
    try{
      return await _authServices.user();
    }catch(e){
      return null;
    }
  }

  bool isUser() {
    return _user != null ? true : false;
  }

}
