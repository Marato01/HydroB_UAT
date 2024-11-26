import 'package:flutter/material.dart';
import 'package:khmer_fonts/khmer_fonts.dart';
import '../../../category_screen/category_screen.dart';
import 'feature_addAndChangeArea/feature_add_change_area.dart';
import 'feature_addvegetable/feature_addvegetable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'language.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.setting,
          style: const TextStyle(
              fontFamily: KhmerFonts.freehand,
              package: 'khmer_fonts',
              color: Color(0xFFF00712D),
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFFFF5F5F7),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const CategoryScreen()));
            },
            child: ListTile(
              leading: const Icon(
                Icons.change_circle_outlined,
                color: Colors.green,
              ),
              title: Text(
                AppLocalizations.of(context)!.changeCategory,
                style: const TextStyle(
                  fontFamily: KhmerFonts.freehand,
                  package: 'khmer_fonts',
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FeatureAddvegetable()));
            },
            child: ListTile(
              leading: const Icon(
                Icons.add_circle_outline_outlined,
                color: Colors.green,
              ),
              title: Text(
                AppLocalizations.of(context)!.addVegetable,
                style: const TextStyle(
                  fontFamily: KhmerFonts.freehand,
                  package: 'khmer_fonts',
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FeatureAddChangeArea()));
            },
            child: ListTile(
              leading: const Icon(
                Icons.location_searching_outlined,
                color: Colors.green,
              ),
              title: Text(
                AppLocalizations.of(context)!.addAndChangeArea,
                style: const TextStyle(
                  fontFamily: KhmerFonts.freehand,
                  package: 'khmer_fonts',
                ),
              ),
            ),
          ),

          //feature using for testing widget
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => const Language()));
            },
            child: ListTile(
              leading: const Icon(
                Icons.language,
                color: Colors.green,
              ),
              title: Text(
                AppLocalizations.of(context)!.language,
                style: const TextStyle(
                  fontFamily: KhmerFonts.freehand,
                  package: 'khmer_fonts',
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
