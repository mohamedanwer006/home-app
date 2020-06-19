import 'package:flutter/material.dart';
import 'package:home_app/screens/home_page.dart';
import 'package:home_app/screens/login_screen.dart';
import 'package:home_app/services/api/collection.dart';
import 'package:home_app/services/provider/collection_provider.dart';
import 'package:home_app/services/provider/devices_provider.dart';
import 'package:home_app/services/provider/user_provider.dart';
import 'package:home_app/theme/theme.dart';
import 'package:home_app/theme/theme_changer.dart';
import 'package:home_app/utils/routes.dart';
import 'package:provider/provider.dart';
import 'package:home_app/services/mqtt/mqtt_services.dart';
import 'package:home_app/screens/splash.dart';

void main() {
  MqttServices _mqttServices = MqttServices();
   _mqttServices.initClient();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
      // This widget is the root of application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(builder: (_) => UserProvider()),
        ChangeNotifierProvider<CollectionProvider>(builder: (_) => CollectionProvider()),
        ChangeNotifierProvider<DeviceProvider>(builder: (_) => DeviceProvider()),  
        ChangeNotifierProvider<ThemeChanger>(builder: (_) => ThemeChanger()),  
      ],
      child: Consumer<ThemeChanger>(builder: (context, theme, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Home app',
          theme: theme.darkTheme ? darkTheme : lightTheme,
          routes: routes,
          // home: HomeApp(),
        );
      }),
    );
  }
}


class HomeApp extends StatefulWidget {
   static const String route = '/';
  // landing pag fetch data and intilixw
  @override
  _HomeAppState createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  CollectionServices _collectionServices=CollectionServices();


  initData(data)async{
    await Provider.of<UserProvider>(context,listen:false).setUser(data);
    await Provider.of<CollectionProvider>(context,listen: false).setCollections(_collectionServices.getCollections());
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<UserProvider>(context).currentUser(),
      builder:(context, snapshot) {
        if(snapshot.connectionState==ConnectionState.done){
          if(snapshot.hasData){
            //todo:fix bug when rerun "This ListenableProvider<UserProvider> widget cannot be marked as needing"
            initData(snapshot.data);
          return HomePage();
          }else{
            return LoginPage();
          }
        }else{
          return SplashPage();
        }
      }, 
    );
  }
}



