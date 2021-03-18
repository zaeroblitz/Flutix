part of 'widgets.dart';

class PromoCard extends StatelessWidget {
  final Promo promo;

  PromoCard(this.promo);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: mainColor,
          ),
          child: Stack(children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15)),
              child: SizedBox(
                height: 80,
                width: 148,
                child: Image(image: AssetImage('assets/vector_2.png')),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: ClipRRect(
                borderRadius: BorderRadius.only(topRight: Radius.circular(15)),
                child: SizedBox(
                    height: 45,
                    width: 124,
                    child: Image(
                      image: AssetImage('assets/rectangle_1.png'),
                    )),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: ClipRRect(
                borderRadius: BorderRadius.only(topRight: Radius.circular(15)),
                child: SizedBox(
                    height: 25,
                    width: 91,
                    child: Image(
                      image: AssetImage('assets/rectangle_2.png'),
                    )),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                        promo.title,
                        style:
                            whiteTextFont.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(promo.subtitle,
                          style: whiteTextFont.copyWith(
                              fontSize: 11, fontWeight: FontWeight.w300))
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                  Row(
                    children: <Widget>[
                      Text('OFF ',
                          style: yellowNumberFont.copyWith(
                              fontSize: 18, fontWeight: FontWeight.w300)),
                      Text('${promo.discount}%',
                          style: yellowNumberFont.copyWith(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            ),
          ]),
        ),
      ],
    );
  }
}
