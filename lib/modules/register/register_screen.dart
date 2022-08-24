import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/layout/social_layout.dart';
import 'package:socialapp/modules/register/cubit_register.dart';
import 'package:socialapp/modules/register/states_register.dart';
import 'package:socialapp/shared/componets/tasks.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var fromKey = GlobalKey<FormState>();
  bool isPassword = true;
  IconData suffix = Icons.visibility_outlined;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is CreateUserSuccessState) {
            navigateAndFinish(context, SocialLayout());
          }
          // if(state is ShopRegisterSuccessState) {
          //   if (state.registerModel.status!) {
          //     print(state.registerModel.message);
          //     print(state.registerModel.message);
          //     CacheHelper.saveData(
          //         key: 'token',
          //         value: state.registerModel.data?.token).then((value)
          //     {
          //       token=state.registerModel.data!.token;
          //       navigateAndFinish(context,
          //           ShopLayout());
          //     });
          //   } else {
          //     showToast(
          //       text: state.registerModel.message!,
          //       state: ToastStates.ERROR,
          //     );
          //     print(state.registerModel.message);
          //   }
          // }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: fromKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'REGISTER',
                          style: Theme.of(context)
                              .textTheme
                              .headline4
                              ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                        ),
                        Text(
                          'Register now to Communicate with friends',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: nameController,
                          keyboardType: TextInputType.name,
                          onFieldSubmitted: (String value) {
                            print(value);
                          },
                          decoration: InputDecoration(
                            labelText: "User Name",
                            prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Name must not be empty ";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          onFieldSubmitted: (String value) {
                            print(value);
                          },
                          decoration: InputDecoration(
                            labelText: "email address",
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Email address must not be empty ";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: RegisterCubit.get(context).isPassword,
                          onFieldSubmitted: (value) {},
                          onTap: () {
                            RegisterCubit.get(context).changIconRegister();
                          },
                          decoration: InputDecoration(
                            labelText: "password",
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: Icon(
                              RegisterCubit.get(context).suffix,
                            ),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "password must not be empty ";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          onFieldSubmitted: (String value) {
                            print(value);
                          },
                          decoration: InputDecoration(
                            labelText: "Phone",
                            prefixIcon: Icon(Icons.phone),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "phone must not be empty ";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        BuildCondition(
                          condition: state is! RegisterLoadingState,
                          builder: (context) => Container(
                            width: double.infinity,
                            color: Colors.blue,
                            child: MaterialButton(
                              onPressed: () {
                                if (fromKey.currentState!.validate()) {
                                  RegisterCubit.get(context).userRegister(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    phone: phoneController.text,
                                  );
                                }
                              },
                              child: Text(
                                "REGISTER",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
