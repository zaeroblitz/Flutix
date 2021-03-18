part of 'pages.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 130,
              height: 136,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/logo.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 70, bottom: 16),
              child: Text(
                'New Experience',
                style: blackTextFont.copyWith(fontSize: 20),
              ),
            ),
            Text(
              'Watch a new movie much\neasier than any before',
              style: greyTextFont.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w300,
              ),
              textAlign: TextAlign.center,
            ),
            Container(
              width: 250,
              height: 45,
              margin: EdgeInsets.only(top: 70, bottom: 20),
              child: RaisedButton(
                onPressed: () {
                  context
                      .bloc<PageBloc>()
                      .add(GoToRegistrationPage(RegistrationData()));
                },
                color: mainColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: Text('Get Started',
                    style: whiteTextFont.copyWith(fontSize: 16)),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Already have an account?',
                    style: greyTextFont.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                    )),
                GestureDetector(
                  onTap: () {
                    context.bloc<PageBloc>().add(GoToLoginPage());
                  },
                  child: Text(
                    'Sign In',
                    style: purpleTextFont,
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
