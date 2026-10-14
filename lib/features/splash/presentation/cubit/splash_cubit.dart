import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  Future<void> checkAuthState() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    final user =
        FirebaseAuth.instance.currentUser; //check if this user is authenticated
    if (user != null) {
      emit(SplashAuthenticated());
    } else {
      emit(SplashUnauthenticated());
    }
  }
}
