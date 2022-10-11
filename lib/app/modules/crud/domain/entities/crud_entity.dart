import 'package:equatable/equatable.dart';

class Crud extends Equatable {
  final int? id;
  final String name;
  final String description;

  const Crud({
    this.id,
    required this.name,
    required this.description,
  });

  @override
  List<Object?> get props => [id, name];
}
