import 'package:flutter/material.dart';
import 'package:home_app/theme/theme_changer.dart';
import 'package:home_app/utils/utilities.dart';
import 'package:provider/provider.dart';

class AddRoomCard extends StatelessWidget {
  final VoidCallback onTap;
  AddRoomCard({Key key, @required this.onTap});
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeChanger>(
      builder: (context, theme, child) => Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 8, right: 8),
        child: MaterialButton(
          padding: EdgeInsets.all(0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          minWidth:
              isSmall(context) ? MediaQuery.of(context).size.width * 0.32 : 200.0,
          height: 227.0,
          color: Theme.of(context).cardColor,
          onPressed: onTap,
          child: Padding(
            padding: const EdgeInsets.only(right: 8, top: 8, bottom: 8),
            child: Container(
              width: isSmall(context)
                  ? MediaQuery.of(context).size.width * 0.32
                  : 200.0,
              height: 227.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7.0),
                // color: Theme.of(context).cardColor,
              ),
              child: Center(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  direction: Axis.vertical,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Container(
                      width: 34.0,
                      height: 34.0,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(17.0, 17.0)),
                        color: const Color(0xffffffff),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0x80ffffff),
                            offset: Offset(0, 3),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.add,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Add room',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
