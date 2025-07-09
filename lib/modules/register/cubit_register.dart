import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/users_model.dart';
import 'package:social_app/modules/register/states_register.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
          // emit(RegisterSuccessState());
          // print(value.user?.email);
          // print(value.user?.uid);
          createUser(
            name: name,
            email: email,
            phone: phone,
            uId: value.user!.uid,
          );
        })
        .catchError((error) {
          emit(RegisterErrorState(error.toString()));
        });
  }

  void createUser({
    required String name,
    required String email,
    required String phone,
    required String uId,
  }) {
    UserModel model = UserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      image:
          'https://image.freepik.com/free-photo/skeptical-woman-has-unsure-questioned-expression-points-fingers-sideways_273609-40770.jpg',
      cover: 'https://images5.alphacoders.com/120/1206703.jpg',
      bio: 'Write you bio....',
      isEmailVerified: false,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
          emit(CreateUserSuccessState());
        })
        .catchError((error) {
          emit(CreateUserErrorState(error.toString()));
        });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changIconRegister() {
    suffix = isPassword
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    isPassword = !isPassword;
    emit(RegisterChangePasswordVisibilityState());
  }
}
