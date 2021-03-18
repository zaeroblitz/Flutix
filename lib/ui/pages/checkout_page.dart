part of 'pages.dart';

class CheckoutPage extends StatefulWidget {
  final Ticket ticket;

  CheckoutPage(this.ticket);

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
    int total = 26500 * widget.ticket.seats.length;

    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(GoToSelectSeatPage(widget.ticket));
        return;
      },
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              color: accentColor1,
            ),
            SafeArea(
              child: Container(
                color: Colors.white,
              ),
            ),
            ListView(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    // ** Back Icon **
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          margin: EdgeInsets.only(top: 20, left: defaultMargin),
                          padding: EdgeInsets.all(1),
                          child: GestureDetector(
                            onTap: () async {
                              context
                                  .bloc<PageBloc>()
                                  .add(GoToSelectSeatPage(widget.ticket));
                              return;
                            },
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    BlocBuilder<UserBloc, UserState>(builder: (_, userState) {
                      User user = (userState as UserLoaded).user;

                      return Column(
                        children: <Widget>[
                          // ** Page Title **
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 20),
                            child: Text(
                              'Checkout\nMovie',
                              style: blackTextFont.copyWith(fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                          ),

                          // ** Movie Description **
                          Row(
                            children: <Widget>[
                              Container(
                                width: 70,
                                height: 90,
                                margin: EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(imageBaseURL +
                                        'w342' +
                                        widget.ticket.movieDetail.posterPath),
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width: MediaQuery.of(context).size.width -
                                        2 * defaultMargin -
                                        70 -
                                        20,
                                    child: Text(widget.ticket.movieDetail.title,
                                        style: blackTextFont.copyWith(
                                            fontSize: 18),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width -
                                        2 * defaultMargin -
                                        70 -
                                        20,
                                    margin: EdgeInsets.symmetric(vertical: 6),
                                    child: Text(
                                        widget.ticket.movieDetail
                                            .genresAndLanguage,
                                        style: greyTextFont.copyWith(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400)),
                                  ),
                                  RatingStars(
                                    alignment: MainAxisAlignment.start,
                                    voteAverage:
                                        widget.ticket.movieDetail.voteAverage,
                                    textColor: accentColor3,
                                  )
                                ],
                              ),
                            ],
                          ),

                          // ** Ticket Detail **
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: defaultMargin, vertical: 20),
                            child: Divider(
                              color: Color(0xFFE4E4E4),
                              thickness: 1,
                            ),
                          ),

                          // ** ID Order **
                          Container(
                            margin: EdgeInsets.fromLTRB(
                                defaultMargin, 0, defaultMargin, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('ID Order',
                                    style: greyTextFont.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400)),
                                Text(widget.ticket.bookingCode,
                                    style: blackTextFont.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400)),
                              ],
                            ),
                          ),

                          //** Cinema  **
                          Container(
                            margin: EdgeInsets.fromLTRB(
                                defaultMargin, 0, defaultMargin, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('Cinema',
                                    style: greyTextFont.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400)),
                                Container(
                                  width: (MediaQuery.of(context).size.width -
                                          2 * defaultMargin) /
                                      2,
                                  child: Text(widget.ticket.theater.name,
                                      style: blackTextFont.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.end),
                                ),
                              ],
                            ),
                          ),

                          // ** Date & Time **
                          Container(
                            margin: EdgeInsets.fromLTRB(
                                defaultMargin, 0, defaultMargin, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('Date & Time',
                                    style: greyTextFont.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400)),
                                Text(widget.ticket.dateTime.dateAndTime,
                                    style: blackTextFont.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400)),
                              ],
                            ),
                          ),

                          // ** Seat Number **
                          Container(
                            margin: EdgeInsets.fromLTRB(
                                defaultMargin, 0, defaultMargin, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('Seat Number',
                                    style: greyTextFont.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400)),
                                Text(widget.ticket.seatsInString,
                                    style: blackTextFont.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400)),
                              ],
                            ),
                          ),

                          // ** Price **
                          Container(
                            margin: EdgeInsets.fromLTRB(
                                defaultMargin, 0, defaultMargin, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('Price',
                                    style: greyTextFont.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400)),
                                Text(
                                    'IDR 25.000 x ${widget.ticket.seats.length}',
                                    style: blackTextFont.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400)),
                              ],
                            ),
                          ),

                          // ** Fee **
                          Container(
                            margin: EdgeInsets.fromLTRB(
                                defaultMargin, 0, defaultMargin, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('Fee',
                                    style: greyTextFont.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400)),
                                Text(
                                    'IDR 1.500 x ${widget.ticket.seats.length}',
                                    style: blackTextFont.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400)),
                              ],
                            ),
                          ),

                          // ** Total Price **
                          Container(
                            margin: EdgeInsets.fromLTRB(
                                defaultMargin, 0, defaultMargin, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('Total Price',
                                    style: greyTextFont.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400)),
                                Text(
                                    NumberFormat.currency(
                                            locale: 'id',
                                            symbol: 'IDR ',
                                            decimalDigits: 0)
                                        .format(total),
                                    style: blackTextFont.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: defaultMargin, vertical: 20),
                            child: Divider(
                              color: Color(0xFFE4E4E4),
                              thickness: 1,
                            ),
                          ),

                          // ** Your Balance **
                          Container(
                            margin: EdgeInsets.fromLTRB(
                                defaultMargin, 0, defaultMargin, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('Total Price',
                                    style: greyTextFont.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400)),
                                Text(
                                    NumberFormat.currency(
                                            locale: 'id',
                                            symbol: 'IDR ',
                                            decimalDigits: 0)
                                        .format(total),
                                    style: blackTextFont.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: (user.balance > total)
                                          ? Color(0xFF3E9D9D)
                                          : Colors.redAccent,
                                    )),
                              ],
                            ),
                          ),

                          Container(
                            width: 225,
                            margin: EdgeInsets.symmetric(
                                horizontal: defaultMargin, vertical: 10),
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              color: (user.balance > total)
                                  ? Color(0xFF3E9D9D)
                                  : mainColor,
                              child: Text(
                                (user.balance > total)
                                    ? 'Checkout Now'
                                    : 'Top Up My Wallet',
                                style: whiteTextFont.copyWith(fontSize: 16),
                              ),
                              onPressed: () {
                                if (user.balance >= total) {
                                  FlutixTransaction transaction =
                                      FlutixTransaction(
                                          userId: user.id,
                                          title:
                                              widget.ticket.movieDetail.title,
                                          subtitle: widget.ticket.theater.name,
                                          time: DateTime.now(),
                                          picture: widget
                                              .ticket.movieDetail.posterPath,
                                          amount: -total);

                                  context.bloc<PageBloc>().add(GoToSuccessPage(
                                      widget.ticket.copyWith(totalPrice: total),
                                      transaction));
                                } else {}
                              },
                            ),
                          ),

                          SizedBox(height: 10),
                        ],
                      );
                    }),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
