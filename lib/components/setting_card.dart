import 'package:flutter/material.dart';

class SettingCard extends StatefulWidget {
  final Widget icon;
  final String title;
  final Widget trailing;
  final VoidCallback onTap;
  final Color color;
  const SettingCard({
    Key key,
    this.icon,
    this.title,
    this.trailing,
    this.onTap, this.color,
  }) : super(key: key);

  @override
  _SettingCardState createState() => _SettingCardState();
}

class _SettingCardState extends State<SettingCard> {
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
            onTap: widget.onTap,
            leading: Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Container(
                // height: 65,
                width: 30,
                child: Center(
                    //#464646
                    child: widget.icon),
                decoration: BoxDecoration(
                  color: widget.color,
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
                  widget.title,
                  style: Theme.of(context).textTheme.subtitle1,
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            trailing: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: widget.trailing,
            ),
          )),
    );
  }
}
