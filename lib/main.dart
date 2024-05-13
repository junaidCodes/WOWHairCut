import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wowcut/Routes/route_name.dart';
import 'package:wowcut/Routes/routes.dart';
import 'package:wowcut/Views/Chat/chat_controller.dart';
import 'package:wowcut/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ChatController()),
      ],
      child: MaterialApp(
        // ignore: deprecated_member_use
        useInheritedMediaQuery: true,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6B4897)),
          useMaterial3: true,
        ),
        initialRoute: RouteName.splashView,

        onGenerateRoute: Routes.genrateRoutes,
        // home: SplashView(),
        // home: ChangeNotifierProvider(
        //   create: (_) => ChatController(),
        //   // child: const BottomBarr(),
        // ),
      ),
    );
  }
}
