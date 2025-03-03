import 'package:barcode_scanner/core/routes.dart';
import 'package:barcode_scanner/domain/view_model/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Scanner'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              authViewModel.logout();
              Navigator.pushReplacementNamed(context, AppRoutes.auth);
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.camera_alt),
              label: const Text('Start Scanning'),
              onPressed: () => Navigator.pushNamed(context, AppRoutes.scan),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
            ),
            const SizedBox(height: 20),
            _buildUserDetails(authViewModel),
          ],
        ),
      ),
    );
  }

  Widget _buildUserDetails(AuthViewModel authViewModel) {
    if (authViewModel.user == null) return const SizedBox.shrink();
    
    return Column(
      children: [
        const SizedBox(height: 20),
        ListTile(
          leading: const Icon(Icons.email),
          title: Text(authViewModel.user?.email ?? 'No Email'),
          subtitle: Text('UID: ${authViewModel.user?.uid ?? 'Unknown'}'),
        ),
      ],
    );
  }
}
