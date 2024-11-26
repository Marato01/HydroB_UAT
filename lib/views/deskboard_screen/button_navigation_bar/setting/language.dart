import 'package:flutter/material.dart';
import 'package:khmer_fonts/khmer_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../view_model/language_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../button_navigation_bar.dart';

class Language extends StatefulWidget {
  const Language({super.key});

  @override
  State<Language> createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  @override
  Widget build(BuildContext context) {
    final languageProvider =
        Provider.of<LanguageProvider>(context); // Get language provider

    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ButtonNavigationBar()));
              },
              child: const Icon(Icons.arrow_back_ios_new)),
          centerTitle: true,
          title: Text(
            AppLocalizations.of(context)!.language,
            style: const TextStyle(
                fontFamily: KhmerFonts.freehand,
                package: 'khmer_fonts',
                color: Color(0xFFF00712D),
                fontWeight: FontWeight.bold),
          ),
          backgroundColor: const Color(0xFFFFF5F5F7),
        ),
        body: Center(
          child: Column(
            children: [
              ListTile(
                title: Text(
                  AppLocalizations.of(context)!.khmer,
                  style: const TextStyle(
                    fontFamily: KhmerFonts.freehand,
                    package: 'khmer_fonts',
                    color: Color(0xFFF00712D),
                  ),
                ),
                onTap: () {
                  languageProvider.setLocale(
                    const Locale('km'),
                  ); // Change to Khmer
                },
              ),
              ListTile(
                title: Text(
                  AppLocalizations.of(context)!.english,
                  style: const TextStyle(
                    fontFamily: KhmerFonts.freehand,
                    package: 'khmer_fonts',
                    color: Color(0xFFF00712D),
                  ),
                ),
                onTap: () {
                  languageProvider.setLocale(const Locale('en')); // Change to English
                },
              ),
            ],
          ),
        ),
    );
  }
}
