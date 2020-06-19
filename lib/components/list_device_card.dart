import 'package:flutter/material.dart';

class ListDeviceCard extends StatelessWidget {

  final String title;
  final Widget trailing;
  final VoidCallback onTap;
  final bool selected;
  final Color color;
  final Widget icon;

  const ListDeviceCard({
    Key key,

    this.title,
    this.trailing,
    this.onTap,
    this.selected,
    this.color,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
      child: Container(
          height: 70,
          // width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                  color: Theme.of(context).dividerColor,
                  width: 1,
                  style: BorderStyle.solid),
            ),
          ),
          child: ListTile(
            onTap: onTap,
            leading: Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Container(
                // height: 65,
                width: 30,
                child: Center(
                    //#464646
                    child: icon),
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  // border: Border(bottom: BorderSide(color: Colors.white,width: 3,style: BorderStyle.solid))
                ),
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.subtitle1,
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            trailing: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: trailing,
            ),
          )),
    );
  }
}
