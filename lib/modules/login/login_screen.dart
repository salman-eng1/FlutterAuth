// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_auth/layouts/home/home_screen.dart';
import 'package:flutter_auth/modules/login/cubit/cubit.dart';
import 'package:flutter_auth/modules/login/cubit/states.dart';
import 'package:flutter_auth/modules/register/register_screen.dart';
import 'package:flutter_auth/shared/network/local/cache_helper.dart';
import 'package:flutter_auth/shared/styles/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/components.dart';

class LoginScreen extends StatelessWidget {

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var formKey = GlobalKey<FormState>();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    return BlocProvider(
      create: (BuildContext context)=>LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginStates>(
        listener: (BuildContext context, state) {
          if(state is LoginErrorState){
            showToast(message: '${state.error}', state: ToastStates.ERROR);

          }else {
            if (state is LoginSuccessState) {
              showToast(message: 'you are logged in successfully',
                  state: ToastStates.SUCCESS);
              CacheHelper.saveData(key: 'uId', value: state.uId)!.then((value) {
                navigateAndFinish(context, HomeScreen());
              }).catchError((error) {
                showToast(
                    message: '${error.toString()}', state: ToastStates.ERROR);
              });
            }

          }
        },
        builder: (BuildContext context, Object? state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Login',
                style: TextStyle(
                    fontSize: 20, color: primarySwatch, fontFamily: 'Gotham-Black'),
              ),
            ),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: SafeArea(
                child: Column(
                  //its important to put mainAxisSize when using flexible
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,            children: [
                  Flexible(
                    flex: 1,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 140,
                          decoration: BoxDecoration(
                              color: primarySwatch,
                              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15))
                          ),
                        ),
                        Positioned(
                          bottom: -40,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.red,
                                boxShadow: [
                                  BoxShadow(color: Colors.white, spreadRadius: 4),
                                ],
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/splash/login_avatar.png')),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Flexible(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        key: formKey,
                        child: Card(
                          elevation: 10.0,
                          child: Column(
                            children: [
                              defaultTextField(
                                validator: (value) {
                                  if(value!.isEmpty){
                                    return 'please enter your email';
                                  }else{
                                    return null;
                                  }
                                },
                                controller: emailController,
                                label: 'Email',
                                prefix: Icons.email_outlined,
                                inputType: TextInputType.text,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              defaultTextField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'please enter email';
                                  }else{
                                    return null;
                                  }
                                },
                                controller: passwordController,
                                label: 'password',
                                isPassword: LoginCubit.get(context).isPassword,
                                suffix: LoginCubit.get(context).suffix,
                                suffixPressed: (){
                                  LoginCubit.get(context).changePasswordVisibility();
                                },
                                prefix: Icons.lock_outline_rounded,
                                inputType: TextInputType.visiblePassword,
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              defaultButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()){
                                    LoginCubit.get(context).userLogin(email: emailController.text, password: passwordController.text);
                                  }
                                },
                                text: 'Login',
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('if you dont have an account,please '),
                                  defaultTextButton(
                                      text: 'SignUp', onPressed: () {
                                    navigateTo(context, RegisterScreen());
                                  }, color: primarySwatch)
                                ],
                              ),
                              SizedBox(height: 20,),

                            ],),
                        ),
                      ),
                    ),
                  )
                ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
