import 'dart:io';

import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pdfLib;

import 'app_export.dart';

class Data {
  String obm_result = 'Aluno não encontrado\n';
  String obc_result = '';
  String obi_result = '';
  String obmep_result = '';

  //Método para buscar URLS desejadas e retornar status da busca da OBM
  //Dentro do corpo chama função para percorrer o HTML das URLs identificada e com statuscode 200 (sucesso no get) e buscar as premiações
  Future<void> fetchObmData(
      String studentName, SettingsProvider settingsProvider) async {
    final startYear = settingsProvider.startYear;
    final endYear = settingsProvider.endYear;
    const mainUrl = 'https://www.obm.org.br/quem-somos/premiados-da-obm/';
    final mainResponse = await http.get(Uri.parse(mainUrl));
    if (mainResponse.statusCode == 200) {
      final mainDocument = parser.parse(mainResponse.body);

      final subUrls = mainDocument
          .querySelectorAll('a[href^="https://www.obm.org.br/premiados"]');
      final List<Map<String, String>> obmAwards = [];

      for (final subUrlElement in subUrls) {
        final subUrl = subUrlElement.attributes['href'];

        // Verifica se a URL contém um ano entre startYear e endYear
        if (subUrl != null && shouldCheckUrl(subUrl, startYear, endYear)) {
          final subResponse = await http.get(Uri.parse(subUrl));
          if (subResponse.statusCode == 200) {
            final subDocument = parser.parse(subResponse.body);
            final awards = findObmAwards(subDocument, studentName, subUrl);
            obmAwards.addAll(awards);
          } else {
            print('Failed to load data from $subUrl');
          }
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

  bool shouldCheckUrl(String url, int? startYear, int? endYear) {
    if (startYear == null || endYear == null) {
      // Se qualquer um dos anos for nulo, verificar todas as URLs
      return true;
    }

    // Extrair o ano da URL
    final yearMatch = RegExp(r'\d{4}').firstMatch(url);
    if (yearMatch != null) {
      final year = int.parse(yearMatch.group(0)!);
      // Verificar se o ano está no intervalo definido por startYear e endYear
      return year >= startYear && year <= endYear;
    }

    return false; // Se a URL não contém ano, pular
  }

  //Método para buscar URLS desejadas e retornar status da busca da OBC
  // Possui um array de URLs pois ao contrário da OBM, as urls de premiação não estão todas contidas no HTML de uma página de diretório superior
  //Dentro do corpo chama função para percorrer o HTML das URLs do array com statuscode 200 (sucesso no get) e buscar as premiações
  Future<void> fetchObcData(String studentName) async {
    print('Começou OBC');
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
        print("GET SUCESSO");
        final document = parser.parse(response.body);
        final awards = findObcAwards(document, studentName, url);
        obcAwards.addAll(awards);
      } else {
        print('Failed to load data from $url');
      }
    }

    if (obcAwards.isEmpty) {
      obc_result = 'Aluno não encontrado\n';
    } else {
      obc_result = 'Premiações de $studentName $obcAwards\n';
      print(obc_result);
    }
  }

  //Método para buscar URLS desejadas e retornar status da busca da OBMEP
  //Dentro do corpo chama função para percorrer o HTML das URLs identificada e com statuscode 200 (sucesso no get) e buscar as premiações
  Future<void> fetchObiData(String studentName) async {
    print("Começou OBI");
    final mainUrl = 'https://olimpiada.ic.unicamp.br/passadas/OBI2023/qmerito/ps/';
    final mainResponse = await http.get(Uri.parse(mainUrl));
    if (mainResponse.statusCode == 200) {
      final mainDocument = parser.parse(mainResponse.body);
      final List<Map<String, String>> obiAwards = [];
      final awards = findObiAwards(mainDocument, studentName, mainUrl);
      obiAwards.addAll(awards);
      if (obiAwards.isEmpty) {
        obi_result = 'Aluno não encontrado\n';
      } else {
        obi_result = 'Premiações de $studentName $obiAwards\n';
      }
    } else {
      throw Exception('Failed to load results page');
    }
  }

    //Método para buscar URLS desejadas e retornar status da busca da OBMEP
  //Dentro do corpo chama função para percorrer o HTML das URLs identificada e com statuscode 200 (sucesso no get) e buscar as premiações
  Future<void> fetchObmepData(String studentName) async {
    print("Começou OBMEP");
    const medalhas = ['Bronze', 'Prata', 'Ouro'];
    for (final medalha in medalhas) {
      final mainUrl =
          'https://premiacao.obmep.org.br/18obmep/verRelatorioPremiados$medalha.do.htm';
      final mainResponse = await http.get(Uri.parse(mainUrl));
      if (mainResponse.statusCode == 200) {
        final mainDocument = parser.parse(mainResponse.body);
        final List<Map<String, String>> obmepAwards = [];
        final awards = findObmepAwards(mainDocument, studentName, mainUrl);
        obmepAwards.addAll(awards);
        if (obmepAwards.isEmpty) {
          obmep_result = 'Aluno não encontrado\n';
        } else {
          obmep_result = 'Premiações de $studentName $obmepAwards\n';
        }
      } else {
        throw Exception('Failed to load results page');
      }
    }
  }

  //Método responsável por fazer match das URLs de imagem das medalhas OBI pela a premiação correspondente
  String parseObiMedalCell(String cellText) {
    final medalMap = {
      'ouro': 'Ouro',
      'prata': 'Prata',
      'bronze': 'Bronze',
      'HM': 'Honra ao Mérito',
    };

    for (var key in medalMap.keys) {
      if (cellText.contains(key)) {
        return medalMap[key]!;
      }
    }

    return '-';
  }

  // Função para percorrer o HTML das urls passadas pela função fetchObiData, e buscar correspondência de nome.
  // Ao encontrar correspondência, armazena valores referentes a premiação em um mapa (dicionário) com par chave (ex. award['Nome'] = studentName)
  // Ao final armazena todas as informações do mapa no resultado "OBI awards" e retorna o resultado
  List<Map<String, String>> findObiAwards(
      dom.Document document, String studentName, String url) {
    final tables = document.querySelectorAll('table');
    final List<Map<String, String>> obiAwards = [];
    for (final table in tables) {
      final tbody = table.querySelector('tbody');
      final rows = tbody?.querySelectorAll('tr');

      if (rows != null) {
        for (final row in rows) {
          final cells = row.children;
          for (int i = 0; i < cells.length; i++) {
            final cellText = cells[i].text;
            if (cellText.toLowerCase().contains(studentName.toLowerCase())) {
              final award = <String, String>{};

              award['Nome'] = cells[3].text; // Armazena o nome completo
              award['URL'] = url; // Armazena a URL
              award['Escola'] = cells[4].text;
              award['Pontuação'] = cells[2].text;
              award['Cidade - Estado'] = '${cells[5].text} - ${cells[6].text}';
              award['Medalha'] = parseObiMedalCell(cells[0].innerHtml);

              obiAwards.add(award);
            }
          }
        }
      }
    }

    return obiAwards;
  }

  // Função para percorrer o HTML das urls passadas pela função fetchObmData, e buscar correspondência de nome.
  // Ao encontrar correspondência, armazena valores referentes a premiação em um mapa (dicionário) com par chave (ex. award['Nome'] = studentName)
  // Ao final armazena todas as informações do mapa no resultado "OBM awards" e retorna o resultado
  List<Map<String, String>> findObmAwards(
      dom.Document document, String studentName, String url) {
    final tables = document.querySelectorAll('table');
    final List<Map<String, String>> obmAwards = [];

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
              if (i + 3 < cells.length) {
                award['Escola'] = cells[i + 3].text;
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
  // Ao encontrar correspondência, armazena valores referentes a premiação em um mapa (dicionário) com par chave (ex. award['Nome'] = studentName)
  // Ao final armazena todas as informações do mapa no resultado "OBC awards" e retorna o resultado

  List<Map<String, String>> findObcAwards(
      dom.Document document, String studentName, String url) {
    print('Entrou OBC awards');
    final List<Map<String, String>> obcAwards = [];

    // Encontra todos os parágrafos
    final paragraphs = document.querySelectorAll('div.paragraph');

    for (final paragraph in paragraphs) {
      final allText = paragraph.text.trim(); // Captura todo o texto da div

      if (allText.contains(studentName)) {
        print('Nome do aluno encontrado: $studentName');

        final award = <String, String>{};
        award['Nome'] = studentName;
        award['URL'] = url; // Armazena a URL onde a premiação foi encontrada

        // Identifica a medalha com base no texto do elemento <h2> anterior
        final h2 = paragraph.previousElementSibling;
        if (h2 != null && h2.localName == 'h2') {
          final medalhaText = h2.text.trim();

          if (medalhaText.contains('Ouro')) {
            award['Medalha'] = 'Ouro';
          } else if (medalhaText.contains('Prata')) {
            award['Medalha'] = 'Prata';
          } else if (medalhaText.contains('Bronze')) {
            award['Medalha'] = 'Bronze';
          } else if (medalhaText.contains('Honrosa')) {
            award['Medalha'] = 'Menção Honrosa';
          }
        }

        if (award.containsKey('Medalha')) {
          obcAwards.add(award);
          print('Premiação adicionada: $award'); // Imprime o prêmio adicionado
        }
      }
    }
    print(obcAwards);
    return obcAwards;
  }

  // Função para percorrer o HTML das urls passadas pela função fetchObmepData, e buscar correspondência de nome.
  // Ao encontrar correspondência, armazena valores referentes a premiação em um mapa (dicionário) com par chave (ex. award['Nome'] = studentName)
  // Ao final armazena todas as informações do mapa no resultado "OBMEP awards" e retorna o resultado
  List<Map<String, String>> findObmepAwards(
      dom.Document document, String studentName, String url) {
    final tables = document.querySelectorAll('table');
    final List<Map<String, String>> obmepAwards = [];

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

            if (url.contains('Ouro')) {
              if (i + 1 < cells.length) {
                award['Medalha'] = 'Ouro';
              }
            } else if (url.contains('Prata')) {
              if (i + 1 < cells.length) {
                award['Medalha'] = 'Prata';
              }
            } else if (url.contains('Bronze')) {
              if (i + 1 < cells.length) {
                award['Medalha'] = 'Bronze';
              }
            }

            obmepAwards.add(award);
          }
        }
      }
    }

    return obmepAwards;
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
