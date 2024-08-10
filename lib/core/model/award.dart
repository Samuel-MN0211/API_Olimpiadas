import 'package:cloud_firestore/cloud_firestore.dart';

class Award {
  String name;
  String url;
  String olympiad;
  String? school;
  double score;
  String? city_state;
  String medal;
  DateTime timestamp;

  Award({
    required this.name,
    required this.url,
    required this.olympiad,
    this.school = '-',
    this.score = 0.0,
    this.city_state = '-',
    required this.medal,
    required this.timestamp
  });

  factory Award.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Award(
      name: data['name'] ?? '',
      url: data['url'] ?? '',
      olympiad: data['olympiad'] ?? '',
      school: data['school'],
      score: data['score']?.toDouble() ?? 0.0,
      city_state: data['city_state'],
      medal: data['medal'] ?? '',
      timestamp: data['timestamp'] ?? DateTime.timestamp()
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'url': url,
      'olympiad': olympiad,
      'school': school,
      'score': score,
      'city_state': city_state,
      'medal': medal,
      'timestamp': timestamp
    };
  }

  Map<String, dynamic> toFireStoreMap() {
    return {
      'Nome': name,
      'Link': url,
      'Olimpíada': olympiad,
      'Cidade/Estado': city_state,
      'Medalha': medal,
      'Pontuação': score,
      'Escola': school,
      'TimeStamp': DateTime.timestamp(),
    };
  }

  @override
  String toString() {
    return 'Award(name: $name, url: $url, olympiad: $olympiad, school: $school, score: $score, city_state: $city_state, medal: $medal, timestamp: $timestamp)';
  }

}
