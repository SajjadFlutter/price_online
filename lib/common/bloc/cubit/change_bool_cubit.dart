import 'package:bloc/bloc.dart';

class ChangeBoolCubit extends Cubit<bool> {
  ChangeBoolCubit() : super(false);

  void changeBool() => emit(!state);
}
