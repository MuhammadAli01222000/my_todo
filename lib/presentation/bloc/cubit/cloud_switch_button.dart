import 'package:flutter_bloc/flutter_bloc.dart';
class CloudSwitchButtonCubit extends Cubit<bool>{
  CloudSwitchButtonCubit():super(false);
  void upload()=>emit(true);
  void stop()=>emit(false);

}