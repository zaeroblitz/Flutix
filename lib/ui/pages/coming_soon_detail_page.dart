part of 'pages.dart';

class ComingSoonDetailPage extends StatelessWidget {
  final Movie movie;

  ComingSoonDetailPage(this.movie);

  @override
  Widget build(BuildContext context) {
    MovieDetail movieDetail;
    List<Credit> credits;

    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(GoToMainPage());
        return;
      },
      child: Scaffold(
        body: Stack(children: <Widget>[
          Container(
            color: accentColor1,
          ),
          SafeArea(
            child: Container(color: Colors.white),
          ),
          ListView(
            children: <Widget>[
              FutureBuilder(
                  future: MovieServices.getDetails(movie),
                  builder: (_, snapshot) {
                    if (snapshot.hasData) {
                      movieDetail = snapshot.data;
                      return Column(
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              // ** BACKDROP  **
                              Container(
                                height: 270,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(imageBaseURL +
                                        'w780' +
                                        movieDetail.backdropPath),
                                  ),
                                ),
                              ),
                              Container(
                                height: 270,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.white.withOpacity(0),
                                      Colors.white.withOpacity(1)
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                ),
                              ),

                              // ** BACK ICON **
                              Container(
                                width: 24,
                                height: 24,
                                margin: EdgeInsets.only(
                                    top: 20, left: defaultMargin),
                                padding: EdgeInsets.all(1),
                                child: GestureDetector(
                                  onTap: () async {
                                    context
                                        .bloc<PageBloc>()
                                        .add(GoToMainPage());
                                    return;
                                  },
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // ** TITLE **
                          Container(
                            margin: EdgeInsets.fromLTRB(
                                defaultMargin, 16, defaultMargin, 6),
                            child: Text(
                              movieDetail.title,
                              style: blackTextFont.copyWith(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),

                          // ** GENRES - LANGUAGE **
                          (snapshot.hasData)
                              ? Text(movieDetail.genresAndLanguage,
                                  style: greyTextFont.copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400))
                              : SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: SpinKitWave(
                                    color: accentColor3,
                                  )),
                          SizedBox(
                            height: 30,
                          ),

                          // ** Credits **
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: defaultMargin, bottom: 12),
                              child: Text('Cast & Crew',
                                  style: blackTextFont.copyWith(fontSize: 14)),
                            ),
                          ),
                          FutureBuilder(
                              future: MovieServices.getCredits(movie.id),
                              builder: (_, snapshot) {
                                if (snapshot.hasData) {
                                  credits = snapshot.data;
                                  return SizedBox(
                                    height: 125,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: credits.length,
                                      itemBuilder: (_, index) => Container(
                                        margin: EdgeInsets.only(
                                          left:
                                              (index == 0) ? defaultMargin : 0,
                                          right: (index == credits.length - 1)
                                              ? defaultMargin
                                              : 16,
                                        ),
                                        child: CreditCard(credits[index]),
                                      ),
                                    ),
                                  );
                                } else {
                                  return Center(
                                    child: SizedBox(
                                        height: 50,
                                        child: SpinKitWave(
                                          color: accentColor1,
                                        )),
                                  );
                                }
                              }),

                          // ** Storyline **
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              margin: EdgeInsets.fromLTRB(
                                  defaultMargin, 24, defaultMargin, 8),
                              child: Text('Storyline',
                                  style: blackTextFont.copyWith(fontSize: 14)),
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.fromLTRB(
                                defaultMargin, 0, defaultMargin, 30),
                            child: Text(
                              movieDetail.overview,
                              style: greyTextFont.copyWith(
                                  fontSize: 14, fontWeight: FontWeight.w400),
                            ),
                          ),
                          SizedBox(
                            height: defaultMargin,
                          ),
                        ],
                      );
                    } else {
                      return Center(
                        child: SizedBox(
                            height: 50,
                            child: SpinKitWave(
                              color: accentColor1,
                            )),
                      );
                    }
                  }),
            ],
          ),
        ]),
      ),
    );
  }
}
