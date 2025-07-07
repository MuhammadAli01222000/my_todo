import 'package:flutter_bloc/flutter_bloc.dart';

class MicCubit extends Cubit<bool> {
  MicCubit() : super(false);

  void toggle() => emit(!state);

  void stop() => emit(false);
}
