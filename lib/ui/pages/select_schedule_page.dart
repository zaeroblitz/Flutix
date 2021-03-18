part of 'pages.dart';

class SelectSchedulePage extends StatefulWidget {
  final MovieDetail movieDetail;

  SelectSchedulePage(this.movieDetail);

  @override
  _SelectSchedulePageState createState() => _SelectSchedulePageState();
}

class _SelectSchedulePageState extends State<SelectSchedulePage> {
  List<DateTime> dates;
  DateTime selectedDate;
  Theater selectedTheater;
  int selectedTime;
  bool isValid = false;

  @override
  void initState() {
    super.initState();
    dates =
        List.generate(7, (index) => DateTime.now().add(Duration(days: index)));
    selectedDate = dates[0];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(GoToMovieDetailPage(widget.movieDetail));
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
                // ** Back Icon **
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    width: 24,
                    height: 24,
                    margin: EdgeInsets.only(top: 20, left: defaultMargin),
                    padding: EdgeInsets.all(1),
                    child: GestureDetector(
                      onTap: () async {
                        context
                            .bloc<PageBloc>()
                            .add(GoToMovieDetailPage(widget.movieDetail));
                        return;
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),

                // ** Choose Date **
                Container(
                  margin:
                      EdgeInsets.fromLTRB(defaultMargin, 20, defaultMargin, 16),
                  child: Text('Choose Date',
                      style: blackTextFont.copyWith(fontSize: 20)),
                ),
                Container(
                  height: 90,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: dates.length,
                    itemBuilder: (_, index) => Container(
                      margin: EdgeInsets.only(
                        left: (index == 0) ? defaultMargin : 16,
                        right: (index == dates.length - 1) ? defaultMargin : 0,
                      ),
                      child: DateCard(
                        dates[index],
                        isSelected: selectedDate == dates[index],
                        onTap: () {
                          setState(() {
                            selectedDate = dates[index];
                          });
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 24),

                // ** Choose Theater & Time **
                generateTimeTable(),

                // ** Button **
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.topCenter,
                  child: BlocBuilder<UserBloc, UserState>(
                    builder: (_, userState) => FloatingActionButton(
                      elevation: 0,
                      backgroundColor: isValid ? mainColor : Color(0xFFE4E4E4),
                      child: Icon(
                        Icons.arrow_forward,
                        color: isValid ? Colors.white : Color(0xFFBEBEBE),
                      ),
                      onPressed: () {
                        if (isValid) {
                          context.bloc<PageBloc>().add(GoToSelectSeatPage(
                              Ticket(
                                  widget.movieDetail,
                                  selectedTheater,
                                  DateTime(
                                      selectedDate.year,
                                      selectedDate.month,
                                      selectedDate.day,
                                      selectedTime),
                                  randomAlphaNumeric(12),
                                  null,
                                  (userState as UserLoaded).user.name,
                                  null)));
                          // context.bloc<SeatBloc>().add(GetSeat(DateTime(
                          //         selectedDate.year,
                          //         selectedDate.month,
                          //         selectedDate.day,
                          //         selectedTime)
                          //     .microsecondsSinceEpoch), widget.movieDetail.id);

                          context.bloc<SeatBloc>().add(GetSeat(
                              DateTime(selectedDate.year, selectedDate.month,
                                      selectedDate.day, selectedTime)
                                  .microsecondsSinceEpoch,
                              widget.movieDetail.id));
                        }
                      },
                    ),
                  ),
                ),

                SizedBox(height: 24),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Column generateTimeTable() {
    List<int> schedule = List.generate(7, (index) => 10 + index * 2);
    List<Widget> widgets = [];

    for (var theater in dummyTheater) {
      widgets.add(Container(
          margin: EdgeInsets.fromLTRB(defaultMargin, 0, defaultMargin, 16),
          child:
              Text(theater.name, style: blackTextFont.copyWith(fontSize: 20))));

      widgets.add(Container(
        height: 50,
        margin: EdgeInsets.only(bottom: 30),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: schedule.length,
          itemBuilder: (_, index) => Container(
            margin: EdgeInsets.only(
              left: index == 0 ? defaultMargin : 0,
              right: index == schedule.length - 1 ? defaultMargin : 16,
            ),
            child: SelectableBox(
              '${schedule[index]}:00',
              height: 50,
              isSelected:
                  selectedTheater == theater && selectedTime == schedule[index],
              isEnabled: schedule[index] > DateTime.now().hour ||
                  selectedDate.day != DateTime.now().day,
              onTap: () {
                (schedule[index] > DateTime.now().hour ||
                        selectedDate.day != DateTime.now().day)
                    ? setState(() {
                        selectedTheater = theater;
                        selectedTime = schedule[index];
                        if (selectedTheater != null && selectedTime != null) {
                          isValid = true;
                        }
                      })
                    : isValid = false;
              },
            ),
          ),
        ),
      ));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }
}
