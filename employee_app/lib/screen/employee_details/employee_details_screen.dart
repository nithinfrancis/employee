import 'package:employee_app/models/employee_dao.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DetailScreenPage extends StatefulWidget {
  final Employee employee;

  DetailScreenPage({Key? key, required this.employee}) : super(key: key);

  @override
  _DetailScreenPageState createState() => _DetailScreenPageState();
}

class _DetailScreenPageState extends State<DetailScreenPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.employee.username ?? ""),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            (null != widget.employee && null != widget.employee.profileImage)
                ? Container(
              width: 55.0,
              height: 55.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(55),
                color: Colors.transparent,
                image: DecorationImage(
                  image: NetworkImage(widget.employee.profileImage??""),
                  fit: BoxFit.fill,
                ),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
            )
                : Container(
              width: 55.0,
              height: 55.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(55),
                color: Colors.transparent,
              ),
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Center(child: Text(widget.employee.name?.substring(0, 1) ?? "A")),
            ),
            Text(widget.employee.username ?? ""),
            Text(widget.employee.email ?? ""),
            Text(widget.employee.address?.zipcode ?? ""),
            Text(widget.employee.address?.city ?? ""),
            Text(widget.employee.address?.suite ?? ""),
            Text(widget.employee.phone ?? ""),
            Text(widget.employee.website ?? ""),
            Text(widget.employee.company?.name ?? ""),
            Text(widget.employee.company?.catchPhrase ?? ""),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
