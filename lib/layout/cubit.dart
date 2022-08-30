import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialapp/layout/states.dart';
import 'package:socialapp/models/users_model.dart';
import 'package:socialapp/modules/chats/chats_screen.dart';
import 'package:socialapp/modules/feeds/feeds_screen.dart';
import 'package:socialapp/modules/newpost/newpost_screen.dart';
import 'package:socialapp/modules/settings/settings_screen.dart';
import 'package:socialapp/modules/users/users_screen.dart';
import 'package:socialapp/shared/componets/tasks.dart';
import 'package:firebase_storage/firebase_storage.dart'as firebase_storage;

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;

  List<Widget> screens =
  [
    FeedScreen(),
    ChatsScreen(),
    NewPostScreen(),
    UserScreen(),
    SettingScreen(),
  ];

  List<String> titles =
  [
    'Home',
    'Chats',
    'Post',
    'Users',
    'Settings',
  ];

  void changeBottomNav(int index)
  {
    if(index == 2)
      emit(NewPostState());
    else
    {
      currentIndex = index;
      emit(ChangeBottomNavState());
    }
  }

  UserModel? model;

  void getUserModel() {
    emit(GetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      // print(value.data());
      model = UserModel.fromJson(value.data()!);
      emit(GetUserSuccessState());
    }).catchError((error) {
      emit(GetUserErrorState(error.toString()));
    });
  }


   File? profileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(ProfileImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(ProfileImagePickedErrorState());
    }
  }

    File? coverImage;
  Future<void> getCoverImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(CoverImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(CoverImagePickedErrorState());
    }
  }

  String? profileImageUrl='';
  void uploadProfileImage()
  {
    firebase_storage.FirebaseStorage.instance.
    ref().
    child(
        'users/${Uri.file(profileImage!.path).pathSegments.last}').putFile(profileImage!).
    then((value)
    {
      value.ref.getDownloadURL().then((value)
      {
        emit(UploadProfileImageSuccessState());
        print(value);
        profileImageUrl=value;
      }).
      catchError((error)
      {
        emit(UploadProfileImageErrorState());
      });
    }).
    catchError((error)
    {
      emit(UploadProfileImageErrorState());
    });
  }



  String? coverImageUrl='';
  void uploadCoverImage()
  {
    firebase_storage.FirebaseStorage.instance.
    ref().
    child(
        'users/${Uri.file(coverImage!.path).pathSegments.last}').
    putFile(coverImage!).
    then((value)
    {
      value.ref.getDownloadURL().then((value)
      {
        emit(UploadCoverImageSuccessState());
        print(value);
       coverImageUrl=value;
      }).
      catchError((error)
      {
        emit(UploadCoverImageErrorState());
      });
    }).
    catchError((error)
    {
      emit(UploadCoverImageErrorState());
    });
  }



  void updateUser({
    required String name,
    required String phone,
    required String bio,
  })
  {



    UserModel model = UserModel(
      name: name,
      phone: phone,
      bio:bio,
      image:profileImageUrl,
      cover: coverImageUrl,
      isEmailVerified: false,
    );
    FirebaseFirestore.instance.
    collection('users').
    doc(model.uId).
    update(model.toMap()).
    then((value)
    {
      getUserModel();

    }).
    catchError((error)
    {
      emit(UserUpdateErrorState());
    });

  }
}
