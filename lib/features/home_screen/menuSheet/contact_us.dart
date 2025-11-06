import 'package:flutter/material.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Us'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'تواصل معنا',
              textAlign: TextAlign.center,
              style: textTheme.headlineSmall?.copyWith(
                color: colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'يسعدنا سماع رأيك وملاحظاتك. املأ الحقول التالية وسنعاود الاتصال بك قريباً.',
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium,
            ),
            const SizedBox(height: 32),
            const _ContactField(
              label: 'Name',
              hintText: 'Enter your name',
              icon: Icons.person,
            ),
            const SizedBox(height: 20),
            const _ContactField(
              label: 'Email Address',
              hintText: 'example@email.com',
              icon: Icons.email,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),
            const _ContactField(
              label: 'Message',
              hintText: 'Enter your message here...',
              icon: Icons.message,
              maxLines: 6,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Send'),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContactField extends StatelessWidget {
  const _ContactField({
    required this.label,
    required this.hintText,
    required this.icon,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
  });

  final String label;
  final String hintText;
  final IconData icon;
  final TextInputType keyboardType;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        prefixIcon: Icon(icon),
        alignLabelWithHint: maxLines > 1,
      ),
    );
  }
}
