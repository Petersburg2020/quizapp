import 'package:flutter/material.dart';

class OptionButton extends StatelessWidget {
  OptionButton({
    Key key,
    @required this.text,
    @required this.width,
    this.fontSize = 18.0,
    this.onTap,
    this.isSelected = false,
  }) : super(key: key);

  final String text;
  final double width;
  final double fontSize;
  bool isSelected;
  final void Function(OptionButton button, bool selected) onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(this, isSelected),
      child: Container(
        width: width,
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Colors.green : Colors.grey,
          ),
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(
                color: isSelected ? Colors.green : Colors.grey,
                fontSize: fontSize,
              ),
              maxLines: 1,
            ),
            Container(
              height: fontSize,
              width: fontSize,
              decoration: BoxDecoration(
                border: Border.all(
                  color: isSelected ? Colors.green : Colors.grey,
                ),
                color: isSelected ? Colors.green : Colors.transparent,
                borderRadius: BorderRadius.circular(fontSize / 2.0),
              ),
              child: isSelected
                  ? Center(
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: fontSize,
                ),
              )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
