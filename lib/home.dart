import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController textEditingController = TextEditingController();
  TextEditingController yearEditingController = TextEditingController();
  String result = '';

  Future<void> fetchData(String studentName) async {
  final mainUrl = 'https://www.obm.org.br/quem-somos/premiados-da-obm/';
  final mainResponse = await http.get(Uri.parse(mainUrl));
  if (mainResponse.statusCode == 200) {
    final mainDocument = parser.parse(mainResponse.body);

    // Encontrar links das subpáginas que começam com "premiados"
    final subUrls = mainDocument.querySelectorAll('a[href^="https://www.obm.org.br/premiados"]');
    bool foundAny = false; // Variável para controlar se alguma ocorrência foi encontrada

    for (final subUrlElement in subUrls) {
      final subUrl = subUrlElement.attributes['href'];
      final subResponse = await http.get(Uri.parse(subUrl!));
      if (subResponse.statusCode == 200) {
        final subDocument = parser.parse(subResponse.body);
        final awards = findAwards(subDocument, studentName);
        if (awards.isNotEmpty) {
          // Exibir as premiações na tela, indicando a subpágina
          setState(() {
            result += 'Premiações de $studentName na subpágina $subUrl: $awards\n';
          });
          foundAny = true; // Indicar que uma ocorrência foi encontrada
        }
      } else {
        print('Failed to load data from $subUrl');
      }
    }

    // Se não foi encontrada nenhuma ocorrência, exibir mensagem
    if (!foundAny) {
      setState(() {
        result += 'Aluno não encontrado\n';
      });
    }
  } else {
    throw Exception('Failed to load main page');
  }
}


List<Map<String, String>> findAwards(dom.Document document, String studentName) {
  final tables = document.querySelectorAll('table');
  final List<Map<String, String>> awards = [];

  for (final table in tables) {
    final rows = table.querySelectorAll('tr');
    for (final row in rows) {
      final cells = row.children;
      for (int i = 0; i < cells.length; i++) {
        if (cells[i].text.contains(studentName)) {
          final award = <String, String>{};

          award['Nome'] = cells[i].text;

          if (i + 1 < cells.length) {
            award['Origem'] = cells[i + 1].text;
          }

          if (i + 2 < cells.length) {
            award['Pontuação'] = cells[i + 2].text;
          }

          if (i + 3 < cells.length) {
            award['Medalha'] = cells[i + 3].text;
          }

          awards.add(award);
        }
      }
    }
  }

  return awards;
}


  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Home'),
    ),
    body: Center(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Enter the student name:',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 16),
            TextField(
              controller: textEditingController,
              decoration: InputDecoration(
                hintText: 'Type here',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                fetchData(textEditingController.text);
              },
              child: Text('Submit'),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Text(result),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
}