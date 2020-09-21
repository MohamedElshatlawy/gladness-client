import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../colors.dart';

class CalenderOrderDetails extends StatefulWidget {
  String selectedDate;
  CalenderOrderDetails(this.selectedDate);

  @override
  _CalenderOrderDetailsState createState() => _CalenderOrderDetailsState();
}

class _CalenderOrderDetailsState extends State<CalenderOrderDetails> {
  var _calendarController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _calendarController = CalendarController();
//    print(DateTime.parse(widget.selectedDate).toString());
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      calendarController: _calendarController,
      initialCalendarFormat: CalendarFormat.week,
      initialSelectedDay: DateTime.parse(widget.selectedDate),
      builders: CalendarBuilders(dayBuilder: (ctx, d, list) {
        print(d.toString());

        return Container(
          margin: EdgeInsets.all(3),
          child: CircleAvatar(
            backgroundColor: (d.toString().split(" ")[0] ==
                    DateTime.parse(widget.selectedDate)
                        .toString()
                        .split(" ")[0])
                ? MyColor.customColor
                : Colors.white,
            child: Text(
              d.day.toString(),
              style: TextStyle(
                  color: (d.toString().split(" ")[0] ==
                          DateTime.parse(widget.selectedDate)
                              .toString()
                              .split(" ")[0])
                      ? MyColor.whiteColor
                      : MyColor.customColor),
            ),
          ),
        );
      }),
    );
  }
}
