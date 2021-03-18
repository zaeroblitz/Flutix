part of 'seat_bloc.dart';

class SeatState extends Equatable {
  final List<String> seats;

  const SeatState(this.seats);

  @override
  List<Object> get props => [seats];
}
