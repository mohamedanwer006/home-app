import 'package:flutter/material.dart';
import 'package:home_app/components/icon_button.dart';
import 'package:home_app/components/setting_card.dart';
import 'package:home_app/screens/about_page.dart';
import 'package:home_app/screens/add_device.dart';
import 'package:home_app/screens/login_screen.dart';
import 'package:home_app/screens/my_devices_page.dart';
import 'package:home_app/screens/rooms_page.dart';
import 'package:home_app/screens/profile_edit_page.dart';
import 'package:home_app/services/api/auth.dart';
import 'package:home_app/services/provider/user_provider.dart';
import 'package:home_app/theme/color.dart';
import 'package:home_app/theme/theme_changer.dart';
import 'package:home_app/utils/assets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  static const String route = '/settings';
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  SharedPreferences sharedPreferences;
  double _imageScale = 1.5;
AuthServices authServices = AuthServices();
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context, listen: true).user;
    ThemeChanger _themeChange = Provider.of<ThemeChanger>(context);
    return Scaffold(
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
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '${user!=null?user.name:'null'}',
                            style: Theme.of(context).textTheme.headline6.copyWith(color: Colors.white),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            SettingCard(
              icon: Image.asset(
                Assets.moonIcon,
                scale: _imageScale,
              ),
              title: Provider.of<ThemeChanger>(context).darkTheme
                  ? 'Light mode'
                  : 'Dark mode',
              color: Colors.white,
              trailing: Container(
                margin: EdgeInsets.only(bottom: 22),
                child: Switch(
                  value: _themeChange.darkTheme??false,
                  onChanged: (value) {
                    _themeChange.toggleTheme();
                  },
                  activeColor: Colors.white,
                  activeTrackColor: Theme.of(context).accentColor,
                  // inactiveTrackColor: AppColors.backgroundColor_dark,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
            ),
            SettingCard(
              icon: Image.asset(
                Assets.deviceIcon,
                scale: _imageScale,
              ),
              title: 'My devices',
              onTap: () {
                Navigator.pushNamed(context, MyDevicesPage.route);
              },
              color: Colors.white,
              trailing: Container(
                child: Icon(Icons.keyboard_arrow_right,
                    color: Theme.of(context).primaryColor),
              ),
            ),
            SettingCard(
              icon: Image.asset(
                Assets.homeIcon,
                scale: _imageScale,
              ),
              title: 'My rooms',
              color: Colors.white,
              onTap: () {
                Navigator.pushNamed(context, RoomsPage.route);
              },
              trailing: Container(
                child: Icon(Icons.keyboard_arrow_right,
                    color: Theme.of(context).primaryColor),
              ),
            ),
            SettingCard(
              onTap: () {
                Navigator.pushNamed(context, AddDevicePage.route);
              },
              icon: Image.asset(
                Assets.deviceIcon,
                scale: _imageScale,
                color: Colors.white,
              ),
              title: 'Add new device',
              color: AppColors.iconsColorBackground3_dark,
              trailing: Container(
                child: Icon(Icons.keyboard_arrow_right,
                    color: Theme.of(context).primaryColor),
              ),
            ),
            SettingCard(
              onTap: () {
                Navigator.pushNamed(context, AboutPage.route);
              },
              icon: Image.asset(
                Assets.aboutIcon,
                scale: _imageScale,
                color: Colors.white,
              ),
              title: 'About',
              color: Theme.of(context).accentColor,
              trailing: Container(
                child: Icon(
                  Icons.keyboard_arrow_right,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            SettingCard(
              onTap: () { 
            // showAboutDialog(
            //   context: context,
            //   applicationIcon: FlutterLogo(),
            //   applicationName: 'Home App',
            //   applicationVersion: '1.0',
            //   applicationLegalese: '© 2020 made with ❤ by :',
            //   children: [
            //     Text('Mohamed anwar',style: Theme.of(context).textTheme.bodyText1,),
            //     Text('Mohamedanwer006@gmail.com',style: Theme.of(context).textTheme.bodyText1,),
               
            //   ],
            // );
                showLicensePage(context: context,applicationName: 'Home App',applicationIcon: Icon(Icons.home));
              },
              icon: Center(child: Icon(Icons.warning,color: Colors.white,size: 18,)),
              title: 'Licenses',
              color: AppColors.accentColor_light,
              trailing: Container(
                child: Icon(
                  Icons.keyboard_arrow_right,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15),
              child: Container(
                width: MediaQuery.of(context).size.width,
                // height: 60.0,
                decoration: BoxDecoration(
                    // color: AppColors.primaryColor_dark,
                    // borderRadius: BorderRadius.all(Radius.elliptical(45.0, 45.0)),
                    ),
                child: Text(
                  'Account',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ),
            Divider(
              height: 0,
              endIndent: 15,
              indent: 15,
              thickness: 1,
            ),
            SettingCard(
              onTap: () async {
                authServices.logOut().then((value) {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (BuildContext context) => LoginPage()),
                      (Route<dynamic> route) => false);
                }).catchError((onError) {
                  print(onError);
                });
              },
              icon: Image.asset(
                Assets.logoutIcon,
                scale: _imageScale,
                color: Colors.white,
              ),
              title: 'Logout',
              color: Colors.red,
              trailing: Container(
                child: Icon(Icons.keyboard_arrow_right,
                    color: Theme.of(context).primaryColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 50.0,
                decoration: BoxDecoration(
                    // color: AppColors.primaryColor_dark,
                    // borderRadius: BorderRadius.all(Radius.elliptical(45.0, 45.0)),
                    ),
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
      leading:  Padding(
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
            padding: const EdgeInsets.only(top:12.0,bottom: 12),
            child: Consumer<ThemeChanger>(
            builder: (context, value, child) => 
             RectIconButton(
              height: 28,
              width: 28,
              onPressed: () {
                Navigator.of(context).pushNamed(ProfileEditPage.route);
              },
              color: value.darkTheme
                      ? AppColors.iconsColorBackground2_dark
                      : AppColors.iconsColorBackground3_light,
              child: Icon(
                Icons.edit,
                color:value.darkTheme? AppColors.iconsColor_dark:AppColors.iconsColor_light,
              ),
            ),
        ),
          ),
        ],
    );
  }

 
}
