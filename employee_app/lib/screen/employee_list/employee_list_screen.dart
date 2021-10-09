

import 'package:employee_app/models/employee_dao.dart';
import 'package:employee_app/screen/employee_details/employee_details_screen.dart';
import 'package:employee_app/utils/response_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

import 'employee_list_provider.dart';

class EmployeeListScreen extends StatefulWidget {
  EmployeeListScreen({Key? key}) : super(key: key);

  @override
  _EmployeeListScreenState createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {


  @override
  void initState() {
    super.initState();
    context.read<EmployeeProvider>().getEmployeeList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Employee List"),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 100,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                onSubmitted: (value) {
                  context.read<EmployeeProvider>().getEmployeeSearch(searchText: value);
                },
                textAlign: TextAlign.start,
                keyboardType: TextInputType.text,
                cursorColor: Colors.black87,
                decoration: InputDecoration(
                  isDense: true,
                  suffixIcon: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  contentPadding: EdgeInsets.all(8),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: Colors.black, width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  hintText: "search by username or email",
                ),
              ),
            ),
          ),
          Expanded(
            child:employeeListView(),
          ),
        ],
      ),
    );
  }

  Widget employeeListView() =>appBehaviourUI(
    context: context,
    response: (context) => context.watch<EmployeeProvider>().getEmployeeResponse,
    successBuilder: (context) => (context.watch<EmployeeProvider>().getEmployee != null)
        ? ListView.builder(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, i) =>
        employeeTile(context.watch<EmployeeProvider>().getEmployee[i]),
        itemCount: context.watch<EmployeeProvider>().getEmployee.length)
        : const SizedBox(),
  );

  Widget employeeTile(Employee employee){
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
      child: InkWell(
        onTap: () {
          Navigator.push(context,MaterialPageRoute(builder: (context) => DetailScreenPage(employee: employee)));
        },
        child: Card(
          child: (SizedBox(
            height: 100,
            child: Row(
              children: <Widget>[
                const SizedBox(
                  width: 20,
                ),
                (null != employee && null != employee.profileImage)
                    ? Container(
                  width: 55.0,
                  height: 55.0,
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(55),
                    color: Colors.transparent,
                    image: DecorationImage(
                      image: NetworkImage(employee.profileImage??""),
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
                    color: Colors.blue,
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Center(child: Text(employee.name?.substring(0, 1) ?? "A")),
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(employee.name ?? "name"),
                    Text(employee.username ?? "user name"),
                  ],
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }

}
