part of 'models.dart';

class Theater extends Equatable {
  final String name;

  Theater(this.name);

  @override
  List<Object> get props => [name];
}

List<Theater> dummyTheater = [
  Theater('CGV 23 Paskal Hyper Square'),
  Theater('CGV Paris Van Java'),
  Theater('XXI Cihamelas Walk'),
  Theater('XXI Bandung Trade Center')
];
