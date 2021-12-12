import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';



class CalendarioScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SfCalendar(
        view: CalendarView.week,
        firstDayOfWeek: 1,
        dataSource: MeetingDataSource(getAppointments()),
      ),
    );
  }
}

List<Appointment> getAppointments(){
  List<Appointment> meeting = <Appointment>[];
  final DateTime today = DateTime.now();
  final DateTime startTime = DateTime(today.year, today.month, today.day, 9,0,0);
  final DateTime endTime = startTime.add(const Duration(hours: 2));

  meeting.add(Appointment(
    startTime: startTime,
    endTime: endTime,
    subject: 'Reunion de proyecto',
    color: Color(0xFF9146FF)
   ));
   return meeting;
}

class MeetingDataSource extends CalendarDataSource{
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}