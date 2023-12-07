
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangeBoolCubit extends Cubit<bool> {
  ChangeBoolCubit() : super(false);

  void changeBool() => emit(!state);
}
