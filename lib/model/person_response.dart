import 'dart:convert';

import 'package:movie_app/model/person.dart';

class PersonResponse {
  final List<Person> persons;
  final String error;
  PersonResponse({
    required this.persons,
    required this.error,
  });


  Map<String, dynamic> toMap() {
    return {
      'persons': persons.map((x) => x.toMap()).toList(),
      'error': error,
    };
  }

  factory PersonResponse.fromMap(Map<String, dynamic> map) {
    return PersonResponse(
      persons: List<Person>.from(map['persons']?.map((x) => Person.fromMap(x))),
      error: map['error'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PersonResponse.fromJson(String source) => PersonResponse.fromMap(json.decode(source));


 
  PersonResponse.withError(
    String errorvalue,
  )   : persons = [],
        error = errorvalue;
}
