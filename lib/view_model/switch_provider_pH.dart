import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SwitchProviderPH extends ChangeNotifier {

  bool _switchValue = false;

  bool get switchValue => _switchValue;

  Future<void> toggleSwitch(BuildContext context, bool newValue) async {
    bool userConfirmed = await _showConfirmationDialog(context);

    if (userConfirmed) {
      _switchValue = newValue;
      notifyListeners();

    }
  }

  Future<bool> _showConfirmationDialog(BuildContext context) async {
    return (await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.confirmAction),
          content: Text(AppLocalizations.of(context)!.bodyofconfirm),
          actions: [
            TextButton(
              child: Text(AppLocalizations.of(context)!.yes),
              onPressed: () {
                Navigator.of(context).pop(true); // User confirmed
              },
            ),
            TextButton(
              child: Text(AppLocalizations.of(context)!.no),
              onPressed: () {
                Navigator.of(context).pop(false); // User cancelled
              },
            ),
          ],
        );
      },
    )) ?? false; // Return false if the dialog is dismissed
  }
}
