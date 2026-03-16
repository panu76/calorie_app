import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../core/router/app_router.dart';

@RoutePage()
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  void _navigateToOnboarding(BuildContext context) {
    context.router.replace(const OnboardingRoute());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          ListTile(
            title: Text('Edit User Information'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => _navigateToOnboarding(context),
          ),
          ListTile(
            title: Text('Scan Receipt (ML Kit)'),
            trailing: Icon(Icons.qr_code_scanner),
            onTap: () => context.router.push(const ReceiptScannerRoute()),
          ),
        ],
      ),
    );
  }
}
