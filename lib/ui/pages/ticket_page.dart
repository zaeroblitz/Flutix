part of 'pages.dart';

class TicketPage extends StatefulWidget {
  final bool isExpired;

  TicketPage({this.isExpired = false});

  @override
  _TicketPageState createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  bool isExpired;

  @override
  void initState() {
    super.initState();
    isExpired = widget.isExpired;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // ** Content **
          BlocBuilder<TicketBloc, TicketState>(
            builder: (_, ticketState) => Container(
              margin: EdgeInsets.symmetric(horizontal: defaultMargin),
              padding: EdgeInsets.only(bottom: 100),
              child: TicketViewer(isExpired
                  ? ticketState.tickets
                      .where(
                          (ticket) => ticket.dateTime.isBefore(DateTime.now()))
                      .toList()
                  : ticketState.tickets
                      .where(
                          (ticket) => !ticket.dateTime.isBefore(DateTime.now()))
                      .toList()),
            ),
          ),

          // ** Header **
          Container(
            height: 113,
            color: accentColor1,
          ),
          SafeArea(
            child: ClipPath(
              clipper: HeaderClipper(),
              child: Container(
                height: 113,
                color: accentColor1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      child: Text('My Tickets',
                          style: whiteTextFont.copyWith(fontSize: 20)),
                      margin: EdgeInsets.only(left: defaultMargin, bottom: 32),
                    ),
                    Row(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isExpired = !isExpired;
                                });
                              },
                              child: Text('Newest',
                                  style: whiteTextFont.copyWith(
                                      fontSize: 16,
                                      color: !isExpired
                                          ? Colors.white
                                          : Color(0xFF6F678E))),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width / 2,
                                height: 4,
                                color: !isExpired
                                    ? accentColor2
                                    : Colors.transparent),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isExpired = !isExpired;
                                });
                              },
                              child: Text('Oldest',
                                  style: whiteTextFont.copyWith(
                                      fontSize: 16,
                                      color: isExpired
                                          ? Colors.white
                                          : Color(0xFF6F678E))),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width / 2,
                                height: 4,
                                color: isExpired
                                    ? accentColor2
                                    : Colors.transparent),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0, size.height - 20);
    path.quadraticBezierTo(0, size.height, 20, size.height);
    path.lineTo(size.width - 20, size.height);
    path.quadraticBezierTo(
        size.width, size.height, size.width, size.height - 20);
    path.lineTo(size.width, 0);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class TicketViewer extends StatelessWidget {
  final List<Ticket> tickets;

  TicketViewer(this.tickets);

  @override
  Widget build(BuildContext context) {
    var sortedTickets = tickets;
    sortedTickets.sort(
        (ticket1, ticket2) => ticket1.dateTime.compareTo(ticket2.dateTime));

    return ListView.builder(
      itemCount: sortedTickets.length,
      itemBuilder: (_, index) {
        return GestureDetector(
          onTap: () {
            context
                .bloc<PageBloc>()
                .add(GoToTicketDetailPage(sortedTickets[index]));
          },
          child: Container(
            margin: EdgeInsets.only(top: index == 0 ? 133 : 20),
            child: Row(
              children: <Widget>[
                Container(
                  width: 70,
                  height: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(imageBaseURL +
                          'w500' +
                          sortedTickets[index].movieDetail.posterPath),
                    ),
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Container(
                  width: MediaQuery.of(context).size.width -
                      2 * defaultMargin -
                      70 -
                      16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(sortedTickets[index].movieDetail.title,
                          style: blackTextFont.copyWith(fontSize: 20),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis),
                      SizedBox(height: 6),
                      Text(sortedTickets[index].movieDetail.genresAndLanguage,
                          style: greyTextFont.copyWith(
                              fontSize: 12, fontWeight: FontWeight.w400)),
                      SizedBox(height: 6),
                      Text(sortedTickets[index].theater.name,
                          style: greyTextFont.copyWith(
                              fontSize: 12, fontWeight: FontWeight.w400)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
