import 'package:flutter/material.dart';
import '../core/app_export.dart';

// Tela de resultado: Roteada apenas se a busca realizada na mainScreen tiver correspondências de nome em alguma URL de site de olímpiada

class ResultFoundScreen extends StatelessWidget {
  final String obmawards;
  final String obcawards;
  final String obiAwards;
  final String obmepAwards;
  final String searchTerm;

  const ResultFoundScreen({
    Key? key,
    required this.obmawards,
    required this.obcawards,
    required this.obiAwards,
    required this.obmepAwards,
    required this.searchTerm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> obmResultContainers = _buildResultContainers(obmawards);
    List<Widget> obcResultContainers = _buildResultContainers(obcawards);
    List<Widget> obiResultContainers = _buildResultContainers(obiAwards);
    List<Widget> obmepResultContainers = _buildResultContainers(obmepAwards);

    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              _buildTwentyTwo(context),
              SizedBox(height: 15.v),
              Expanded(
                child: PageView(
                  children: [
                    for (Widget container in obmResultContainers) container,
                    for (Widget container in obcResultContainers) container,
                    for (Widget container in obiResultContainers) container,
                    for (Widget container in obmepResultContainers) container,
                    for (Widget container in obiResultContainers) container,
                  ],
                ),
              ),
              SizedBox(height: 26.v),
              Divider(
                color: Colors.grey[300],
              ),
              SizedBox(height: 10.v),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.h, vertical: 0),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 1.v, right: 5.h),
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                              context,
                              AppRoutes.mainScreen,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              vertical: 12.v,
                              horizontal: 15.h,
                            ), backgroundColor: appTheme.blueGray700,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          icon: Icon(Icons.search, color: Colors.white),
                          label: Text(
                            "Realizar outra busca",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 1.v, left: 5.h),
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // Adicione a lógica para exportar para PDF aqui
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              vertical: 12.v,
                              horizontal: 15.h,
                            ), backgroundColor: appTheme.blueGray700,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          icon: Icon(Icons.picture_as_pdf, color: Colors.white),
                          label: Text(
                            "Exportar para PDF",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5.v),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildResultContainers(String awardsString) {
    if (awardsString.trim() == 'Aluno não encontrado') {
      return [];
    }

    List<Widget> resultContainers = [];
    List<String> occurrences = awardsString.split('}, {');

    print("BUILDING");
    print(occurrences);

    for (var occurrence in occurrences) {
      // Limpeza da string para remover { e }
      occurrence = occurrence.replaceAll('{', '').replaceAll('}', '');
      Map<String, String> parsedAward = _parseAward(occurrence);
      if (parsedAward.isNotEmpty) {
        resultContainers.add(_buildResultContainer(parsedAward));
      }
    }

    return resultContainers;
  }

  Widget _buildResultContainer(Map<String, String> parsedAward) {
    String awardType = '';
    String awardYear = '';

    // Verificar se a URL contém um ano de 4 algarismos
    RegExp regex = RegExp(r'\b\d{4}\b');
    Iterable<Match> matches = regex.allMatches(parsedAward['URL'] ?? '');

    if (matches.isNotEmpty) {
      awardYear = matches.first.group(0) ?? '';
    }
    if (parsedAward['URL']?.contains('obmep') == true) {
      awardType = 'OBMEP';
      awardYear = 'Edição 18';
    } else if (parsedAward['URL']?.contains('obm') == true) {
      awardType = 'OBM';
    } else if (parsedAward['URL']?.contains('obciencias') == true) {
      awardType = 'OBC';
    } else if (parsedAward['URL']?.contains('obi') == true) {
      awardType = 'OBI';
    } 

    String awardTitle = awardType.isEmpty ? 'Award' : '$awardType - $awardYear';

    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 24.h),
        padding: EdgeInsets.symmetric(
          horizontal: 19.h,
          vertical: 20.v,
        ),
        decoration: AppDecoration.outlineGray70001.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder10,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              awardTitle,
              style: CustomTextStyles.headlineSmallGray80001,
            ),
            SizedBox(height: 9.v),
            _buildResultSection(
              pontuaO: "Nome: ",
              oneHundredFiftyEight: parsedAward['Nome'] ?? '-',
            ),
            SizedBox(height: 10.v),
            _buildResultSection(
              pontuaO: "Cidade / Estado:",
              oneHundredFiftyEight: parsedAward['Cidade - Estado'] ?? '-',
            ),
            SizedBox(height: 10.v),
            _buildResultSection(
              pontuaO: "Pontuação: ",
              oneHundredFiftyEight: parsedAward['Pontuação'] ?? '-',
            ),
            SizedBox(height: 9.v),
            _buildResultSection(
              pontuaO: "Medalha: ",
              oneHundredFiftyEight: parsedAward['Medalha'] ?? '-',
            ),
            SizedBox(height: 9.v),
            _buildResultSection(
              pontuaO: "Link: ",
              oneHundredFiftyEight: parsedAward['URL'] ?? '-',
            ),
          ],
        ),
      ),
    );
  }

  Map<String, String> _parseAward(String award) {
    Map<String, String> parsedValues = {};

    // Remover o texto inicial "[Premiações de Carlos Yuzo"
    int startIndex = award.indexOf('Nome: ');
    if (startIndex != -1) {
      award = award.substring(startIndex);
    }

    // Remover caracteres indesejados no final
    award = award.replaceAll(RegExp(r'\]\s*$'), '');

    List<String> parts = award.split(', ');

    for (String part in parts) {
      List<String> keyValue = part.split(': ');

      if (keyValue.length == 2) {
        String key = keyValue[0].trim();
        String value = keyValue[1].trim();
        if (key == 'Prêmio' || key == 'Medalha') {
          key = 'Medalha'; // Definir a chave como "Medalha"
        }
        parsedValues[key] = value;
      } else if (part.startsWith('Nome')) {
        // Verificar se a parte começa com "Nome"
        int index = part.indexOf(': '); // Encontrar o índice de ": "
        if (index != -1) {
          // Extrair o valor após "Nome: "
          String value = part
              .substring(index + 2)
              .replaceAll('[', ''); // Remover o '[' do início
          parsedValues['Nome'] = value;
        }
      }
    }

    return parsedValues;
  }

  Widget _buildResultSection({
    required String pontuaO,
    required String oneHundredFiftyEight,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 15.h,
        vertical: 12.v,
      ),
      decoration: AppDecoration.fillPrimary.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder10,
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 4.v),
            child: Text(
              pontuaO,
              style: CustomTextStyles.titleMediumPrimaryContainer.copyWith(
                color: theme.colorScheme.primaryContainer,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                left: 10.h,
                top: 2.v,
              ),
              child: Text(
                oneHundredFiftyEight,
                style: theme.textTheme.titleMedium!.copyWith(
                  color: appTheme.blue500,
                ),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTwentyTwo(BuildContext context) {
    return SizedBox(
      height: 305.v,
      width: double.maxFinite,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 31.v),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 137.v,
                    width: 224.h,
                    child: Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.imgVector,
                          height: 74.v,
                          width: 224.h,
                          alignment: Alignment.bottomCenter,
                        ),
                        CustomImageView(
                          imagePath: ImageConstant.imgGroup,
                          height: 137.v,
                          width: 14.h,
                          alignment: Alignment.centerRight,
                          margin: EdgeInsets.only(right: 97.h),
                        ),
                        CustomImageView(
                          imagePath: ImageConstant.imgVector,
                          height: 74.v,
                          width: 224.h,
                          alignment: Alignment.bottomCenter,
                        ),
                        CustomImageView(
                          imagePath: ImageConstant.imgGroup,
                          height: 137.v,
                          width: 14.h,
                          alignment: Alignment.centerRight,
                          margin: EdgeInsets.only(right: 97.h),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.v),
                  SizedBox(
                    height: 3.v,
                    width: 233.h,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: 233.h,
                            child: Divider(),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: 233.h,
                            child: Divider(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8.v),
                  Text(
                    "BOOC",
                    style: theme.textTheme.headlineLarge,
                  ),
                  SizedBox(height: 12.v),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: 239.h,
              child: FittedBox(
                fit: BoxFit.fitHeight,
                child: Text(
                  "Aluno(a): $searchTerm",
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.displayMedium,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
