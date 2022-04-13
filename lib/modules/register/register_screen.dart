// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_auth/layouts/home/home_screen.dart';
import 'package:flutter_auth/modules/register/cubit/cubit.dart';
import 'package:flutter_auth/shared/styles/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/components/components.dart';
import 'cubit/states.dart';

class RegisterScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    var formkey = GlobalKey<FormState>();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var phoneController = TextEditingController();
    var usernameController = TextEditingController();
    return BlocProvider(
      create: (BuildContext context)=>SignUpCubit(),

      child: BlocConsumer<SignUpCubit,SignUpStates>(
        listener: (context, state) {
          if(state is SignUpErrorState){
            showToast(message: '${state.error}', state: ToastStates.ERROR);

          }else {
            if (state is SignUpSuccessState) {
              showToast(message: 'you are logged in successfully',
                  state: ToastStates.SUCCESS);
                navigateAndFinish(context, HomeScreen());
            }

          }
        },
        builder: (context, state) {
         return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Text(
                'Register',
                style: TextStyle(
                    fontSize: 20, color: primarySwatch, fontFamily: 'Gotham-Black'),
              ),
            ),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 1,
                    child: Container(
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 120,
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
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Flexible(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        key: formkey,
                        child: Card(
                          elevation: 10.0,
                          child: Column(
                            children: [
                              defaultTextField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'please enter your username';
                                  }else{
                                    return null;
                                  }
                                },
                                controller: usernameController,
                                label: 'username',
                                prefix: Icons.edit,
                                inputType: TextInputType.text,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              defaultTextField(
                                validator: (value) {
                                  if (value!.isEmpty) {
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
                                height: 10,
                              ),
                              defaultTextField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'please enter your password';
                                  }else{
                                    return null;
                                  }
                                },
                                controller: passwordController,
                                label: 'password',
                                isPassword: SignUpCubit.get(context).isPassword,
                                suffix: SignUpCubit.get(context).suffix,
                                suffixPressed: (){
                                  SignUpCubit.get(context).changePasswordVisibility();
                                },
                                prefix: Icons.lock_outline_rounded,
                                inputType: TextInputType.visiblePassword,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              defaultTextField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'please enter please enter your phone number';
                                  }else{
                                    return null;
                                  }
                                },
                                controller: phoneController,
                                label: 'phone',
                                prefix: Icons.phone,
                                inputType: TextInputType.number,
                                
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              defaultButton(
                                onPressed: () {
                                if(formkey.currentState!.validate()){
                                  SignUpCubit.get(context).signUp(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      name: usernameController.text,
                                      phoneNumber: phoneController.text);
                                }
                                },
                                text: 'SignUp',
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('if you have an account,please '),
                                  defaultTextButton(
                                      text: 'SignIn', onPressed: () {

                                  }, color: primarySwatch)
                                ],
                              ),
                              SizedBox(height: 10,),

                            ],),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },

      ),
    );
  }
}
