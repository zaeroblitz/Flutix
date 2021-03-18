part of 'pages.dart';

class TopUpPage extends StatefulWidget {
  final PageEvent pageEvent;

  TopUpPage(this.pageEvent);

  @override
  _TopUpPageState createState() => _TopUpPageState();
}

class _TopUpPageState extends State<TopUpPage> {
  TextEditingController amountController = TextEditingController(text: 'IDR 0');
  int selectedAmount = 0;

  @override
  Widget build(BuildContext context) {
    context
        .bloc<ThemeBloc>()
        .add(ChangeTheme(ThemeData(primaryColor: accentColor2)));
    double width =
        (MediaQuery.of(context).size.width - 2 * defaultMargin - 40) / 3;

    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(widget.pageEvent);
        return;
      },
      child: Scaffold(
        body: ListView(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  width: 24,
                  height: 24,
                  margin: EdgeInsets.only(top: 20, left: defaultMargin),
                  child: GestureDetector(
                    onTap: () async {
                      context.bloc<PageBloc>().add(widget.pageEvent);
                      return;
                    },
                    child: Icon(Icons.arrow_back),
                  ),
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Text('Top Up',
                        style: blackTextFont.copyWith(fontSize: 20)),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            Container(
              margin: EdgeInsets.symmetric(horizontal: defaultMargin),
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: amountController,
                    decoration: InputDecoration(
                      labelText: 'Amount',
                      labelStyle: greyTextFont,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: (text) {
                      String temp = '';

                      for (int i = 0; i < text.length; i++) {
                        temp += text.isDigit(i) ? text[i] : '';
                      }

                      setState(() {
                        selectedAmount = int.tryParse(temp);
                      });

                      amountController.text = NumberFormat.currency(
                        locale: 'id_ID',
                        symbol: 'IDR ',
                        decimalDigits: 0,
                      ).format(selectedAmount);

                      amountController.selection = TextSelection.fromPosition(
                          TextPosition(offset: amountController.text.length));
                    },
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      margin: EdgeInsets.only(top: 20, bottom: 14),
                      child: Text('Choose by Template', style: blackTextFont),
                    ),
                  ),
                  Wrap(
                    spacing: 20,
                    runSpacing: 14,
                    children: <Widget>[
                      makeMoneyCard(50000, width),
                      makeMoneyCard(100000, width),
                      makeMoneyCard(150000, width),
                      makeMoneyCard(200000, width),
                      makeMoneyCard(250000, width),
                      makeMoneyCard(500000, width),
                      makeMoneyCard(750000, width),
                      makeMoneyCard(1000000, width),
                      makeMoneyCard(5000000, width),
                    ],
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  SizedBox(
                    width: 250,
                    height: 46,
                    child: BlocBuilder<UserBloc, UserState>(
                      builder: (_, userState) => RaisedButton(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        color: (selectedAmount > 0)
                            ? Color(0xFF3E9D9D)
                            : Color(0xFFE4E4E4),
                        textColor: (selectedAmount > 0)
                            ? Colors.white
                            : Color(0xFFBEBEBE),
                        disabledColor: Color(0xFFE4E4E4),
                        child: Text('Top Up My Wallet'),
                        onPressed: (selectedAmount > 0)
                            ? () {
                                context.bloc<PageBloc>().add(GoToSuccessPage(
                                    null,
                                    FlutixTransaction(
                                        amount: selectedAmount,
                                        userId:
                                            (userState as UserLoaded).user.id,
                                        title: 'Top Up Wallet',
                                        subtitle:
                                            '${DateTime.now().dayName}, ${DateTime.now().day} ${DateTime.now().monthName} ${DateTime.now().year}',
                                        time: DateTime.now())));
                              }
                            : null,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  MoneyCard makeMoneyCard(int amount, double width) {
    return MoneyCard(
      amount: amount,
      width: width,
      isSelected: amount == selectedAmount,
      onTap: () {
        setState(() {
          if (selectedAmount != amount) {
            selectedAmount = amount;
          } else {
            selectedAmount = 0;
          }

          amountController.text = NumberFormat.currency(
            locale: 'id_ID',
            symbol: 'IDR ',
            decimalDigits: 0,
          ).format(selectedAmount);

          amountController.selection = TextSelection.fromPosition(
              TextPosition(offset: amountController.text.length));
        });
      },
    );
  }
}
