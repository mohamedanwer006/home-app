import 'dart:io';
import 'package:flutter/material.dart';
import 'package:home_app/components/icon_button.dart';
import 'package:home_app/models/collections.dart';
import 'package:home_app/services/api/collection.dart';
import 'package:home_app/services/api/uploadfiles.dart';
import 'package:home_app/services/provider/collection_provider.dart';
import 'package:home_app/theme/color.dart';
import 'package:home_app/theme/theme_changer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddRoomPage extends StatefulWidget {
  static const String route = '/addroom';
  @override
  _AddRoomPageState createState() => _AddRoomPageState();
}

class _AddRoomPageState extends State<AddRoomPage> {
  final _formKey = GlobalKey<FormState>();
  File _image;
  TextEditingController nameController = TextEditingController();
  UploadServices _uploadServices = UploadServices();
  CollectionServices _collectionServices = CollectionServices();

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
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
        actions: <Widget>[
            Padding(
            padding: const EdgeInsets.only(top:12.0,bottom: 12),
            child: Consumer<ThemeChanger>(
            builder: (context, value, child) => 
             RectIconButton(
              height: 28,
              width: 28,
              onPressed: () {
                _addRoom();
              },
              color: value.darkTheme
                      ? AppColors.iconsColorBackground2_dark
                      : AppColors.iconsColorBackground3_light,
              child: Icon(
                Icons.done,
                color:value.darkTheme? AppColors.iconsColor_dark:AppColors.iconsColor_light,
              ),
            ),
        ),
          ),
        ],
        elevation: 0,
        title: Text(
          'Add room',
          style: Theme.of(context).textTheme.headline6.copyWith(color: Colors.white),
        ),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
           Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(22.0),
                bottomLeft: Radius.circular(22.0),
              ),
              color: Theme.of(context).primaryColor,
            ),
            child: Wrap(
              direction: Axis.vertical,
              crossAxisAlignment: WrapCrossAlignment.start,
              alignment: WrapAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Text(
                      'Create new room ',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2
                          .copyWith(fontSize: 12)),
                ),

                ///Room Image And Name
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Wrap(
                    direction: Axis.horizontal,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    // alignment: WrapAlignment.spaceAround,
                    children: [
                      MaterialButton(
                        minWidth: 75,
                        height: 100,
                        onPressed: _selectImage,
                        elevation: 0,
                        color: Theme.of(context).backgroundColor,
                        padding: EdgeInsets.all(0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Container(
                          width: 75.0,
                          height: 100.0,
                          child: Center(
                            child: Text(
                              'Select\nimage🖼 ',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  .copyWith(fontSize: 12),
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            image: _image == null
                                ? null
                                : DecorationImage(
                                    image: FileImage(_image),
                                    fit: BoxFit.fill,
                                  ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          decoration: BoxDecoration(
                              border: BorderDirectional(
                                  top:
                                      BorderSide(width: 1, color: Colors.white),
                                  bottom: BorderSide(
                                    width: 1,
                                    color: Colors.white,
                                  ))),
                          height: 40,
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                            child:  Form(
                                  key: _formKey,
                            child: TextFormField(
                              textInputAction: TextInputAction.done,
                              controller: nameController,
                              style: TextStyle(
                                fontSize: 18,
                                // color: AppColors.accentColor_dark,
                                fontWeight: FontWeight.w400,
                              ),
                              decoration: InputDecoration(
                                  hintText: ' Enter room name ...',
                                  hintStyle:
                                      Theme.of(context).textTheme.subtitle1,
                                  border: InputBorder.none),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'name can\'t be null';
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
            
              ],
            ),
          
          ),
                       
          ],
        ),
    
    );
  }

  void _selectImage() {
    getImage();
  }

  void _addRoom() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      try {
        showLoading();
        if (_image != null) {
          String picUrl = await _uploadServices.uploadImage(_image);
          Collection _collection =
              Collection(name: nameController.text, picture: picUrl);
          var res = await _collectionServices.createCollection(_collection);
          if (res != null) {
            Provider.of<CollectionProvider>(context)
                .setCollections(_collectionServices.getCollections());
          }
          Navigator.pop(context);
          Navigator.pop(context);
        } else {
          Collection _collection = Collection(name: nameController.text);
          var res = await _collectionServices.createCollection(_collection);
          if (res != null) {
            Provider.of<CollectionProvider>(context)
                .setCollections(_collectionServices.getCollections());
          }
          Navigator.pop(context);
          Navigator.pop(context);
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
            content:
                Text('Oh no!🤦‍♂️ can\'t Create Room , please try again later'),
            contentTextStyle: Theme.of(context).textTheme.headline6,
          ),
        );
      }
    }
  }



  showLoading() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Center(
            child: CircularProgressIndicator(
              backgroundColor: Theme.of(context).backgroundColor,
              valueColor:
                  AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
            ),
          ),
        );
      },
    );
  }
}
