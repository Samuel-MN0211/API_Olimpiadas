import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _nameController = TextEditingController();
  String selectedOlympiad = 'Todos';
  String selectedMedal = 'Todas';

  final List<String> olympiadOptions = [
    'Todos',
    'OBM',
    'OBI',
    'OBC',
    'OBMEP',
  ];
  final List<String> medalOptions = [
    'Todas',
    'Ouro',
    'Prata',
    'Bronze',
    'Menção Honrosa'
  ];

  List<Map<String, String>> searchResults = []; // Resultados de exemplo

  void _search() {
    // Simulando uma busca
    setState(() {
      searchResults = [
        {
          'Nome': _nameController.text,
          'Olimpíada': selectedOlympiad,
          'Medalha': selectedMedal,
        },
        // Adicione mais resultados conforme necessário
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: TextField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: 'Nome',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: DropdownButtonFormField<String>(
                        value: selectedOlympiad,
                        items: olympiadOptions.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value, overflow: TextOverflow.ellipsis),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            selectedOlympiad = newValue!;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Olimpíada',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      flex: 3,
                      child: DropdownButtonFormField<String>(
                        value: selectedMedal,
                        items: medalOptions.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value, overflow: TextOverflow.ellipsis),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            selectedMedal = newValue!;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Medalha',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: _search,
                      child: Icon(Icons.search),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ...searchResults
                    .map((result) => _buildResultContainer(result))
                    .toList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResultContainer(Map<String, String> result) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 19, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            result['Nome'] ?? '-',
          ),
          SizedBox(height: 9),
          _buildResultSection(
            title: "Olimpíada:",
            value: result['Olimpíada'] ?? '-',
          ),
          SizedBox(height: 10),
          _buildResultSection(
            title: "Medalha:",
            value: result['Medalha'] ?? '-',
          ),
        ],
      ),
    );
  }

  Widget _buildResultSection({required String title, required String value}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: Colors.blueAccent),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
