import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialapp/layout/states.dart';
import 'package:socialapp/models/post_model.dart';
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

  UserModel? userModel;

  void getUserModel() {
    emit(GetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      // print(value.data());
      userModel = UserModel.fromJson(value.data()!);
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



  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  })
  {
    emit(UserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value)
    {
      value.ref.getDownloadURL().then((value)
      {
        //emit(UploadProfileImageSuccessState());
        print(value);
        updateUser(
            name: name,
            phone: phone,
            bio: bio,
            image: value);
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




  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  })
  {
    emit(UserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance.
    ref().
    child('users/${Uri.file(coverImage!.path).pathSegments.last}').
    putFile(coverImage!).
    then((value)
    {
      value.ref.getDownloadURL().then((value)
      {
        //emit(UploadCoverImageSuccessState());
        print(value);
        updateUser(
            name: name,
            phone: phone,
            bio: bio,
            cover: value);
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



  // void updateUserImages({
  //   required String name,
  //   required String phone,
  //   required String bio,
  // })
  // {
  //   if(coverImage!=null)
  //   {
  //      uploadCoverImage();
  //   }else if(profileImageUrl!=null)
  //   {
  //     uploadProfileImage();
  //   }else if (coverImage!=null&&profileImageUrl!=null)
  //   {
  //
  //   }else
  //   {
  //     updateUser(
  //       name:name,
  //       bio: bio,
  //       phone:phone,
  //     );
  //   }
  // }


  void updateUser({
    required String name,
    required String phone,
    required String bio,
    String? image,
    String? cover,

  })
  {

    UserModel model = UserModel(
      name: name,
      phone: phone,
      bio:bio,
      image:image??userModel!.image,
      cover:cover??userModel!.cover,
      uId: userModel!.uId,
      email:userModel!.email,
      isEmailVerified: false,
    );
    FirebaseFirestore.instance.
    collection('users').
    doc(userModel!.uId).
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



  File? postImage;

  Future<void> getPostImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(PostImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(PostImagePickedErrorState());
    }
  }


  void uploadPostImage({
    required String dateTime,
    required String text,
  })
  {
    emit(CreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance.
    ref().
    child('posts/${Uri.file(postImage!.path).pathSegments.last}').
    putFile(postImage!).
    then((value)
    {
      value.ref.getDownloadURL().then((value)
      {
        print(value);

        createPost(
          text: text,
          dateTime: dateTime,
          postImage: value,
        );
      }).
      catchError((error)
      {
        emit(CreatePostErrorState());
      });
    }).
    catchError((error)
    {
      emit(CreatePostErrorState());
    });
  }


  void createPost({
    required String dateTime,
    required String text,
    String? postImage,
  })
  {
    emit(CreatePostLoadingState());

    PostModel model = PostModel(
      name: userModel!.name,
      image: userModel!.image,
      uId: userModel!.uId,
      dateTime: dateTime,
      text: text,
      postImage: postImage??'',
    );

    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value)
    {
      emit(CreatePostSuccessState());
    })
        .catchError((error)
    {
      emit(CreatePostErrorState());
    });
  }

  void removePostImage()
  {
    postImage = null;
    emit(RemovePostImageState());
  }


  List<PostModel> posts = [];

  void getPosts()
  {
    FirebaseFirestore.instance
        .collection('posts')
        .get()
        .then((value)
    {
      value.docs.forEach((element)
      {
        posts.add(PostModel.fromJson(element.data()));
      });

      emit(GetPostsSuccessState());
    })
        .catchError((error){
      emit(GetPostsErrorState(error.toString()));
    });
  }
}



