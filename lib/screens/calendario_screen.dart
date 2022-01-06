import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:reilak_app/models/calendar_response.dart';
import 'package:reilak_app/services/calendar_service.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:intl/intl.dart';

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
      onTap: (t){
        if(t.appointments != null){
 print(t.appointments![0]);
       showAlert(context, t.appointments![0].subject, t.appointments![0].startTime, t.appointments![0].endTime,  t.appointments![0].notes );
        }
       
      },
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
        notes: events[i].descripcion,
        color: Color(0xFF9146FF)));
  }

  return meeting;
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}


showAlert(BuildContext context, String titulo, fechaInicio, fechaTermino, descripcion) {
  if (Platform.isAndroid) {
    return showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text(titulo),
              content: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Fecha de inicio: ${DateFormat('kk:mm dd-MM').format(
                              fechaInicio
                                  .toUtc()
                                  .toLocal())}'),
                      Text('Fecha de Termino: ${DateFormat('kk:mm dd-MM').format(
                              fechaTermino
                                  .toUtc()
                                  .toLocal())}'),
                      SizedBox(height: 10.0,),
                      Text(descripcion),
                    ],
                  ),
                ],
              ),
              actions: [
                MaterialButton(
                    child: Text('Ok'),
                    elevation: 5,
                    textColor: Colors.blue,
                    onPressed: () {
                      Navigator.pop(context);
                    })
              ],
            ));
  }
  showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
            title: Text(titulo),
            content: Column(
              children: [
                Text('subtitulo'),
                Text('subtitulo'),
                Text('subtitulo'),
              ],
            ),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Text('Ok'),
                      onPressed: (){
        Navigator.pop(context);
      }
              )
            ],
          ));
}