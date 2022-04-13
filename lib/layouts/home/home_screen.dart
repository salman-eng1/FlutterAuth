import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/layouts/home/cubit/cubit.dart';
import 'package:flutter_auth/layouts/home/cubit/states.dart';
import 'package:flutter_auth/shared/components/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutCubit,HomeLayoutStates>(
        listener: (BuildContext context, Object? state) {},
        builder: (BuildContext context, state) {
          var x=HomeLayoutCubit.get(context).homeDataModel;

          return Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                    onPressed: (){
                      signOut(context);
                    },
                    icon: Icon(Icons.logout,size: 30,)),
              ],
            ),
            body: Center(
              child: ConditionalBuilder(
                fallback: (BuildContext context) => CircularProgressIndicator(),
                condition: state is HomeScreenGetDataSuccessState,
                builder: (BuildContext context) =>Container(
                    padding: EdgeInsets.all(20),
                    width: double.infinity,
                    height: double.infinity,
                    child:Image(image: NetworkImage('${x?.image}'),)
                ),
              ),
            ),
          );
        });}
}
