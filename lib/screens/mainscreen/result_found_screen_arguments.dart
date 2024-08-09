//Argumentos (valores) que serão passados para a tela de "found" caso alguma ocorrência ocorra e o roteamento para a tela "found" seja acionado
class ResultFoundScreenArguments {
  final String obmawards;
  final String obcawards;
  final String obiAwards;
  final String obmepAwards;
  final String searchTerm;

  ResultFoundScreenArguments({
    required this.obmawards,
    required this.obcawards,
    required this.obiAwards,
    required this.obmepAwards,
    required this.searchTerm,
  });
}
