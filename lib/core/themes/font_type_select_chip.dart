import 'package:flutter/material.dart';
import '../constants/app_color.dart';
import '../constants/dimensions.dart';
import '../utils/style.dart';
import 'model/model_font_types.dart';

class FontSelectChip extends StatefulWidget {
  final List<ModelFontTypes> itemList;
  ModelFontTypes selectedItem;
  final Function onSelectionChanged;

  FontSelectChip(this.itemList,
      {Key? key, required this.selectedItem, required this.onSelectionChanged})
      : super(key: key);

  @override
  _SelectChipState createState() => _SelectChipState();
}

class _SelectChipState extends State<FontSelectChip> {
  _buildChoiceList() {
    List<Widget> choices = [];
    for (var item in widget.itemList) {
      choices.add(
        GestureDetector(
          onTap: () {
            setState(() {
              widget.selectedItem = item;
              widget.onSelectionChanged(widget.selectedItem);
            });
          },
          child: Padding(
            padding: EdgeInsets.only(
                right: Dimensions.w10,
                bottom: Dimensions.w3,
                top: Dimensions.w3),
            child: Container(
              height: Dimensions.h42,

              // padding: EdgeInsets.only(left: Dimensions.w12,right: Dimensions.w12),
              decoration: BoxDecoration(
                color: widget.selectedItem == item
                    ? ColorConst.primaryColor
                    : Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.all(
                  Radius.circular(Dimensions.r7),
                ),
                border: Border.all(
                  color: widget.selectedItem == item
                      ? ColorConst.primaryColor
                      : Theme.of(context).colorScheme.primaryContainer,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: Dimensions.w14,
                  ),
                  Text(
                    item.title ?? "",
                    style: fontStyleRegular14.copyWith(
                        fontFamily: item.fontStyleName,
                        color: widget.selectedItem == item
                            ? ColorConst.textWhiteColor
                            : null),
                  ),
                  SizedBox(
                    width: Dimensions.w10,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      //r crossAxisAlignment: WrapCrossAlignment.center,

      //  runAlignment: WrapAlignment.center,
      //alignment: WrapAlignment.center,
      children: _buildChoiceList(),
    );
  }
}
