part of 'widgets.dart';

class DateCard extends StatelessWidget {
  final DateTime dateTime;
  final bool isSelected;
  final double width;
  final double height;
  final Function onTap;

  DateCard(this.dateTime,
      {this.isSelected = false, this.width = 70, this.height = 90, this.onTap});

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
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isSelected ? accentColor2 : Colors.transparent,
          border: Border.all(
              color: isSelected ? Colors.transparent : Color(0xFFE4E4E4)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              dateTime.shortDayName,
              style: blackTextFont.copyWith(
                  fontSize: 16, fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 6,
            ),
            Text(dateTime.day.toString(),
                style: blackTextFont.copyWith(
                    fontSize: 16, fontWeight: FontWeight.w400)),
          ],
        ),
      ),
    );
  }
}
