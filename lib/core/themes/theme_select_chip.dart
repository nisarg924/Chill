import 'package:flutter/material.dart';
import '../constants/app_image.dart';
import '../constants/app_string.dart';
import '../constants/dimensions.dart';
import '../utils/style.dart';
import 'model/model_themes_types.dart';
import '../utils/style.dart';

class ThemeSelectChip extends StatefulWidget {
  final List<ModelThemesTypes> itemList;
  ModelThemesTypes selectedItem;
  final Function onSelectionChanged;

  ThemeSelectChip(this.itemList,
      {Key? key, required this.selectedItem, required this.onSelectionChanged})
      : super(key: key);

  @override
  _SelectChipState createState() => _SelectChipState();
}

class _SelectChipState extends State<ThemeSelectChip> {
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
                right: Dimensions.w20,
                bottom: Dimensions.w3,
                top: Dimensions.w3),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Container(
                      height: Dimensions.h50,
                      width: Dimensions.h50,
                      decoration: BoxDecoration(
                        color: item.themeColor,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          AppString.login ?? "",
                          style: fontStyleBold14
                              .copyWith(color: item.textColor),
                        ),
                      ),
                    ),
                    widget.selectedItem == item
                        ? Image.asset(
                            AppImage.icAppLogo,
                            height: Dimensions.w18,
                            width: Dimensions.w18,
                          )
                        : const SizedBox(),
                  ],
                ),
                SizedBox(
                  height: Dimensions.h4,
                ),
                Text(
                  item.title ?? "",
                  style: fontStyleRegular12,
                ),
              ],
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
