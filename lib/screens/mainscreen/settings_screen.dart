import 'package:flutter/material.dart';

import '../../core/app_export.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int? selectedStartYear;
  int? selectedEndYear;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configurações'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<SettingsProvider>(
            builder: (context, settingsProvider, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CheckboxListTile(
                    title: Text('OBM'),
                    value: settingsProvider.isObmSelected,
                    onChanged: (value) {
                      setState(() {
                        settingsProvider.toggleObm();
                        if (!settingsProvider.isObmSelected) {
                          selectedStartYear = null;
                          selectedEndYear = null;
                          settingsProvider.setStartYear(null);
                          settingsProvider.setEndYear(null);
                        }
                      });
                    },
                  ),
                  if (settingsProvider.isObmSelected) ...[
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButton<int>(
                            value: selectedStartYear,
                            hint: Text("Ano Inicial"),
                            items: List.generate(2023 - 1979 + 1, (index) {
                              int year = 1979 + index;
                              return DropdownMenuItem<int>(
                                value: year,
                                child: Text(year.toString()),
                              );
                            }),
                            onChanged: (value) {
                              setState(() {
                                selectedStartYear = value;
                                selectedEndYear =
                                    null; // Reset the end year selection
                                settingsProvider.setStartYear(value);
                              });
                            },
                            isExpanded: true,
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: DropdownButton<int>(
                            value: selectedEndYear,
                            hint: Text("Ano Final"),
                            items: selectedStartYear != null
                                ? List.generate(2023 - selectedStartYear! + 1,
                                    (index) {
                                    int year = selectedStartYear! + index;
                                    return DropdownMenuItem<int>(
                                      value: year,
                                      child: Text(year.toString()),
                                    );
                                  })
                                : [],
                            onChanged: (value) {
                              setState(() {
                                selectedEndYear = value;
                                settingsProvider.setEndYear(value);
                              });
                            },
                            isExpanded: true,
                          ),
                        ),
                      ],
                    ),
                  ],
                  CheckboxListTile(
                    title: Text('OBC'),
                    value: settingsProvider.isObcSelected,
                    onChanged: (value) {
                      setState(() {
                        settingsProvider.toggleObc();
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: Text('OBI'),
                    value: settingsProvider
                        .isObiSelected, // Use o provider para obter o estado do checkbox
                    onChanged: (value) {
                      setState(() {
                        settingsProvider
                            .toggleObi(); // Use o provider para alternar o estado do checkbox
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: Text('OBMEP'),
                    value: settingsProvider.isObmepSelected,
                    onChanged: (value) {
                      setState(() {
                        settingsProvider.toggleObmep();
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
