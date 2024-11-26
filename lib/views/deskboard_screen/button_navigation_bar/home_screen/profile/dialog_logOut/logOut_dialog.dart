import 'package:flutter/material.dart';
import '../../../../../signIn/sign_in_option_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class LogoutDialog extends StatefulWidget {
  const LogoutDialog({super.key});

  @override
  State<LogoutDialog> createState() => _LogoutDialogState();
}

class _LogoutDialogState extends State<LogoutDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.15,
      child: Column(
        children: [
          Center(
            child: Text(
              AppLocalizations.of(context)!.logoutask,
              style: const TextStyle(fontFamily: 'lato', fontSize: 15),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Center(
                  child: Text(
                    AppLocalizations.of(context)!.no,
                    style: const TextStyle(fontFamily: 'lato', color: Colors.black),
                  ),
                ),
              ),

              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignInOptionScreen()));
                },
                child: Center(
                  child: Text(
                    AppLocalizations.of(context)!.yes,
                    style: const TextStyle(fontFamily: 'lato', color: Colors.black),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFC80036),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
