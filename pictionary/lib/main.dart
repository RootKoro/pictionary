import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pictionary/models/user.model.dart';
import 'package:pictionary/routes/app.routes.dart';
import 'package:pictionary/routes/name.route.dart';
// import 'package:pictionary/screens/wrapper.dart';
import 'package:pictionary/services/auth.dart';
import 'package:pictionary/theme/app_theme.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserModel?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: ThemeMode.light,
        initialRoute: AppRouteName.home,
        onGenerateRoute: AppRoute.generate,
        navigatorObservers: [routeObserver],
        // home: Wrapper(),
      ),
    );
  }
}
