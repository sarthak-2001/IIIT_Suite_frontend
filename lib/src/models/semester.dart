import 'package:flutter/cupertino.dart';
import 'package:iiit_suite/src/models/sgpa.dart';

class Semester{
  String cgpa;
  List<Sgpa> sgpa;

  Semester(
      {
      this.cgpa,
      this.sgpa
      });

  Map<String, dynamic> toMap(){
    return{
      'cgpa':cgpa,
      'sgpa':sgpa,
    };
  }

  static Semester fromMap(Map<String, dynamic> map){
    return Semester(
      cgpa: map['cgpa'],
      sgpa: map['sgpa'],
    );
  }
}