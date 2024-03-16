import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pdfLib;
import 'dart:io';
import 'package:path_provider/path_provider.dart';


class Data {
  String obm_result = '';

  Future<void> fetchObmData(String studentName) async {
    const mainUrl = 'https://www.obm.org.br/quem-somos/premiados-da-obm/';
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
          final awards = findObmAwards(subDocument, studentName);
          if (awards.isNotEmpty) {
            // Exibir as premiações na tela, indicando a subpágina
            obm_result += 'Premiações de $studentName na subpágina $subUrl: $awards\n';
            foundAny = true; // Indicar que uma ocorrência foi encontrada
          }
        } else {
          print('Failed to load data from $subUrl');
        }
      }

      // Se não foi encontrada nenhuma ocorrência, exibir mensagem
      if (!foundAny) {
        obm_result += 'Aluno não encontrado\n';
      }
    } else {
      throw Exception('Failed to load main page');
    }
  }
  

  List<Map<String, String>> findObmAwards(dom.Document document, String studentName) {
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
}
class PdfCreator {
  static Future<File> generatePdf(String text) async {
    final pdf = pdfLib.Document();

    pdf.addPage(
      pdfLib.Page(
        build: (context) => pdfLib.Center(
          child: pdfLib.Text(text),
        ),
      ),
    );

    final tempDir = await getTemporaryDirectory();
    final filePath = '${tempDir.path}/example.pdf';
    final file = File(filePath);
    await file.writeAsBytes(await pdf.save());

    return file;
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController textEditingController = TextEditingController();
  Data data = Data();

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
                onPressed: () async {
                  await data.fetchObmData(textEditingController.text);
                  setState(() {});
                },
                child: Text('Submit'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  final file = await PdfCreator.generatePdf(data.obm_result);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('PDF saved as ${file.path}')),
                  );
                },
                child: Text('Export to PDF'),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: SingleChildScrollView(
                  child: Text(data.obm_result),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
