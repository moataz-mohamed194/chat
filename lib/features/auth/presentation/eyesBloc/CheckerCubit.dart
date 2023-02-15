import 'package:bloc/bloc.dart';

class CheckerCubit extends Cubit<bool> {
  CheckerCubit() : super(true);
  void changeCheck() {
    emit(!state);
  }
}
