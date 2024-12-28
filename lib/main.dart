import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:jurnalapp/pages/welcome.dart';
import 'package:jurnalapp/provider/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:jurnalapp/pages/admin/admin_home_page.dart';
import 'package:jurnalapp/pages/admin/jurnal_page.dart';
import 'package:jurnalapp/pages/login.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true, // Aktifkan Device Preview
      builder: (context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (_) => LoginProvider()), // Tambahkan LoginProvider
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: const WelcomePage(),
    );
  }
}