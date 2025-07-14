// import 'package:buildcondition/buildcondition.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:social_app/layout/social_layout.dart';
// import 'package:social_app/modules/login/cubit_login.dart';
// import 'package:social_app/modules/login/states_login.dart';
// import 'package:social_app/modules/register/register_screen.dart';
// import 'package:social_app/shared/componets/tasks.dart';
// import 'package:social_app/shared/netwoark/local/cash_helper.dart';

// // ignore: must_be_immutable
// class LoginScreen extends StatelessWidget {
//   var emailController = TextEditingController();
//   var passwordController = TextEditingController();
//   var fromKey = GlobalKey<FormState>();
//   bool isPassword = true;
//   IconData suffix = Icons.visibility_outlined;

//   LoginScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (BuildContext context) => LoginCubit(),
//       child: BlocConsumer<LoginCubit, LoginStates>(
//         listener: (context, state) {
//           if (state is LoginErrorState) {
//             showToast(text: state.error, state: ToastStates.ERROR);
//           }
//           if (state is LoginSuccessState) {
//             CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
//               navigateAndFinish(context, SocialLayout());
//             });
//             //   } else {
//             //     showToast(
//             //       text: state.loginModel.message,
//             //       state: ToastStates.ERROR,
//             //     );
//             //     print(state.loginModel.message);
//             //   }
//             // }
//           }
//         },
//         builder: (context, state) => Scaffold(
//           appBar: AppBar(),
//           body: Padding(
//             padding: const EdgeInsets.all(20),
//             child: Center(
//               child: SingleChildScrollView(
//                 child: Form(
//                   key: fromKey,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'LOGIN',
//                         style: Theme.of(context).textTheme.headlineMedium
//                             ?.copyWith(
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black,
//                             ),
//                       ),
//                       Text(
//                         'Login now to Communicate with friends',
//                         style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                           color: Colors.grey,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       SizedBox(height: 40),
//                       TextFormField(
//                         controller: emailController,
//                         keyboardType: TextInputType.emailAddress,
//                         onFieldSubmitted: (String value) {
//                           print(value);
//                         },
//                         decoration: InputDecoration(
//                           labelText: "email address",
//                           prefixIcon: Icon(Icons.email),
//                           border: OutlineInputBorder(),
//                         ),
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return "Email address must not be empty ";
//                           }
//                           return null;
//                         },
//                       ),
//                       SizedBox(height: 15),
//                       TextFormField(
//                         controller: passwordController,
//                         keyboardType: TextInputType.visiblePassword,
//                         obscureText: LoginCubit.get(context).isPassword,
//                         onFieldSubmitted: (value) {},
//                         onTap: () {
//                           LoginCubit.get(context).changIcon();
//                         },
//                         decoration: InputDecoration(
//                           labelText: "password",
//                           prefixIcon: Icon(Icons.lock),
//                           suffixIcon: Icon(LoginCubit.get(context).suffix),
//                           border: OutlineInputBorder(),
//                         ),
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return "password must not be empty ";
//                           }
//                           return null;
//                         },
//                       ),
//                       SizedBox(height: 20),
//                       BuildCondition(
//                         condition: state is! LoginLoadingState,
//                         builder: (context) => Container(
//                           width: double.infinity,
//                           color: Colors.blue,
//                           child: MaterialButton(
//                             onPressed: () {
//                               if (fromKey.currentState!.validate()) {
//                                 LoginCubit.get(context).userLogin(
//                                   email: emailController.text,
//                                   password: passwordController.text,
//                                 );
//                               }
//                             },
//                             child: Text(
//                               "LOGIN",
//                               style: TextStyle(color: Colors.white),
//                             ),
//                           ),
//                         ),
//                         fallback: (context) =>
//                             Center(child: CircularProgressIndicator()),
//                       ),
//                       SizedBox(height: 10),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text("DON't have an account?"),
//                           TextButton(
//                             onPressed: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => RegisterScreen(),
//                                 ),
//                               );
//                             },
//                             child: Text("Register Now"),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
