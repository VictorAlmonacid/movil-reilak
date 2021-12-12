import 'package:flutter/material.dart';
import 'package:reilak_app/models/calendar_response.dart';
import 'package:reilak_app/services/calendar_service.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarioScreen extends StatefulWidget {
  @override
  State<CalendarioScreen> createState() => _CalendarioScreenState();
}

class _CalendarioScreenState extends State<CalendarioScreen> {


  final calendarService = new CalendarService();
  List<Evento> events = [];
  @override
  void initState() {
    super.initState();
    this._cargarPosts();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SfCalendar(
      timeZone: 'Pacific SA Standard Time',
      allowedViews: [
        CalendarView.day,
        CalendarView.week,
        CalendarView.month,
        CalendarView.schedule
      ],
      view: CalendarView.week,
      firstDayOfWeek: 1,
      dataSource: MeetingDataSource(getAppointments(events)),
    );
  }

  _cargarPosts() async {
    this.events = await calendarService.getEvents();
    setState(() {});
  }
}

List<Appointment> getAppointments(events) {
  List<Appointment> meeting = <Appointment>[];
  // final DateTime today = DateTime.now();
  // final DateTime startTime = DateTime(today.year, today.month, today.day, 9,0,0);
  // final DateTime endTime = startTime.add(const Duration(hours: 2));

  for (int i = 0; i < events.length; i++) {
    meeting.add(Appointment(
        startTime: events[i].start,
        endTime: events[i].end,
        subject: events[i].titulo,
        color: Color(0xFF9146FF)));
  }

  return meeting;
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}
