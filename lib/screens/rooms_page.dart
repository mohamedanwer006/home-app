import 'package:flutter/material.dart';
import 'package:home_app/components/list_room_card.dart';
import 'package:home_app/models/collections.dart';
import 'package:home_app/services/api/collection.dart';
import 'package:home_app/services/provider/collection_provider.dart';
import 'package:home_app/theme/theme_changer.dart';
import 'package:home_app/utils/assets.dart';
import 'package:provider/provider.dart';

class RoomsPage extends StatefulWidget {
  static const route = '/rooms';
  @override
  _RoomsPageState createState() => _RoomsPageState();
}

class _RoomsPageState extends State<RoomsPage> {
  CollectionServices _collectionServices = CollectionServices();
  int selected = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: buildAppBar(context),
      body: Consumer<ThemeChanger>(
        builder: (context, theme, child) => Column(
          children: <Widget>[
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: FutureBuilder(
                  future: Provider.of<CollectionProvider>(context).collections,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Collection> collections = snapshot.data;
                      return ListView.builder(
                        shrinkWrap: false,
                        scrollDirection: Axis.vertical,
                        itemCount: collections.length,
                        itemBuilder: (context, index) {
                          return Dismissible(
                            key: Key(collections[index].id),
                            onDismissed: (direction) async {
                              try {
                                showLoading();
                                var res = await _collectionServices
                                    .deleteCollection(collections[index].id);
                                collections.removeAt(index);
                                if (res) {
                                  Future<List<Collection>> colls() async {
                                    var colls = collections;
                                    return colls;
                                  }

                                  Provider.of<CollectionProvider>(context)
                                      .setCollections(colls());
                                  Navigator.pop(context);
                                }
                              } catch (e) {
                                print(e);
                              }
                            },
                            direction: DismissDirection.endToStart,
                            background: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Container(
                                alignment: Alignment.centerRight,
                                padding: EdgeInsets.only(right: 40),
                                // margin: EdgeInsets.only(left: 10),
                                child: Icon(
                                  Icons.remove_circle_outline,
                                  color: Colors.white,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  
                                ),
                              ),
                            ),
                            child: ListRoomCard(
                              trailing: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              icon: Container(
                                height: 32,
                                width: 32,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).cardColor,
                                  borderRadius: BorderRadius.circular(22),
                                ),
                                child: Center(
                                  child: Image.asset(
                                    Assets.homeIcon,
                                    scale: 1.5,
                                    color: Theme.of(context).iconTheme.color,
                                  ),
                                ),
                              ),
                              title: collections[index].name ?? 'Error can\'t get name',
                              onTap: (){
                                showDialog(context: context,builder: (context) => SimpleDialog(
                                  children: [
                                    Center(child: Text('slide left to remove room '))
                                  ],
                                ),);
                              },
                            ),
                          );
                        },
                      );
                    } else
                      return Container();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  addSelectetdRooms() {}
  showWarningDialog(String name) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Center(child: Text('Warning⚠⚠')),
        content: Text('Are you sure,want to remove $name room'),
        actions: [
          RaisedButton(
            child: Text('yes'),
            onPressed: () async {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  showLoading() {
    showDialog(
      context: context,
      barrierDismissible: false,
      // useSafeArea: true,
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
  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: Text(
          'Rooms',
          style: Theme.of(context).textTheme.headline6.copyWith(color:Colors.white),
        ),
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
        
    );
  }
}
