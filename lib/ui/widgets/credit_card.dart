part of 'widgets.dart';

class CreditCard extends StatelessWidget {
  final Credit credit;

  CreditCard(this.credit);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 100,
          width: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage((credit.profilePath != null)
                  ? imageBaseURL + 'w185' + credit.profilePath
                  : 'https://st3.depositphotos.com/23594922/31822/v/600/depositphotos_318221368-stock-illustration-missing-picture-page-for-website.jpg'),
            ),
          ),
        ),
        SizedBox(
          height: 6,
        ),
        Text(
          credit.name,
          style:
              blackTextFont.copyWith(fontSize: 10, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
