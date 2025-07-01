enum APIResultType { LOADING, SUCCESS, FAILURE, SESSION_EXPIRED, NO_INTERNET, UNAUTHORISED, CACHEERROR, NOTFOUND }

enum NetworkResultType { SUCCESS, ERROR, ERROR422, CACHEERROR, NO_INTERNET, UNAUTHORISED, NOTFOUND }

enum ImageType { local, network }

enum PaymentType {
  cash,
  tigoPesa,
  // notAvailable
}

enum OrderStatusType {
  // completed,
  // notAvailable,
  ongoing,
  delivered,
  pickedUp,
  notPickedUp,
}

enum IsFrom { reset, forgot }

enum AppThemesType { light, dark }

enum FontSizeType {
  small(0.9),
  normal(1.0),
  large(1.1);

  final num value;

  const FontSizeType(this.value);
}

// enum FontStyleType {Inter, Montserrat, Lato, Dancing, Caveat }
enum FontStyleType { Gotham, Dancing, QuickSand, Avenir, Inter, Poppins, Lato, Roboto, NunitoSans, OpenSans }

enum FilterType { daily, weekly, monthly, yearly }
