import 'package:employee_app/helpers/api_helper.dart';
import 'package:employee_app/models/employee_dao.dart';
import 'package:employee_app/utils/app_response.dart';
import 'package:flutter/cupertino.dart';


class EmployeeProvider extends ChangeNotifier {

  Response<EmployeeList> _employeeResponse = Response.loading("loading");


  ///Function for get employees
  Future<void> getEmployeeList() async {
    _employeeResponse = Response.loading("loading");
    List<Employee>? _employeeList = await EmployeeList.fillFromTable();
    if (null != _employeeList && _employeeList.isEmpty) {
      await API().getListFromServer().then((value){
        _employeeResponse = Response.completed(value);
      }
     ).catchError((e){
        _employeeResponse=Response.error(e.toString());
      });
    }else{
      _employeeResponse = Response.completed(EmployeeList(employeeList:_employeeList));
    }
    notifyListeners();
  }


  ///Function for get employees
  Future<void> getEmployeeSearch({String? searchText}) async {
    if(searchText!=null && searchText.isNotEmpty){
      List<Employee> _employeeList = _employeeResponse.data?.employeeList??[];
      if(_employeeList==null||_employeeList.isEmpty){
        _employeeResponse=Response.error("Empty List");
        print("Empty");
      }else{
        List<Employee> _tempEmployeeList = [];
        for (Employee emp in _employeeList) {
          if (emp.name != null && emp.email != null) {
            String name=emp.name??"";
            String email=emp.email??"";
            if (name.contains(searchText) || email.startsWith(searchText)) {

              _tempEmployeeList.add(emp);
            }
          }
        }
        _employeeResponse = Response.completed(EmployeeList(employeeList:_tempEmployeeList));
      }
      notifyListeners();
    }
    else{
      getEmployeeList();
    }
  }

  Response<EmployeeList> get getEmployeeResponse => _employeeResponse;
  List<Employee> get getEmployee => _employeeResponse.data?.employeeList??[];


}
