import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;
import 'package:pdf/widgets.dart' as pdfLib;
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class Data {
  String obm_result = 'Aluno não encontrado\n';
  String obc_result = '';

  //Método para buscar URLS desejadas e retornar status da busca da OBM
  //Dentro do corpo chama função para percorrer o HTML das URLs identificada e com statuscode 200 (sucesso no get) e buscar as premiações
  Future<void> fetchObmData(String studentName) async {
    const mainUrl = 'https://www.obm.org.br/quem-somos/premiados-da-obm/';
    final mainResponse = await http.get(Uri.parse(mainUrl));
    if (mainResponse.statusCode == 200) {
      final mainDocument = parser.parse(mainResponse.body);

      final subUrls = mainDocument
          .querySelectorAll('a[href^="https://www.obm.org.br/premiados"]');
      final List<Map<String, String>> obmAwards = [];

      for (final subUrlElement in subUrls) {
        final subUrl = subUrlElement.attributes['href'];
        final subResponse = await http.get(Uri.parse(subUrl!));
        if (subResponse.statusCode == 200) {
          final subDocument = parser.parse(subResponse.body);
          final awards = findObmAwards(subDocument, studentName, subUrl);
          obmAwards.addAll(awards);
          print(obmAwards);
        } else {
          print('Failed to load data from $subUrl');
        }
      }

      if (obmAwards.isEmpty) {
        obm_result = 'Aluno não encontrado\n';
      } else {
        obm_result = 'Premiações de $studentName $obmAwards\n';
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

    final List<Map<String, String>> obcAwards = [];

    for (final url in urls) {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final document = parser.parse(response.body);
        final awards = findObcAwards(document, studentName);
        obcAwards.addAll(awards);
      } else {
        print('Failed to load data from $url');
      }
    }
  }

  // Função para percorrer o HTML das urls passadas pela função fetchObmData, e buscar correspondência de nome.
  // Ao encontrar correspondência, armazena valores referentes a premiação em um mapa (dicionário) com par chave (ex. award['Nome'] = studentName)
  // Ao final armazena todas as informações do mapa no resultado "OBM awards" e retorna o resultado
  List<Map<String, String>> findObmAwards(
      dom.Document document, String studentName, String url) {
    final tables = document.querySelectorAll('table');
    final List<Map<String, String>> obmAwards = [];
    print(' ENTROUENTROUENTROUENTROUENTROU');

    for (final table in tables) {
      final rows = table.querySelectorAll('tr');

      for (final row in rows) {
        final cells = row.children;
        for (int i = 0; i < cells.length; i++) {
          final cellText = cells[i].text;
          if (cellText.contains(studentName)) {
            final award = <String, String>{};

            award['Nome'] = cellText; // Armazena o nome completo
            award['URL'] = url; // Armazena a URL

            if (url.contains('2017') ||
                url.contains('2018') ||
                url.contains('2019') ||
                url.contains('2020') ||
                url.contains('2021') ||
                url.contains('2022') ||
                url.contains('2023') ||
                url.contains('2024') ||
                url.contains('2025') ||
                url.contains('2026') ||
                url.contains('2027') ||
                url.contains('2028') ||
                url.contains('2029') ||
                url.contains('2030')) {
              if (i + 1 < cells.length) {
                award['Cidade - Estado'] = cells[i + 1].text;
              }

              if (i + 2 < cells.length) {
                award['Pontuação'] = cells[i + 2].text;
              }
              if (i + 3 < cells.length) {
                award['Medalha'] = cells[i + 3].text;
              }
            } else if (url.contains('2016') ||
                url.contains('2015') ||
                url.contains('2014') ||
                url.contains('2013') ||
                url.contains('2012') ||
                url.contains('2011') ||
                url.contains('2010') ||
                url.contains('2009') ||
                url.contains('2008') ||
                url.contains('2007') ||
                url.contains('2006') ||
                url.contains('2005') ||
                url.contains('2004') ||
                url.contains('2003') ||
                url.contains('2002') ||
                url.contains('2001') ||
                url.contains('2000') ||
                url.contains('1999') ||
                url.contains('1998')) {
              if (i + 1 < cells.length) {
                award['Pontuação'] = cells[i + 1].text;
              }

              if (i + 2 < cells.length) {
                award['Cidade - Estado'] = cells[i + 2].text;
              }
              if (i + 3 < cells.length) {
                award['Medalha'] = cells[i + 3].text;
              }
            } else if (url.contains('1997') ||
                url.contains('1996') ||
                url.contains('1995') ||
                url.contains('1994') ||
                url.contains('1993') ||
                url.contains('1992') ||
                url.contains('1991') ||
                url.contains('1990') ||
                url.contains('1989') ||
                url.contains('1988') ||
                url.contains('1987') ||
                url.contains('1986') ||
                url.contains('1985') ||
                url.contains('1984') ||
                url.contains('1983') ||
                url.contains('1982') ||
                url.contains('1981') ||
                url.contains('1980') ||
                url.contains('1979')) {
              if (i + 1 < cells.length) {
                award['Prêmio'] = cells[i + 1].text;
              }

              if (i + 2 < cells.length) {
                award['Cidade - Estado'] = cells[i + 2].text;
              }
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
  List<Map<String, String>> findObcAwards(
      dom.Document document, String studentName) {
    final List<Map<String, String>> obcAwards = [];

    final paragraphs = document.querySelectorAll('.main-wrap .paragraph');
    print("ENTROU ENTROUENTROUENTROU ENTROUENTROU ENTROU");

    for (final paragraph in paragraphs) {
      final brTags = paragraph.querySelectorAll('br');
      for (final brTag in brTags) {
        final studentNameTag = brTag.parent;
        if (studentNameTag!.text.contains(studentName)) {
          final award = <String, String>{};

          award['Nome'] = brTag.text.trim(); // Armazena o nome completo
          print(award);

          final h2 = paragraph.previousElementSibling?.previousElementSibling;
          if (h2 != null) {
            final medalhaText = h2.text.trim().toLowerCase();
            if (medalhaText.contains('ouro')) {
              award['Medalha'] = 'Ouro';
            } else if (medalhaText.contains('prata')) {
              award['Medalha'] = 'Prata';
            } else if (medalhaText.contains('bronze')) {
              award['Medalha'] = 'Bronze';
            } else if (medalhaText.contains('honrosas')) {
              award['Medalha'] = 'Menções Honrosas';
            }
          }

          if (award.containsKey('Medalha')) {
            obcAwards.add(award);
            // Não há mais break aqui para continuar procurando medalhas para o mesmo aluno
          }
        }
      }
    }

    return obcAwards;
  }
}

// Classe para criar PDF, mudar de lugar depois
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
