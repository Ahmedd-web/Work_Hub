import 'package:flutter/material.dart';
import 'package:work_hub/shared/custom_heaedr.dart';
import 'package:work_hub/shared/register_%20job%20_seeker.dart';
import 'package:work_hub/shared/register_employer.dart';

class RegisterPage extends StatelessWidget {
  final int initialTabIndex;

  const RegisterPage({super.key, this.initialTabIndex = 0});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: initialTabIndex,
      child: Scaffold(
        body: Column(
          children: [
            CustomHeader(title: "WorkHub"),
            SizedBox(height: 25),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(2, 4),
                  ),
                ],
              ),
              child: TabBar(
                indicator: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(20),
                ),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.purple,
                tabs: const [
                  Tab(
                    child: Text(
                      "Register Employer",
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Register job seeker",
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: TabBarView(children: [EmployerForm(), JobSeekerForm()]),
            ),
          ],
        ),
      ),
    );
  }
}
