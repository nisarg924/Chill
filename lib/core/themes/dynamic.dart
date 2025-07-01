import 'package:bloc/bloc.dart';

// Events
abstract class FontEvent {}

class ChangeFontSize extends FontEvent {
  final double fontSize;

  ChangeFontSize(this.fontSize);
}

class ChangeFontStyle extends FontEvent {
  final String fontFamily;

  ChangeFontStyle(this.fontFamily);
}

// States
class FontState {
  final double fontSize;
  final String fontFamily;

  FontState({required this.fontSize, required this.fontFamily});
}

// BLoC
class FontBloc extends Bloc<FontEvent, FontState> {
  FontBloc()
      : super(
          FontState(
            fontSize: 16.0,
            fontFamily: 'DefaultFont',
          ),
        ) {
    on<ChangeFontStyle>(
      (event, emit) {

        emit(
          FontState(
            fontSize: 12,
            fontFamily: event.fontFamily,
          ),
        );
      },
    );
    on<ChangeFontSize>(
      (event, emit) => emit(
        FontState(
          fontSize: event.fontSize,
          fontFamily: "",
        ),
      ),
    );
  }

// Stream<FontState> mapEventToState(FontEvent event) async* {
//   if (event is ChangeFontSize) {
//     yield FontState(fontSize: event.fontSize, fontFamily: state.fontFamily);
//   } else if (event is ChangeFontStyle) {
//     yield FontState(fontSize: state.fontSize, fontFamily: event.fontFamily);
//   }
// }
}
