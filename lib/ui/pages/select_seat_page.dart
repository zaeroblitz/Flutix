part of 'pages.dart';

class SelectSeatPage extends StatefulWidget {
  final Ticket ticket;

  SelectSeatPage(this.ticket);

  @override
  _SelectSeatPageState createState() => _SelectSeatPageState();
}

class _SelectSeatPageState extends State<SelectSeatPage> {
  // Future<List<String>> getBoughtSeats() async {
  //   List<String> boughtSeats = await TicketServices.getSeats(
  //       widget.ticket.dateTime.microsecondsSinceEpoch);
  //   return boughtSeats;
  // }

  List<String> selectedSeats = [];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context
            .bloc<PageBloc>()
            .add(GoToSelectSchedulePage(widget.ticket.movieDetail));

        return;
      },
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(color: accentColor1),
            SafeArea(child: Container(color: Colors.white)),
            ListView(
              children: [
                Column(
                  children: <Widget>[
                    // ** Back Icon **
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            margin:
                                EdgeInsets.only(top: 20, left: defaultMargin),
                            padding: EdgeInsets.all(1),
                            child: GestureDetector(
                              onTap: () async {
                                context.bloc<PageBloc>().add(
                                    GoToSelectSchedulePage(
                                        widget.ticket.movieDetail));
                                return;
                              },
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(top: 20, right: defaultMargin),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: Text(widget.ticket.movieDetail.title,
                                      style:
                                          blackTextFont.copyWith(fontSize: 20),
                                      maxLines: 2,
                                      overflow: TextOverflow.clip),
                                ),
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(imageBaseURL +
                                          'w154' +
                                          widget.ticket.movieDetail.posterPath),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),

                    // ** Cinema Screen **
                    Container(
                      margin: EdgeInsets.only(top: 30),
                      width: 277,
                      height: 84,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/screen.png')),
                      ),
                    ),

                    // ** Choose Seats **
                    generateSeats(),

                    // ** Button **
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.topCenter,
                      child: BlocBuilder<UserBloc, UserState>(
                        builder: (_, userState) => FloatingActionButton(
                          elevation: 0,
                          backgroundColor: selectedSeats.length > 0
                              ? mainColor
                              : Color(0xFFE4E4E4),
                          child: Icon(
                            Icons.arrow_forward,
                            color: selectedSeats.length > 0
                                ? Colors.white
                                : Color(0xFFBEBEBE),
                          ),
                          onPressed: (selectedSeats.length > 0)
                              ? () {
                                  context.bloc<PageBloc>().add(GoToCheckoutPage(
                                          widget.ticket.copyWith(
                                        seats: selectedSeats,
                                      )));
                                }
                              : null,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Column generateSeats() {
    List<int> numberOfSeats = [3, 5, 5, 5, 5];
    List<Widget> widgets = [];
    String seatNumber;

    for (int i = 0; i < numberOfSeats.length; i++) {
      widgets.add(
        BlocBuilder<SeatBloc, SeatState>(
          builder: (_, seatState) => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
                numberOfSeats[i],
                (index) => Padding(
                      padding: EdgeInsets.only(
                        right: (index == numberOfSeats[i] - 1) ? 0 : 16,
                        bottom: 16,
                      ),
                      child: SelectableBox(
                        '${String.fromCharCode(i + 65)}${index + 1}',
                        width: 40,
                        height: 40,
                        textStyle: blackTextFont.copyWith(
                            fontSize: 16, fontWeight: FontWeight.w400),
                        onTap: () {
                          if (index != 0) {
                            seatNumber =
                                '${String.fromCharCode(i + 65)}${index + 1}';
                            setState(() {
                              if (selectedSeats.contains(seatNumber)) {
                                selectedSeats.remove(seatNumber);
                              } else {
                                selectedSeats.add(seatNumber);
                              }
                            });
                          }
                        },
                        isSelected: selectedSeats.contains(
                            '${String.fromCharCode(i + 65)}${index + 1}'),
                        isEnabled: index != 0,
                      ),
                    )),
          ),
        ),
      );
    }

    return Column(
      children: widgets,
    );
  }
}
