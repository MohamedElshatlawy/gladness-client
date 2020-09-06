import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qutub_clinet/models/vendorModel.dart';
import 'package:qutub_clinet/ui/colors.dart';
import 'package:qutub_clinet/ui/widgets/customButton.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderDialog extends StatefulWidget {
  String selectedDateTime;
  VendorModel vendorModel;
  CalenderDialog(this.selectedDateTime, this.vendorModel);

  @override
  _CalenderDialogState createState() => _CalenderDialogState();
}

class _CalenderDialogState extends State<CalenderDialog> {
  CalendarController calendarController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    calendarController = CalendarController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    calendarController.dispose();
  }

  DateTime selectedDay;
  @override
  Widget build(BuildContext context) {
    print(widget.selectedDateTime);
    List nonRegularsDays = widget.vendorModel.nonRegulars.keys.toList();
    List regularholidays = widget.vendorModel.regularHolidays;
    print(widget.vendorModel.nonRegulars);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TableCalendar(
          calendarController: calendarController,
          builders: CalendarBuilders(dayBuilder: (ctx, d, list) {
            String dayDate = d.toString().split(" ")[0];
            String dayName = getDayName(d);

            return Container(
              margin: EdgeInsets.all(3),
              child: CircleAvatar(
                backgroundColor: (nonRegularsDays.contains(dayDate) ||
                        regularholidays.contains(mappingDayNames[dayName]))
                    ? Colors.grey[300]
                    : (selectedDay == d) ? Colors.blue : Colors.white,
                child: Text(
                  dayDate.split("-")[2],
                  style: TextStyle(
                      color: (nonRegularsDays.contains(dayDate) ||
                              regularholidays
                                  .contains(mappingDayNames[dayName]))
                          ? Colors.grey[500]
                          : (selectedDay == d)
                              ? Colors.white
                              : MyColor.customColor),
                ),
              ),
            );
          }),
          onDaySelected: (d, v) {
            String dayDate = d.toString().split(" ")[0];
            String dayName = getDayName(d);
            if (!(nonRegularsDays.contains(dayDate) ||
                regularholidays.contains(mappingDayNames[dayName]))) {
              widget.selectedDateTime = d.toString().split(" ")[0];
            } else {
              print("No");
              widget.selectedDateTime=null;
            }

            selectedDay = d;
            setState(() {});
            print("DateInDialog:${widget.selectedDateTime}");
          },
        ),
        SizedBox(
          height: 8,
        ),
        CustomButton(
          backgroundColor: MyColor.customColor,
          textColor: Colors.white,
          btnPressed: () {
            Navigator.pop(context, [widget.selectedDateTime]);
          },
          txt: 'تأكيد',
        )
      ],
    );
  }

  String getDayName(DateTime d) {
    String day = DateFormat('EEEE').format(d);
    return day;
  }

  static var mappingDayNames = {
    'Friday': 'الجمعة',
    'Saturday': 'السبت',
    'Sunday': 'الأحد',
    'Monday': 'الأثنين',
    'Tuesday': 'الثلاثاء',
    'Wednesday': 'الأربعاء',
    'Thursday': 'الخميس',
  };
}
