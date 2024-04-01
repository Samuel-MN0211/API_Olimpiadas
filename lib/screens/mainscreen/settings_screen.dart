import 'package:flutter/material.dart';
import 'package:BOOC/core/app_export.dart';

// Atualmente utilizada para construir o modal implementado na mainscreen e configurado pelo modal_settings.dart
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configurações'),
      ),
      body: SingleChildScrollView(
        // Adicione o SingleChildScrollView aqui
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<SettingsProvider>(
            builder: (context, settingsProvider, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CheckboxListTile(
                    title: Text('OBM'),
                    value: settingsProvider
                        .isObmSelected, // Use o provider para obter o estado do checkbox
                    onChanged: (value) {
                      setState(() {
                        settingsProvider
                            .toggleObm(); // Use o provider para alternar o estado do checkbox
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: Text('OBC'),
                    value: settingsProvider
                        .isObcSelected, // Use o provider para obter o estado do checkbox
                    onChanged: (value) {
                      setState(() {
                        settingsProvider
                            .toggleObc(); // Use o provider para alternar o estado do checkbox
                      });
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
