// lib/cubit/home_scroll_cubit.dart

import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScrollCubit extends Cubit<double> {
  HomeScrollCubit() : super(0.0);
  void updateScrollPosition(double position) => emit(position);
}
