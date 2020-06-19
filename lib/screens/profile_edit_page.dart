import 'dart:io';
import 'package:flutter/material.dart';
import 'package:home_app/components/icon_button.dart';
import 'package:home_app/components/show_loading.dart';
import 'package:home_app/services/api/uploadfiles.dart';
import 'package:home_app/services/api/user.dart';
import 'package:home_app/services/provider/user_provider.dart';
import 'package:home_app/theme/color.dart';
import 'package:home_app/theme/theme_changer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileEditPage extends StatefulWidget {
  static const String route = '/profileEdit';
  @override
  _ProfileEditPageState createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  TextEditingController nameController = TextEditingController();
  File _image;
  UploadServices _uploadServices = UploadServices();
  UserServices _userServices = UserServices();

  GlobalKey key = GlobalKey();
  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context, listen: true).user;
    return Scaffold(
      key: key,
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: buildAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(22.0),
                  bottomLeft: Radius.circular(22.0),
                ),
                color: Theme.of(context).primaryColor,
              ),
              child: Wrap(
                direction: Axis.vertical,
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      child: Wrap(
                        alignment: WrapAlignment.start,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        direction: Axis.vertical,
                        children: [
                          Hero(
                            tag: 'profile',
                            transitionOnUserGestures: false,
                            child: GestureDetector(
                              onTap: _selectImage,
                              child: Container(
                                width: 90.0,
                                height: 90.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.elliptical(45.0, 45.0)),
                                  image: DecorationImage(
                                    image: user != null
                                        ? NetworkImage('${user.picture}')
                                        : const NetworkImage(
                                            'https://celebmafia.com/wp-content/uploads/2017/04/scarlett-johansson-glamour-magazine-mexico-april-2017-issue-6.jpg'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: 30,
                            alignment: Alignment.centerRight,
                            child: TextField(
                              controller: nameController,
                              autofocus: true,
                              textInputAction: TextInputAction.done,
                              style: TextStyle(
                                fontSize: 18,
                                // color: AppColors.accentColor_dark,
                                fontWeight: FontWeight.w400,
                              ),
                              onSubmitted: (value) {
                                _updateUserDetails();
                              },
                              decoration: InputDecoration(
                                  hintText: 'Enter new name',
                                  hintStyle:
                                      Theme.of(context).textTheme.subtitle1,
                                  border: InputBorder.none),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
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
      actions: [
        Padding(
          padding: const EdgeInsets.only(top: 12.0, bottom: 12),
          child: Consumer<ThemeChanger>(
            builder: (context, value, child) => RectIconButton(
              height: 28,
              width: 28,
              onPressed: _updateUserDetails,
              color: value.darkTheme
                  ? AppColors.iconsColorBackground2_dark
                  : AppColors.iconsColorBackground3_light,
              child: Icon(
                Icons.done,
                color: value.darkTheme
                    ? AppColors.iconsColor_dark
                    : AppColors.iconsColor_light,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _selectImage() {
    getImage();
  }

  void _updateUserDetails() async {
    var user = Provider.of<UserProvider>(context).user;
    var _name = nameController.text;
    if (_image != null && _name.length > 0) {
      showLoading(context);
      String _picUrl = await _uploadServices.uploadImage(_image);
      Map data = {
        "picture": _picUrl,
        "name": _name,
      };
      var res = await _userServices.updateUser(user.id, data);
      if (res != null) {
        Provider.of<UserProvider>(context).setUser(res);
        stopLoading();
        print('complet update user info');
      } else {
        stopLoading();
        print('error');
      }
    } else if (_image != null && _name.length == 0) {
      showLoading(context);
      String _picUrl = await _uploadServices.uploadImage(_image);
      Map data = {
        "picture": _picUrl,
      };
      var res = await _userServices.updateUser(user.id, data);
      if (res != null) {
        Provider.of<UserProvider>(context).setUser(res);
        stopLoading();
        print('complet update device info');
      } else {
        stopLoading();
        print('error');
      }
    } else if (_image == null && _name.length > 0) {
      showLoading(context);
      Map data = {
        "name": _name,
      };
      var res = await _userServices.updateUser(user.id, data);
      if (res != null) {
        Provider.of<UserProvider>(context).setUser(res);
        stopLoading();
        print('complet update device info');
      } else {
        stopLoading();
        print('error');
      }
    } else if (_image == null && _name.length == 0) {
      //Nothing
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Container(
              child: Text(
                'no changes to update 🙄',
                style: TextStyle(color: Colors.black),
              ),
            ),
          );
        },
      );
    } else {}
  }

  stopLoading() {
    Navigator.pop(context);
    Navigator.pop(context);
  }
}