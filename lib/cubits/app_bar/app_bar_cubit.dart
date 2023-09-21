import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBarCubit extends Cubit<double> with ChangeNotifier {
  AppBarCubit() : super(0);

  void setOffset(double offset) => emit(offset);
}
