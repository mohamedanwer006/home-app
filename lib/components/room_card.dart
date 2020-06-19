import 'package:flutter/material.dart';
import 'package:home_app/models/collections.dart';
import 'package:home_app/theme/color.dart';
import 'package:home_app/utils/utilities.dart';


class RoomCard extends StatelessWidget {
  final Collection room;
  final VoidCallback onPreessed;
  const RoomCard({
    Key key,
    @required this.room,
    this.onPreessed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8, right: 8),
      child: GestureDetector(
          onTap: onPreessed,
          child: Container(
            width: isSmall(context)
        ? MediaQuery.of(context).size.width * 0.32
        : 200.0,
            height: 227.0,
            decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12.0),
      image:DecorationImage(            
        image:room.picture!=null? NetworkImage(room.picture):const AssetImage('assets/images/room.jpg'),
        fit: BoxFit.cover,
      ),
            ),
            child: Wrap(
      crossAxisAlignment: WrapCrossAlignment.end,
      direction: Axis.vertical,
      alignment: WrapAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.end,
            children: [
              MaterialButton(
                onPressed: () {},
                padding: EdgeInsets.all(0),
                minWidth: 29,
                height: 29,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.all(Radius.elliptical(14.5, 14.5)),
                ),
                child: Hero(
                  tag: '${room.id}',
                                  child: Container(
                    width: 29.0,
                    height: 29.0,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.all(Radius.elliptical(14.5, 14.5)),
                      color: AppColors.primaryColor_dark,
                    ),
                    child: Center(
                        child: Icon(
                      Icons.power_settings_new,
                      color: Colors.red,
                    )),
                  ),
                ),
              )
            ],
          ),
        ),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          direction: Axis.vertical,
          // alignment: WrapAlignment.spaceBetween,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              width: 65.0,
              height: 18.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                color: const Color(0xffffffff),
              ),
              child: Wrap(
                spacing: 5,
                alignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.center,
                direction: Axis.horizontal,
                // crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 18.0,
                    height: 18.0,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.all(Radius.elliptical(7.5, 7.5)),
                      color: const Color(0xfffac632),
                    ),
                    child: Center(
                      child: Text(
                        '${room.devices.length}',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            .copyWith(
                                color: AppColors.primaryColor_dark,
                                fontSize: 10),
                      ),
                    ),
                  ),
                  Text(
                    'devices',
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                        color: AppColors.primaryColor_dark, fontSize: 10),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 15, bottom: 20, top: 10),
              child: Container(
                width: isSmall(context)
                    ? MediaQuery.of(context).size.width * 0.26
                    : 150.0,
                height: 23.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14.0),
                  color: const Color(0xffffffff),
                ),
                child: Center(
                    child: Text(
                  '${room.name}',
                  style: Theme.of(context).textTheme.bodyText2.copyWith(
                      color: AppColors.primaryColor_dark, fontSize: 12),
                )),
              ),
            ),
          ],
        ),
      ],
            ),
          ),
        ),
    );
  }
}