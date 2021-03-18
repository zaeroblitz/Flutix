part of 'pages.dart';

class TicketDetailPage extends StatelessWidget {
  final Ticket ticket;

  TicketDetailPage(this.ticket);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(GoToMainPage(
            bottomNavBarIndex: 1,
            isExpired: ticket.dateTime.isBefore(DateTime.now())));
        return;
      },
      child: Scaffold(
        backgroundColor: Color(0xFFE4E4E4),
        body: ListView(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 20, left: defaultMargin),
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topLeft,
                        child: GestureDetector(
                          onTap: () {
                            context.bloc<PageBloc>().add(GoToMainPage(
                                bottomNavBarIndex: 1,
                                isExpired:
                                    ticket.dateTime.isBefore(DateTime.now())));
                          },
                          child: Icon(Icons.arrow_back),
                        ),
                      ),
                      Center(
                        child: Text('Ticket Details',
                            style: blackTextFont.copyWith(
                                fontSize: 20, fontWeight: FontWeight.w500)),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.fromLTRB(defaultMargin, 20, defaultMargin, 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: <Widget>[
                      // ** Poster **
                      Container(
                        height: 170,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16)),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(imageBaseURL +
                                'w500' +
                                ticket.movieDetail.posterPath),
                          ),
                        ),
                      ),

                      Container(
                        width: MediaQuery.of(context).size.width -
                            4 * defaultMargin,
                        margin: EdgeInsets.fromLTRB(20, 16, 8, 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            // ** Title **
                            Text(
                              ticket.movieDetail.title,
                              style: blackTextFont.copyWith(fontSize: 18),
                            ),
                            SizedBox(height: 6),

                            // ** Genres & Language **
                            Text(ticket.movieDetail.genresAndLanguage),
                            SizedBox(height: 6),

                            // ** Rating Star **
                            RatingStars(
                              alignment: MainAxisAlignment.start,
                              voteAverage: ticket.movieDetail.voteAverage,
                              textColor: Color(0xFFADADAD),
                              fontSize: 12,
                            ),
                            SizedBox(height: 16),

                            // ** Cinema **
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('Cinema', style: greyTextFont),
                                Container(
                                  width: (MediaQuery.of(context).size.width -
                                          4 * defaultMargin) /
                                      2,
                                  child: Text(ticket.theater.name,
                                      textAlign: TextAlign.end),
                                ),
                              ],
                            ),
                            SizedBox(height: 6),

                            // ** Date & Time **
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('Date & Time', style: greyTextFont),
                                Text(ticket.dateTime.dateAndTime),
                              ],
                            ),
                            SizedBox(height: 6),

                            // ** Seat Number **
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('Seat Number', style: greyTextFont),
                                Text(ticket.seatsInString),
                              ],
                            ),
                            SizedBox(height: 6),

                            // ** ID Order **
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('ID Order', style: greyTextFont),
                                Text(ticket.bookingCode),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: defaultMargin),
                  child: DottedLine(
                    dashColor: Colors.white,
                    dashGapLength: 8.0,
                    dashRadius: 8,
                    lineThickness: 2.0,
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.fromLTRB(defaultMargin, 4, defaultMargin, 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Container(
                    margin:
                        EdgeInsets.fromLTRB(defaultMargin, 8, defaultMargin, 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Name', style: greyTextFont),
                            Text(ticket.name),
                            SizedBox(height: 8),
                            Text('Paid', style: greyTextFont),
                            Text(NumberFormat.currency(
                                    locale: 'id',
                                    symbol: 'Rp ',
                                    decimalDigits: 0)
                                .format(ticket.totalPrice)),
                          ],
                        ),
                        QrImage(
                          data: 'https://www.google.com/',
                          version: 6,
                          size: 100.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
