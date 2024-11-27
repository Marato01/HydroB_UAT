import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:khmer_fonts/khmer_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:riff_switch/riff_switch.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../view_model/Bluetooth_provider/BLEProvider.dart';
import '../../../../view_model/add_area_provider.dart';
import '../../../../view_model/set_value_ph_ec.dart';
import '../../../../view_model/switch_provider_EC.dart';
import '../../../../view_model/switch_provider_pH.dart';
import 'app_bar.dart';
import 'chart_line/chart_line_screen.dart';
import 'history/history_screen.dart';
import 'vegetable/choose_vegetable_dialog.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  final NotchBottomBarController? controller;

  const HomeScreen({
    super.key,
    this.controller,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached) {
      // Save state when the app is killed or paused
      _saveAppState();
    }
  }

  void _saveAppState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'homepage', 'HomeScreen'); // Save the current screen or state
  }

  @override
  Widget build(BuildContext context) {
    final setValue = Provider.of<SetValueProvider>(context);
    final activatePH = Provider.of<SwitchProviderPH>(context);
    final activateEC = Provider.of<SwitchProviderEc>(context);
    final btnSwitch = Provider.of<BLEProvider>(context);

    //spacing between container pH and container EC
    final sizebox = SizedBox(
      height: MediaQuery.of(context).size.height * 0.03,
    );

    //spacing between title and icons
    final iconspacing = SizedBox(
      width: MediaQuery.of(context).size.width * 0.15,
    );

    //spacing between text min and max
    final textspacing = SizedBox(
      height: MediaQuery.of(context).size.height * 0.01,
    );

    return Scaffold(
      body: SingleChildScrollView(
        // Wrapping content in SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.10,
                color: Colors.green,
                child: const Appbar(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ChartLineScreen()));
                        },
                        child: Image.asset(
                          'assets/icons/chart.png',
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: MediaQuery.of(context).size.width * 0.06,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.03,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HistoryScreen()));
                        },
                        child: Image.asset(
                          'assets/icons/history.png',
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: MediaQuery.of(context).size.width * 0.06,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) {
                          return const AlertDialog(
                            content: ChooseVegetableDialog(),
                          );
                        },
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.25,
                      height: MediaQuery.of(context).size.height * 0.03,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color(0xFFFF00712D)),
                      child: Center(
                        child: Text(
                          AppLocalizations.of(context)!.choosevegetable,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily:
                                AppLocalizations.of(context)!.choosevegetable ==
                                        'en'
                                    ? 'lato'
                                    : KhmerFonts.freehand,
                            fontSize:
                                AppLocalizations.of(context)!.choosevegetable ==
                                        'en'
                                    ? 10
                                    : 10,
                            // Only include the package if KhmerFonts is used
                            package:
                                AppLocalizations.of(context)!.choosevegetable ==
                                        'en'
                                    ? null
                                    : 'khmer_fonts',
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              sizebox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined),
                      Consumer<AddAreaProvider>(
                          builder: (context, dataProvider, child) {
                        return Text(
                          '${dataProvider.data}',
                          style: const TextStyle(fontFamily: 'lato'),
                        );
                      }),
                    ],
                  ),
                  Text(
                    setValue.name.isEmpty
                        ? "${AppLocalizations.of(context)!.vegetablenotfound}"
                        : setValue.name,
                    style: TextStyle(
                      fontFamily:
                          AppLocalizations.of(context)!.vegetablenotfound ==
                                  'en'
                              ? 'lato'
                              : KhmerFonts.freehand,
                      fontSize:
                          AppLocalizations.of(context)!.vegetablenotfound ==
                                  'en'
                              ? 10
                              : 12,
                      fontWeight: FontWeight.bold,
                      // Only include the package if KhmerFonts is used
                      package:
                          AppLocalizations.of(context)!.vegetablenotfound ==
                                  'en'
                              ? null
                              : 'khmer_fonts',
                    ),
                  ),
                ],
              ),
              sizebox,
              Container(
                padding: const EdgeInsets.all(10),
                height: MediaQuery.of(context).size.height * 0.25,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color(0xFFFFFFFFFF),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      // Shadow color with transparency
                      spreadRadius: 2,
                      // How much the shadow spreads
                      blurRadius: 10,
                      // How blurry the shadow is
                      offset:
                          const Offset(0, 5), // Offset in the x and y direction
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.currentPH,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: KhmerFonts.freehand,
                              package: 'khmer_fonts',
                              color: Color(0xFFFF00712D),
                              fontSize: 20),
                        ),
                      ],
                    ),
                    Center(
                      child: activatePH.switchValue == false
                          ? Center(
                              child: Text(
                                "not activate",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          : Consumer<BLEProvider>(
                              builder: (context, bleProvider, child) {
                                final number = bleProvider.latestNumber;
                                return number != null
                                    ? Text(number.toString(),style: TextStyle(fontSize: 24),)
                                    : Lottie.asset(
                                        'assets/lottie/Animation - 1729670874357.json',
                                        height: MediaQuery.of(context).size.height * 0.09,
                                        repeat: true,
                                        reverse: false,
                                        animate: true,
                                      );
                              },
                            ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${AppLocalizations.of(context)!.minPH} : ${activatePH.switchValue == false ? "" : setValue.minPh}',
                              style: TextStyle(
                                fontFamily: KhmerFonts.freehand,
                                package: 'khmer_fonts',
                                color: activatePH.switchValue == false
                                    ? const Color(0xFFFF00712D)
                                        .withOpacity(0.20)
                                    : const Color(0xFFFF00712D),
                              ),
                            ),
                            textspacing,
                            Text(
                              '${AppLocalizations.of(context)!.maxPH} : ${activatePH.switchValue == false ? "" : setValue.maxPh}',
                              style: TextStyle(
                                fontFamily: KhmerFonts.freehand,
                                package: 'khmer_fonts',
                                color: activatePH.switchValue == false
                                    ? const Color(0xFFFF00712D)
                                        .withOpacity(0.20)
                                    : const Color(0xFFFF00712D),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Center(
                              child: Text(
                                activatePH.switchValue == true
                                    ? '${AppLocalizations.of(context)!.activated}'
                                    : '${AppLocalizations.of(context)!.activate}',
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontFamily: KhmerFonts.freehand,
                                  package: 'khmer_fonts',
                                ),
                              ),
                            ),
                            Consumer<SwitchProviderPH>(
                              builder: (context, switchProvider, child) {
                                return RiffSwitch(
                                  activeColor: const Color(0xFFFF00712D),
                                  height: 50,
                                  width: 50,
                                  value: switchProvider.switchValue,
                                  onChanged: (value) async {
                                    await switchProvider.toggleSwitch(
                                        context, value);
                                    if (value) {
                                      btnSwitch.writeCharacteristic("1");
                                    } else {
                                      btnSwitch.writeCharacteristic("2");
                                    }
                                  },
                                  type: RiffSwitchType.cupertino,
                                );
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              sizebox,
              Container(
                padding: const EdgeInsets.all(10),
                height: MediaQuery.of(context).size.height * 0.25,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color(0xFFFFFFFFFF),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      // Shadow color with transparency
                      spreadRadius: 2,
                      // How much the shadow spreads
                      blurRadius: 10,
                      // How blurry the shadow is
                      offset:
                          const Offset(0, 5), // Offset in the x and y direction
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.currentEC,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: KhmerFonts.freehand,
                              package: 'khmer_fonts',
                              color: Color(0xFFFF00712D),
                              fontSize: 20),
                        ),
                      ],
                    ),
                    Center(
                      child: activateEC.switchValue == false
                          ? const Text(
                              'not activate',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : Lottie.asset(
                              'assets/lottie/Animation - 1729670874357.json',
                              height: MediaQuery.of(context).size.height * 0.09,
                              repeat: true, // Repeat animation
                              reverse: false, // Play animation in reverse
                              animate:
                                  true, // Start the animation automatically
                            ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              '${AppLocalizations.of(context)!.minEC} : ${activateEC.switchValue == false ? "" : setValue.minEC} ',
                              style: TextStyle(
                                fontFamily: KhmerFonts.freehand,
                                package: 'khmer_fonts',
                                color: activateEC.switchValue == false
                                    ? const Color(0xFFFF00712D)
                                        .withOpacity(0.20)
                                    : const Color(0xFFFF00712D),
                              ),
                            ),
                            textspacing,
                            Text(
                              '${AppLocalizations.of(context)!.maxEC} : ${activateEC.switchValue == false ? "" : setValue.maxEC} ',
                              style: TextStyle(
                                fontFamily: KhmerFonts.freehand,
                                package: 'khmer_fonts',
                                color: activateEC.switchValue == false
                                    ? const Color(0xFFFF00712D)
                                        .withOpacity(0.20)
                                    : const Color(0xFFFF00712D),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Center(
                              child: Text(
                                activateEC.switchValue == true
                                    ? '${AppLocalizations.of(context)!.activated}'
                                    : '${AppLocalizations.of(context)!.activate}',
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontFamily: KhmerFonts.freehand,
                                  package: 'khmer_fonts',
                                ),
                              ),
                            ),
                            Consumer<SwitchProviderEc>(
                              builder: (context, switchProvider, child) {
                                return RiffSwitch(
                                  activeColor: const Color(0xFFFF00712D),
                                  height: 50,
                                  width: 50,
                                  value: switchProvider.switchValue,
                                  onChanged: (value) async {
                                    await switchProvider.toggleSwitch(
                                        context, value);
                                    if (value) {
                                      btnSwitch.writeCharacteristic("1");
                                    } else {
                                      btnSwitch.writeCharacteristic("2");
                                    }
                                  },
                                  type: RiffSwitchType.cupertino,
                                );
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
