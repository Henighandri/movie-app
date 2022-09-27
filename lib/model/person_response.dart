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
      persons:map['results']==null?[]: List<Person>.from(map['results']?.map((x) => Person.fromMap(x))),
      error: map['error'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PersonResponse.fromJson(dynamic source) => PersonResponse.fromMap(source);


 
  PersonResponse.withError(
    String errorvalue,
  )   : persons = [],
        error = errorvalue;
}
