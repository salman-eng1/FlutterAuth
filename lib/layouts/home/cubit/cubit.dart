import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_auth/layouts/home/cubit/states.dart';
import 'package:flutter_auth/models/home_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeLayoutCubit extends Cubit<HomeLayoutStates>{
  HomeLayoutCubit() : super(HomeScreenInitialState());

  static HomeLayoutCubit get(context)=>BlocProvider.of(context);
 HomeDataModel? homeDataModel;
  void getData()async{
    emit(HomeScreenLoadingState());
    FirebaseFirestore.instance
        .collection('shared')
        .doc('data')
        .get()
        .then((value){
          homeDataModel=HomeDataModel.fromJson(value.data()!);
          emit(HomeScreenGetDataSuccessState());
    }).catchError((error){
      emit(HomeScreenGetDataErrorState(error.toString()));
    });
  }

}