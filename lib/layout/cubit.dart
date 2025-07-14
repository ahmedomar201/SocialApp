import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../models/message_model.dart';
import '../models/post_model.dart';
import '../models/users_model.dart';
import '../modules/chats/chats_screen.dart';
import '../modules/feeds/feeds_screen.dart';
import '../modules/login/login_screen.dart';
import '../modules/newpost/newpost_screen.dart';
import '../modules/settings/settings_screen.dart';
import '../modules/users/users_screen.dart';
import '../presentionLayer/screens/login_screen.dart';
import '../shared/componets/tasks.dart';
import 'states.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;

  List<Widget> screens = [
    FeedScreen(),
    ChatsScreen(),
    NewPostScreen(),
    UserScreen(),
    SettingScreen(),
  ];

  List<String> titles = ['Home', 'Chats', 'Post', 'Users', 'Settings'];

  void changeBottomNav(int index) {
    if (index == 1) getUsers();
    if (index == 2) {
      emit(NewPostState());
    } else {
      currentIndex = index;
      emit(ChangeBottomNavState());
    }
  }

  UserModel? userModel;

  void getUserModel() {
    emit(GetUserLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value) {
          // print(value.data());
          userModel = UserModel.fromJson(value.data()!);
          emit(GetUserSuccessState());
        })
        .catchError((error) {
          emit(GetUserErrorState(error.toString()));
        });
  }

  File? profileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

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
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

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
  }) {
    emit(UserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
          value.ref
              .getDownloadURL()
              .then((value) {
                //emit(UploadProfileImageSuccessState());
                print(value);
                updateUser(name: name, phone: phone, bio: bio, image: value);
              })
              .catchError((error) {
                emit(UploadProfileImageErrorState());
              });
        })
        .catchError((error) {
          emit(UploadProfileImageErrorState());
        });
  }

  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(UserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
          value.ref
              .getDownloadURL()
              .then((value) {
                //emit(UploadCoverImageSuccessState());
                print(value);
                updateUser(name: name, phone: phone, bio: bio, cover: value);
              })
              .catchError((error) {
                emit(UploadCoverImageErrorState());
              });
        })
        .catchError((error) {
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
  }) {
    UserModel model = UserModel(
      name: name,
      phone: phone,
      bio: bio,
      image: image ?? userModel!.image,
      cover: cover ?? userModel!.cover,
      uId: userModel!.uId,
      email: userModel!.email,
      isEmailVerified: false,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .update(model.toMap())
        .then((value) {
          getUserModel();
        })
        .catchError((error) {
          emit(UserUpdateErrorState());
        });
  }

  File? postImage;

  Future<void> getPostImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(PostImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(PostImagePickedErrorState());
    }
  }

  void uploadPostImage({required String dateTime, required String text}) {
    emit(CreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
          value.ref
              .getDownloadURL()
              .then((value) {
                print(value);

                createPost(text: text, dateTime: dateTime, postImage: value);
              })
              .catchError((error) {
                emit(CreatePostErrorState());
              });
        })
        .catchError((error) {
          emit(CreatePostErrorState());
        });
  }

  void createPost({
    required String dateTime,
    required String text,
    String? postImage,
  }) {
    emit(CreatePostLoadingState());

    PostModel model = PostModel(
      name: userModel!.name,
      image: userModel!.image,
      uId: userModel!.uId,
      dateTime: dateTime,
      text: text,
      postImage: postImage ?? '',
    );

    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
          emit(CreatePostSuccessState());
        })
        .catchError((error) {
          emit(CreatePostErrorState());
        });
  }

  void removePostImage() {
    postImage = null;
    emit(RemovePostImageState());
  }

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];

  void getPosts() {
    FirebaseFirestore.instance
        .collection('posts')
        .get()
        .then((value) {
          for (var element in value.docs) {
            element.reference
                .collection('likes')
                .get()
                .then((value) {
                  likes.add(value.docs.length);
                  postsId.add(element.id);
                  posts.add(PostModel.fromJson(element.data()));
                })
                .catchError((error) {});
          }

          emit(GetPostsSuccessState());
        })
        .catchError((error) {
          print(error.toString());
          emit(GetPostsErrorState(error.toString()));
        });
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .set({'like': true})
        .then((value) {
          emit(LikePostSuccessState());
        })
        .catchError((error) {
          emit(LikePostErrorState(error.toString()));
        });
  }

  List<UserModel>? users = [];

  void getUsers() {
    if (users!.isEmpty) {
      FirebaseFirestore.instance
          .collection('users')
          .get()
          .then((value) {
            for (var element in value.docs) {
              if (element.data()['uId'] != userModel!.uId) {
                users!.add(UserModel.fromJson(element.data()));
              }
            }

            emit(GetChatSuccessState());
          })
          .catchError((error) {
            print(error.toString());
            emit(GetChatErrorState(error.toString()));
          });
    }
  }

  void sendMessage({
    required String receiverId,
    required String dateTime,
    required String text,
  }) {
    MessageModel model = MessageModel(
      text: text,
      senderId: userModel!.uId,
      receiverId: receiverId,
      dateTime: dateTime,
    );

    // set my chats

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
          emit(SendMessageSuccessState());
        })
        .catchError((error) {
          emit(SendMessageErrorState());
        });

    // set receiver chats

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel!.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
          emit(SendMessageSuccessState());
        })
        .catchError((error) {
          emit(SendMessageErrorState());
        });
  }

  List<MessageModel> messages = [];

  void getMessages({required String receiverId}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
          messages = [];

          for (var element in event.docs) {
            messages.add(MessageModel.fromJson(element.data()));
          }
        });
  }

  void signOut(context) {
    FirebaseAuth.instance
        .signOut()
        .then((value) {
          navigateAndFinish(context, LoginScreen());
          emit(UserSignOutSuccessState());
        })
        .catchError((error) {
          print(error.toString());
          emit(UserSignOutErrorState());
        });
  }

  Completer<GoogleMapController>? place = Completer();

  Future<void> direction() async {
    final GoogleMapController controller = await place!.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          bearing: 192.8334901395799,
          target: LatLng(37.43296265331129, -122.08832357078792),
          tilt: 59.440717697143555,
          zoom: 19.151926040649414,
        ),
      ),
    );
  }
}



  //AAAA_0pl7NM:APA91bHxHBkYg5lG5SLdrbF0AyydJBhqGZ_OGgz2UPExsLNdZhpu0ZMPTeoZYpvS_B6OstRfjtb6NgVan_4jdbEmayn2pBY1ybweeqRKL8PJ---5Je0t-29At-Q4Mq4Da5vB9pB9h0TM