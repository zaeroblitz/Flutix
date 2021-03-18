part of 'pages.dart';

class AccountConfirmationPage extends StatefulWidget {
  final RegistrationData registrationData;

  AccountConfirmationPage(this.registrationData);

  @override
  _AccountConfirmationPageState createState() =>
      _AccountConfirmationPageState();
}

class _AccountConfirmationPageState extends State<AccountConfirmationPage> {
  bool isSigningUp = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context
            .bloc<PageBloc>()
            .add(GoToPreferencePage(widget.registrationData));
        return;
      },
      child: Scaffold(
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 20, bottom: 90),
                    height: 56,
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () {
                              context.bloc<PageBloc>().add(
                                  GoToPreferencePage(widget.registrationData));
                            },
                            child: Icon(Icons.arrow_back, color: Colors.black),
                          ),
                        ),
                        Center(
                            child: Text(
                          'Confirm\nNew Account',
                          style: blackTextFont.copyWith(fontSize: 20),
                          textAlign: TextAlign.center,
                        )),
                      ],
                    ),
                  ),
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: (widget.registrationData.profileImage == null)
                            ? AssetImage('assets/user_pic.png')
                            : FileImage(widget.registrationData.profileImage),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Text('Welcome',
                      style: blackTextFont.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                      textAlign: TextAlign.center),
                  Text('${widget.registrationData.name}',
                      style: blackTextFont.copyWith(fontSize: 20),
                      textAlign: TextAlign.center),
                  SizedBox(
                    height: 110,
                  ),
                  (isSigningUp)
                      ? SpinKitWanderingCubes(
                          color: Color(0xFF3E9D9D),
                        )
                      : Container(
                          width: 250,
                          height: 45,
                          child: RaisedButton(
                            color: Color(0xFF3E9D9D),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              'Create My Account',
                              style: whiteTextFont.copyWith(fontSize: 16),
                            ),
                            onPressed: () async {
                              setState(() {
                                isSigningUp = true;
                              });

                              imageFileToUpload =
                                  widget.registrationData.profileImage;

                              SignInSignUpResult result =
                                  await AuthServices.signUp(
                                      widget.registrationData.email,
                                      widget.registrationData.password,
                                      widget.registrationData.name,
                                      widget.registrationData.selectedGenres,
                                      widget.registrationData.selectedLanguage);

                              if (result == null) {
                                setState(() {
                                  isSigningUp = false;
                                });

                                Flushbar(
                                  duration: Duration(milliseconds: 1500),
                                  flushbarPosition: FlushbarPosition.TOP,
                                  backgroundColor: Color(0xFFFF5C83),
                                  message: result.message,
                                )..show(context);
                              }
                            },
                          ),
                        ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
