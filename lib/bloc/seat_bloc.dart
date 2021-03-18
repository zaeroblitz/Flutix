import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bwa_flutix/services/services.dart';
import 'package:equatable/equatable.dart';

part 'seat_event.dart';
part 'seat_state.dart';

class SeatBloc extends Bloc<SeatEvent, SeatState> {
  @override
  SeatState get initialState => SeatState([]);

  @override
  Stream<SeatState> mapEventToState(
    SeatEvent event,
  ) async* {
    if (event is GetSeat) {
      List<String> seats =
          await TicketServices.getSeats(event.time, event.movieId);

      yield SeatState(seats);
    }
  }
}
