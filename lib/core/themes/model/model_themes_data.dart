import 'dart:convert';

ModelThemesData modelThemesDataFromMap(String str) =>
    ModelThemesData.fromMap(json.decode(str));

String modelThemesDataToMap(ModelThemesData data) => json.encode(data.toMap());

class ModelThemesData {
  int? fontSizeType;
  int? fontStyleType;
  int? themeType;

  ModelThemesData({
    this.fontSizeType,
    this.fontStyleType,
    this.themeType,
  });

  factory ModelThemesData.fromMap(Map<String, dynamic> json) => ModelThemesData(
        fontSizeType: json["fontSizeType"],
        fontStyleType: json["fontStyleType"],
        themeType: json["themeType"],
      );

  Map<String, dynamic> toMap() => {
        "fontSizeType": fontSizeType,
        "fontStyleType": fontStyleType,
        "themeType": themeType,
      };
}
