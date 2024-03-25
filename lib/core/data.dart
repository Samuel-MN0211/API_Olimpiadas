import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;
import 'package:pdf/widgets.dart' as pdfLib;
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class Data {
  String obm_result = '';
  String obc_result = '';

  //Método para buscar URLS desejadas e retornar status da busca da OBM 
  //Dentro do corpo chama função para percorrer o HTML das URLs identificada e com statuscode 200 (sucesso no get) e buscar as premiações
  Future<void> fetchObmData(String studentName) async {
    const mainUrl = 'https://www.obm.org.br/quem-somos/premiados-da-obm/';
    final mainResponse = await http.get(Uri.parse(mainUrl));
    if (mainResponse.statusCode == 200) {
      final mainDocument = parser.parse(mainResponse.body);

      final subUrls = mainDocument.querySelectorAll('a[href^="https://www.obm.org.br/premiados"]');
      bool foundAny = false;

      for (final subUrlElement in subUrls) {
        final subUrl = subUrlElement.attributes['href'];
        final subResponse = await http.get(Uri.parse(subUrl!));
        if (subResponse.statusCode == 200) {
          final subDocument = parser.parse(subResponse.body);
          final obmAwards = findObmAwards(subDocument, studentName);
          if (obmAwards.isNotEmpty) {
            obm_result += 'Premiações de $studentName na subpágina $subUrl: $obmAwards\n';
            foundAny = true;
          }
        } else {
          print('Failed to load data from $subUrl');
        }
      }

      if (!foundAny) {
        obm_result = 'Aluno não encontrado\n';
      }
    } else {
      throw Exception('Failed to load main page');
    }
  }
  //Método para buscar URLS desejadas e retornar status da busca da OBC
  // Possui um array de URLs pois ao contrário da OBM, as urls de premiação não estão todas contidas no HTML de uma página de diretório superior
  //Dentro do corpo chama função para percorrer o HTML das URLs do array com statuscode 200 (sucesso no get) e buscar as premiações
  Future<void> fetchObcData(String studentName) async {
    final List<String> urls = [
      'http://www.obciencias.com.br/resultados-2023.html',
      'http://www.obciencias.com.br/resultados-2022.html',
      'http://www.obciencias.com.br/resultados-2021.html',
      'http://www.obciencias.com.br/resultados-2020.html',
      'http://www.obciencias.com.br/resultados-2019.html',
      'http://www.obciencias.com.br/resultados-2018.html',
      'http://www.obciencias.com.br/resultados-2017.html',
      'http://www.obciencias.com.br/resultados-2016.html',
      'http://www.obciencias.com.br/resultados-2015.html',
      'http://www.obciencias.com.br/resultados-2014.html',
    ];

    for (final url in urls) {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final document = parser.parse(response.body);
        final obcAwards = findObcAwards(document, studentName);
        if (obcAwards.isNotEmpty) {
          obc_result += 'Premiações de $studentName na subpágina $url: $obcAwards\n';
        }
      } else {

        print('Failed to load data from $url');
      }
    }
  }
  // Função para percorrer o HTML das urls passadas pela função fetchObmData, e buscar correspondência de nome.
  // Ao encontrar correspondência, armazena valores referentes a premiação em um mapa (dicionário) com par chave (ex. award['Nome'] = studentName)
  // Ao final armazena todas as informações do mapa no resultado "OBM awards" e retorna o resultado 
  List<Map<String, String>> findObmAwards(dom.Document document, String studentName) {
    final tables = document.querySelectorAll('table');
    final List<Map<String, String>> obmAwards = [];

    for (final table in tables) {
      final rows = table.querySelectorAll('tr');
      for (final row in rows) {
        final cells = row.children;
        for (int i = 0; i < cells.length; i++) {
          if (cells[i].text.contains(studentName)) {
            final award = <String, String>{};

            award['Nome'] = studentName;

            if (i + 1 < cells.length) {
              award['Origem'] = cells[i + 1].text;
            }

            if (i + 2 < cells.length) {
              award['Pontuação'] = cells[i + 2].text;
            }

            if (i + 3 < cells.length) {
              award['Medalha'] = cells[i + 3].text;
            }

            obmAwards.add(award);
          }
        }
      }
    }

    return obmAwards;
  }
  // Função para percorrer o HTML das urls passadas pela função fetchObcData, e buscar correspondência de nome.
  // Ao encontrar correspondência, armazena valores referentes a premiação  em um mapa (dicionário) com par chave (ex. award['Nome'] = studentName)
  // Como a OBC não possui uma estrutura de premiação tão bem definida quanto a OBM, a função busca por medalhas de bronze, prata, ouro e menções honrosas
  // Ao final armazena todas as informações do mapa no resultado "OBC awards" e retorna o resultado 
  List<Map<String, String>> findObcAwards(dom.Document document, String studentName) {
    final List<Map<String, String>> obcAwards = [];

    final paragraphs = document.querySelectorAll('.main-wrap .paragraph');
    

    for (final paragraph in paragraphs) {
      final studentNames = paragraph.querySelectorAll('strong');
      for (final name in studentNames) {
        if (name.text.contains(studentName)) {
          
          final award = <String, String>{};

          award['Nome'] = studentName;

          final h2 = paragraph.previousElementSibling?.previousElementSibling;
          if (h2 != null) {
            final medalha = h2.text.trim();
            if (medalha == 'Medalhas de Bronze' ||
                medalha == 'Medalhas de Prata' ||
                medalha == 'Medalhas de Ouro' ||
                medalha == 'Menções Honrosas') {
              award['Medalha'] = medalha;
            }
          }

          obcAwards.add(award);
        }
      }
    }

    return obcAwards;
  }
}
// Classe para criar PDF
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




//Classe de interface para teste, apagar futuramente
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
              ElevatedButton(                onPressed: () async {
                  await data.fetchObmData(textEditingController.text);
                  await data.fetchObcData(textEditingController.text);
                  setState(() {});
                },
                child: Text('Submit'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  final file = await PdfCreator.generatePdf('${data.obm_result}\n${data.obc_result}');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('PDF saved as ${file.path}')),
                  );
                },
                child: Text('Export to PDF'),
              ),
              const SizedBox(height: 16),
              if (data.obm_result.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('OBM Result:', style: TextStyle(fontWeight: FontWeight.bold)),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Text(data.obm_result),
                      ),
                    ),
                  ],
                ),
              if (data.obc_result.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('OBC Result:', style: TextStyle(fontWeight: FontWeight.bold)),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Text(data.obc_result),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}