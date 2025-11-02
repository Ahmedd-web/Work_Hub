import 'package:flutter/material.dart';
import 'package:work_hub/generated/l10n.dart';
import 'package:work_hub/shared/custom_heaedr.dart';
import 'package:work_hub/shared/register_%20job%20_seeker.dart';
import 'package:work_hub/shared/register_employer.dart';

class RegisterPage extends StatelessWidget {
  final int initialTabIndex;

  const RegisterPage({super.key, this.initialTabIndex = 0});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return DefaultTabController(
      length: 2,
      initialIndex: initialTabIndex,
      child: Scaffold(
        body: Column(
          children: [
            CustomHeader(
              title: s.appTitle,
              showBackButton: true,
              searchHint: s.searchHint,
            ),
            const SizedBox(height: 25),

            Card(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: TabBar(
                tabs: [
                  Tab(
                    child: Text(
                      s.registerTabEmployer,
                      style: textTheme.titleMedium,
                    ),
                  ),
                  Tab(
                    child: Text(
                      s.registerTabJobSeeker,
                      style: textTheme.titleMedium,
                    ),
                  ),
                ],
              ),
            )),

            Expanded(
              child: TabBarView(children: [EmployerForm(), JobSeekerForm()]),
            ),
          ],
        ),
      ),
    );
  }
}
