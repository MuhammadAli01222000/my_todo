import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
class L10nCubit extends Cubit<Locale>{
  L10nCubit():super(const Locale("ru"));
  void changeL10n(String l10nCode){
    emit(Locale(l10nCode));
  }
}