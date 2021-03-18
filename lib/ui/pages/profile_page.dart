part of 'pages.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(GoToMainPage());
        return;
      },
      child: Scaffold(
        body: ListView(
          children: <Widget>[
            BlocBuilder<UserBloc, UserState>(
              builder: (_, userState) => Column(
                children: <Widget>[
                  // ** Back Icon **
                  Container(
                    margin: EdgeInsets.only(top: 20, left: defaultMargin),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: GestureDetector(
                        onTap: () async {
                          context.bloc<PageBloc>().add(GoToMainPage());
                          return;
                        },
                        child: Container(
                          width: 24,
                          height: 24,
                          child: Icon(Icons.arrow_back),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),

                  // ** User Information **
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: (userState as UserLoaded)
                                          .user
                                          .profilePicture !=
                                      ''
                                  ? NetworkImage((userState as UserLoaded)
                                      .user
                                      .profilePicture)
                                  : AssetImage('assets/user_pic.png'),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text((userState as UserLoaded).user.name,
                            style: blackTextFont.copyWith(fontSize: 18)),
                        Text((userState as UserLoaded).user.email,
                            style: greyTextFont.copyWith(
                                fontSize: 16, fontWeight: FontWeight.w300)),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),

                  // ** Edit Profile
                  Container(
                    margin: EdgeInsets.only(left: defaultMargin, bottom: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            context.bloc<PageBloc>().add(GoToEditProfilePage(
                                (userState as UserLoaded).user));
                          },
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                        'assets/account_circle_24px_outlined.png'),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Text('Edit Profile', style: blackTextFont),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        DottedLine(
                          dashColor: Color(0xFFE4E4E4),
                          dashRadius: 2.0,
                          dashGapLength: 8.0,
                        ),
                      ],
                    ),
                  ),

                  // ** User Balance **
                  Container(
                    margin: EdgeInsets.only(left: defaultMargin, bottom: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            context
                                .bloc<PageBloc>()
                                .add(GoToWalletPage(GoToProfilePage()));
                          },
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                        'assets/account_balance_wallet_24px_outlined.png'),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Text('My Wallet', style: blackTextFont),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        DottedLine(
                          dashColor: Color(0xFFE4E4E4),
                          dashRadius: 2.0,
                          dashGapLength: 8.0,
                        ),
                      ],
                    ),
                  ),

                  // ** Change Language **
                  Container(
                    margin: EdgeInsets.only(left: defaultMargin, bottom: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                      'assets/translate_24px_outlined.png'),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Text('Change Language', style: blackTextFont),
                          ],
                        ),
                        SizedBox(height: 10),
                        DottedLine(
                          dashColor: Color(0xFFE4E4E4),
                          dashRadius: 2.0,
                          dashGapLength: 8.0,
                        ),
                      ],
                    ),
                  ),

                  // ** Help Centre **
                  Container(
                    margin: EdgeInsets.only(left: defaultMargin, bottom: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                      'assets/verified_user_24px_outlined.png'),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Text('Help Centre', style: blackTextFont),
                          ],
                        ),
                        SizedBox(height: 10),
                        DottedLine(
                          dashColor: Color(0xFFE4E4E4),
                          dashRadius: 2.0,
                          dashGapLength: 8.0,
                        ),
                      ],
                    ),
                  ),

                  // ** Rate App **
                  Container(
                    margin: EdgeInsets.only(left: defaultMargin, bottom: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                      'assets/thumb_up_24px_outlined.png'),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Text('Rate Flutix App', style: blackTextFont),
                          ],
                        ),
                        SizedBox(height: 10),
                        DottedLine(
                          dashColor: Color(0xFFE4E4E4),
                          dashRadius: 2.0,
                          dashGapLength: 8.0,
                        ),
                      ],
                    ),
                  ),

                  // ** Sign Out **
                  Container(
                    margin: EdgeInsets.only(left: defaultMargin, bottom: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () async {
                            await AuthServices.signOut();
                          },
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image:
                                        AssetImage('assets/btn_del_photo.png'),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Text('Sign Out', style: blackTextFont),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        DottedLine(
                          dashColor: Color(0xFFE4E4E4),
                          dashRadius: 2.0,
                          dashGapLength: 8.0,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
