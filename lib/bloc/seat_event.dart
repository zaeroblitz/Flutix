part of 'seat_bloc.dart';

abstract class SeatEvent extends Equatable {
  const SeatEvent();
}

class GetSeat extends SeatEvent {
  final int time;
  final int movieId;

  GetSeat(this.time, this.movieId);

  @override
  List<Object> get props => [time, movieId];
}
