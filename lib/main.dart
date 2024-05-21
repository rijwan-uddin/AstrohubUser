import 'package:astrohub_user/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  ThemeData _buildShrineTheme(){
    final ThemeData base = ThemeData.light(useMaterial3: true);
    return base.copyWith(
      colorScheme: base.colorScheme.copyWith(
        primary: kShrinePink400,
        onPrimary: kShrineBrown900,
        secondary: kShrineBrown900,
        error: kShrineErrorRed,
      ),
      textTheme: _buildShrineTextTheme(GoogleFonts.ralewayTextTheme()),
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: kShrinePink100,
    )
    );
  }



  TextTheme _buildShrineTextTheme(TextTheme base){
    return base.copyWith(
      headlineSmall: base.headlineSmall!.copyWith(
        fontWeight: FontWeight.w500,
      ),
      titleLarge: base.titleLarge!.copyWith(
        fontSize:18.0,
      ),
      bodySmall: base.bodySmall!.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 14.0,
      ),
      bodyLarge: base.bodySmall!.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 16.0,
      ),
    ).apply(
      displayColor: kShrineBrown900,
      bodyColor: kShrineBrown900,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _buildShrineTheme(),
      home: Placeholder(),
    );
  }
}
