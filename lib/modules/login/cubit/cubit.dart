import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/modules/login/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class LoginCubit extends Cubit<LoginStates>{
  LoginCubit() : super(LoginInitialState());
  static LoginCubit get(context) =>BlocProvider.of(context);
  void userLogin({
  required String email,
  required String password,
}) async
{
  emit(LoginLoadingState());
  FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password
  ).then((value){
    emit(LoginSuccessState(value.user?.uid));
  }).catchError((error){
    emit(LoginErrorState(error.toString()));
    print(error.toString());
  });

}
IconData suffix=Icons.visibility_outlined;
bool isPassword=true;
void changePasswordVisibility(){
  isPassword=!isPassword;
  suffix= isPassword?Icons.visibility_outlined:Icons.visibility_off_outlined;
  emit(ChangePasswordVisibilityState());
}
}
