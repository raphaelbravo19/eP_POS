import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/views/employee/widgets/add_employee.dart';
import 'package:epaisa_pos/src/views/employee/widgets/employee_list_widget.dart';
import 'package:epaisa_pos/src/views/shared/new_epaisa_app_bar.dart';
import 'package:epaisa_pos/src/views/shared/epaisa_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmployeeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    EpaisaScaffold buildEpaisaScaffold(BuildContext context) {
      return EpaisaScaffold(
          appBar: EpaisaAppBar(
            back: true,
            title: 'EMPLOYEES',
          ),
          body: EmployeeList());
    }

    return buildEpaisaScaffold(context);
  }
}
