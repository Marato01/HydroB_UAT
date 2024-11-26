import 'package:HydroB_UAT/view_model/Bluetooth_provider/BLEProvider.dart';
import 'package:HydroB_UAT/view_model/Bluetooth_provider/Switch_provider.dart';
import 'package:HydroB_UAT/view_model/EC_data_provider.dart';
import 'package:HydroB_UAT/view_model/add_area_provider.dart';
import 'package:HydroB_UAT/view_model/add_vegetable_provider.dart';
import 'package:HydroB_UAT/view_model/language_provider.dart';
import 'package:HydroB_UAT/view_model/pH_data_provider.dart';
import 'package:HydroB_UAT/view_model/profile_picker_provider.dart';
import 'package:HydroB_UAT/view_model/set_value_ph_ec.dart';
import 'package:HydroB_UAT/view_model/switch_provider_EC.dart';
import 'package:HydroB_UAT/view_model/switch_provider_pH.dart';
import 'package:HydroB_UAT/views/deskboard_screen/button_navigation_bar/button_navigation_bar.dart';
import 'package:HydroB_UAT/views/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {

  await Hive.initFlutter(); // Initialize Hive

  WidgetsFlutterBinding.ensureInitialized();

  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, // Lock to portrait up orientation
  ]);


  SharedPreferences prefs = await SharedPreferences.getInstance();
  String initialRoute = prefs.getString('homepage') ?? '/home';

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => VetegetableProvider()..loadItems()),
        ChangeNotifierProvider(create: (context) => AddAreaProvider()..loadAreas()),
        ChangeNotifierProvider(create: (context) => SetValueProvider()),
        ChangeNotifierProvider(create: (context) => PHDataProvider()),
        ChangeNotifierProvider(create: (context) => ECDataProvider()),
        ChangeNotifierProvider(create: (_) => ProfileImageProvider()),
        ChangeNotifierProvider(create: (_) => SwitchProviderPH()),
        ChangeNotifierProvider(create: (_) => SwitchProviderEc()),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        ChangeNotifierProvider(create: (_) => BLEProvider()),
        ChangeNotifierProvider(create: (_) => BluetoothSwitchProvider()),
      ],
      child: MyApp(initialRoute: initialRoute),
    ),
  );
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  const MyApp({super.key, required this.initialRoute});

  // This widget is the root of your application.
  @override

  Widget build(BuildContext context) {
    final profileImageProvider = Provider.of<ProfileImageProvider>(context, listen: false);
    profileImageProvider.loadImage();
    final languageProvider = Provider.of<LanguageProvider>(context);
    return MaterialApp(

      initialRoute: initialRoute,
      routes: {
        '/home': (context) => ButtonNavigationBar(),
        // '/default': (context) => ProfileScreen(),
      },

      title: 'Flutter Demo',
      locale: languageProvider.locale, // Use the locale from provider
      localizationsDelegates: const [
        AppLocalizations.delegate, // Add this line
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('km'), // Spanish
      ],
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFFFF5F5F7),
        useMaterial3: true,
      ),
      home: SplashScreen(),
      debugShowCheckedModeBanner: true,
    );
  }
}
