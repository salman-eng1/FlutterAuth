import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/models/user_model.dart';
import 'package:flutter_auth/modules/register/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpCubit extends Cubit<SignUpStates>{
  SignUpCubit( ) : super(SignUpInitialState());

  static SignUpCubit get(context)=>BlocProvider.of(context);
  void signUp({
    required String name,
    required String email,
    required String password,
    required String phoneNumber
  })async{
    emit(SignUpLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
    ).then((value){
      userCreate(
          uId: value.user!.uid,
          name: name,
          email: email,
          password: password,
          phoneNumber: phoneNumber,
      );
    });
  }
  late UserModel userModel;

  void userCreate({
    required String uId,
    required String name,
    required String email,
    required String password,
    required String phoneNumber,
  })async{
    userModel =UserModel(
        uId:uId,
        name:name,
        email:email,
        password:password,
        phoneNumber:phoneNumber);
    FirebaseFirestore.instance.collection('users')
        .doc(uId)
        .set(userModel.toMap())
        .then((value){
          emit(SignUpSuccessState());
    }).catchError((error){
      emit(SignUpErrorState(error.toString()));
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