import 'package:flutter/material.dart';
import 'package:work_hub/features/auth/screens/login.dart';
import 'package:work_hub/features/auth/screens/register.dart';
import 'package:work_hub/features/home_screen/home_page.dart';
import 'package:work_hub/generated/l10n.dart';
import 'package:work_hub/shared/custom_heaedr.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    return Scaffold(
      body: Column(
        children: [
          CustomHeader(
            title: s.appTitle,
            backgroundColor: colorScheme.primary,
            showBackButton: false,
            showMenuButton: false,
            showNotificationButton: false,
            showSearchBar: false,
          ),
          const SizedBox(height: 100),
          Column(
            children: [
              Text(
                s.welcomeTitle,
                style: textTheme.headlineSmall,
              ),
              const SizedBox(height: 10),
              Text(
                s.welcomeSubtitle,
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                width: 280,
                height: 1,
                color: colorScheme.primary,
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 45),
                child: Column(
                  children: [
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: colorScheme.secondary,
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder:
                                (context) => RegisterPage(initialTabIndex: 1),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.person,
                        color: colorScheme.onSecondary,
                      ),
                      label: Text(
                        s.welcomeJobSeeker,
                        style: TextStyle(
                          fontSize: 16,
                          color: colorScheme.onSecondary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: colorScheme.primary,
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder:
                                (context) => RegisterPage(initialTabIndex: 0),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.business,
                        color: colorScheme.onPrimary,
                      ),
                      label: Text(
                        s.welcomeEmployer,
                        style: TextStyle(
                          fontSize: 16,
                          color: colorScheme.onPrimary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      s.welcomeBrowseAsGuest,
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: colorScheme.tertiary,
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      },
                      child: Text(
                        s.welcomeContinueGuest,
                        style: TextStyle(
                          fontSize: 16,
                          color: colorScheme.onTertiary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const Login(),
                          ),
                        );
                      },
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '${s.welcomeHaveAccount} ',
                              style: TextStyle(
                                color:
                                    colorScheme.onSurface.withValues(
                                  alpha: 0.7,
                                ),
                              ),
                            ),
                            TextSpan(
                              text: s.welcomeLogin,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: colorScheme.primary,
                                decoration: TextDecoration.underline,
                                decorationColor: colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
