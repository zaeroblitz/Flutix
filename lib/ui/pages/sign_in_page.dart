part of 'pages.dart';

class SignInPage extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isEmailValid = false;
  bool isPasswordValid = false;
  bool isSigninIn = false;

  @override
  Widget build(BuildContext context) {
    context
        .bloc<ThemeBloc>()
        .add(ChangeTheme(ThemeData().copyWith(primaryColor: accentColor2)));

    return WillPopScope(
      onWillPop: () {
        context.bloc<PageBloc>().add(GoToSplashPage());
        return;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: ListView(
            children: <Widget>[
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      height: 70,
                      child: Image.asset('assets/logo.png'),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 70, bottom: 40),
                      child: Text(
                        'Welcome Back,\nExplorer!',
                        style: blackTextFont.copyWith(fontSize: 20),
                      ),
                    ),
                    TextField(
                      onChanged: (email) {
                        setState(() {
                          isEmailValid = EmailValidator.validate(email);
                        });
                      },
                      controller: emailController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          labelText: 'Email Address',
                          hintText: 'Email Address'),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextField(
                      onChanged: (password) {
                        setState(() {
                          isPasswordValid = password.length >= 6;
                        });
                      },
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          labelText: 'Password',
                          hintText: 'Password'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          'Forgot Password? ',
                          style: greyTextFont.copyWith(
                              fontSize: 12, fontWeight: FontWeight.w400),
                        ),
                        Text(
                          'Get Now',
                          style: purpleTextFont.copyWith(fontSize: 12),
                        ),
                      ],
                    ),
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(top: 30, bottom: 50),
                        width: 50,
                        height: 50,
                        child: (isSigninIn)
                            ? SpinKitWanderingCubes(
                                color: mainColor,
                              )
                            : FloatingActionButton(
                                elevation: 0,
                                backgroundColor:
                                    (isEmailValid && isPasswordValid)
                                        ? mainColor
                                        : Color(0xFFE4E4E4),
                                child: Icon(
                                  Icons.arrow_forward,
                                  color: (isEmailValid && isPasswordValid)
                                      ? Colors.white
                                      : Color(0xFFBEBEBE),
                                ),
                                onPressed: (isEmailValid && isPasswordValid)
                                    ? () async {
                                        setState(() {
                                          isSigninIn = true;
                                        });

                                        SignInSignUpResult result =
                                            await AuthServices.signIn(
                                                emailController.text,
                                                passwordController.text);

                                        if (result.user == null) {
                                          setState(() {
                                            isSigninIn = false;
                                          });

                                          Flushbar(
                                            duration: Duration(seconds: 4),
                                            message: result.message,
                                            backgroundColor: Colors.pink,
                                            flushbarPosition:
                                                FlushbarPosition.TOP,
                                          )..show(context);
                                        }
                                      }
                                    : null,
                              ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Start Fresh now? ',
                          style: greyTextFont.copyWith(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                        GestureDetector(
                          onTap: () async {
                            context
                                .bloc<PageBloc>()
                                .add(GoToRegistrationPage(RegistrationData()));
                          },
                          child: Text('Sign Up',
                              style: purpleTextFont.copyWith(
                                fontSize: 14,
                              )),
                        ),
                      ],
                    ),
                  ])
            ],
          ),
        ),
      ),
    );
  }
}
