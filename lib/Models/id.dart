import 'dart:async';

class Id {
  int? _id;
  int? get id => _id;
  set id(int? value) => _id = value;

  Id({
    int? id,
  }) : _id = id;

  factory Id.fromJson(Map<String, dynamic> json) {
    return Id(
      id: json['id'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': _id,
    };
  }
}