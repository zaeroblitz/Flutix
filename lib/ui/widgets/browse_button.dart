part of 'widgets.dart';

class BrowseButtons extends StatelessWidget {
  final String genre;

  BrowseButtons(this.genre);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 60,
          width: 60,
          margin: EdgeInsets.only(bottom: 8),
          padding: EdgeInsets.all(7),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(0xFFEBEFF6),
          ),
          child: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/ic_${genre.toLowerCase()}.png'),
                    fit: BoxFit.cover)),
          ),
        ),
        Text(genre,
            style: blackTextFont.copyWith(
                fontSize: 14, fontWeight: FontWeight.w400)),
      ],
    );
  }
}
