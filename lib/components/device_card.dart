import 'package:flutter/material.dart';
import 'package:home_app/components/icon_button.dart';
import 'package:home_app/utils/assets.dart';

class DeviceCard extends StatelessWidget {
  const DeviceCard({
    Key key,
    this.color,
    this.onTap,
    this.name,
    this.status, this.onLongPress,
  }) : super(key: key);
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final Color color;
  final String name;
  final String status;
  
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ),
      onPressed:onTap,
      onLongPress: onLongPress,
      child: GridTile(
          header: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircularIconButton(
                  height: 28,
                  width: 28,
                  color: Theme.of(context).backgroundColor,
                  child: Center(
                    child: Image.asset(
                      Assets.deviceIcon,
                      scale: 1.5,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                  onPressed: null),
              CircularIconButton(
                  height: 28,
                  width: 28,
                  color: Theme.of(context).backgroundColor,
                  child: Center(
                      child: Icon(
                    Icons.power_settings_new,
                    color: color,
                  )),
                  onPressed: null)
            ],
          ),
          footer: Padding(
            padding: const EdgeInsets.only(bottom: 20.0, left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$name',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2
                      .copyWith(color: Theme.of(context).accentColor),
                ),
                Text(
                  '$status',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      .copyWith(fontSize: 10),
                ),
              ],
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(18.0),
            ),
          )),
    );
  }
}
