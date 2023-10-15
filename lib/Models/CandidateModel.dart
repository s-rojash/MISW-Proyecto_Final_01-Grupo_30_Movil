import 'dart:async';

class Candidate {
  final int id;
  final String firstName;
  final String lastName;
  final String email;

  const Candidate({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  factory Candidate.fromJson(Map<String, dynamic> json) {
    return Candidate(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
    );
  }
}