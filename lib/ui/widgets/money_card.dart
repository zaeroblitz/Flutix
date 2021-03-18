part of 'widgets.dart';

class MoneyCard extends StatelessWidget {
  final double width;
  final bool isSelected;
  final int amount;
  final Function onTap;

  MoneyCard(
      {this.width = 90, this.isSelected = false, this.amount = 0, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap();
        }
      },
      child: Container(
        width: width,
        height: 85,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: isSelected ? Colors.transparent : Color(0xFFEE4E4E4)),
          color: isSelected ? accentColor2 : Colors.transparent,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('IDR',
                style: greyTextFont.copyWith(
                    fontSize: 16, fontWeight: FontWeight.w400)),
            SizedBox(height: 6),
            Text(
                NumberFormat.currency(
                  locale: 'id_ID',
                  symbol: '',
                  decimalDigits: 0,
                ).format(amount),
                style: blackTextFont.copyWith(
                    fontSize: 16, fontWeight: FontWeight.w400)),
          ],
        ),
      ),
    );
  }
}
