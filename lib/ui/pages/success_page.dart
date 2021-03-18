part of 'pages.dart';

class SuccessPage extends StatelessWidget {
  final Ticket ticket;
  final FlutixTransaction transaction;

  SuccessPage(this.ticket, this.transaction);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return;
      },
      child: Scaffold(
        body: FutureBuilder(
          future: ticket != null
              ? processingTicketOrder(context)
              : processingTopUp(context),
          builder: (_, snapshot) => (snapshot.connectionState ==
                  ConnectionState.done)
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 150,
                      height: 150,
                      margin: EdgeInsets.only(bottom: 70),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage((ticket == null)
                                ? 'assets/ill_top_up.png'
                                : 'assets/ill_tickets.png')),
                      ),
                    ),
                    Text((ticket == null) ? 'Emmm Yummy' : 'Happy Watching',
                        style: blackTextFont.copyWith(fontSize: 20)),
                    SizedBox(height: 16),
                    Text(
                        (ticket == null)
                            ? 'You have successfully\ntop up the wallet'
                            : 'You have successfully\nbought the ticket',
                        textAlign: TextAlign.center,
                        style: blackTextFont.copyWith(
                            fontSize: 16, fontWeight: FontWeight.w300)),
                    Container(
                      height: 45,
                      width: 250,
                      margin: EdgeInsets.only(top: 70, bottom: 20),
                      child: RaisedButton(
                        elevation: 0,
                        color: mainColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                            (ticket == null) ? 'My Wallet' : 'My Tickets',
                            style: whiteTextFont),
                        onPressed: () {
                          if (ticket == null) {
                            context
                                .bloc<PageBloc>()
                                .add(GoToWalletPage(GoToMainPage()));
                          }
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Discover new movie? ',
                            style: greyTextFont.copyWith(
                                fontWeight: FontWeight.w400)),
                        GestureDetector(
                            child: Text('Back To Home', style: purpleTextFont),
                            onTap: () {
                              context.bloc<PageBloc>().add(GoToMainPage());
                            }),
                      ],
                    ),
                  ],
                )
              : Center(
                  child: SpinKitWave(
                    color: mainColor,
                    size: 50,
                  ),
                ),
        ),
      ),
    );
  }

  Future<void> processingTicketOrder(BuildContext context) async {
    context.bloc<UserBloc>().add(Purchase(ticket.totalPrice));
    context.bloc<TicketBloc>().add(BuyTicket(ticket, transaction.userId));

    await FlutixTransactionServices.saveTransaction(transaction);
  }

  Future<void> processingTopUp(BuildContext context) async {
    context.bloc<UserBloc>().add(TopUp(transaction.amount));

    await FlutixTransactionServices.saveTransaction(transaction);
  }
}
