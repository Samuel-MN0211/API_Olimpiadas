class Award {
  String name;
  String url;
  String olympiad;
  String? school;
  double score;
  String? city_state;
  String medal;

  Award({
    required this.name,
    required this.url,
    required this.olympiad,
    this.school = '-',
    this.score = 0.0, 
    this.city_state = '-', 
    required this.medal,
  });

  @override
  String toString() {
    return 'Award(name: $name, url: $url, olympiad: $olympiad, school: $school, score: $score, city_state: $city_state, medal: $medal)';
  }

}
