import 'package:bloc/bloc.dart';
class CompletedButtonCubit extends Cubit<bool> {
  CompletedButtonCubit() : super(false);

  void toggle(bool? value) => emit(value ?? false);
}
