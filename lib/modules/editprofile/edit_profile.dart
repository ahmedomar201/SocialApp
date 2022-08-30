import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/layout/cubit.dart';
import 'package:socialapp/layout/states.dart';
import 'package:socialapp/shared/componets/tasks.dart';
import 'package:socialapp/shared/styles/icon_broken.dart';
// ignore: must_be_immutable
class EditProfile extends StatelessWidget {
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = SocialCubit.get(context).model;
        var profileImage = SocialCubit.get(context).profileImage;
        var coverImage = SocialCubit.get(context).coverImage;

        nameController.text = model!.name!;
        phoneController.text = model.phone!;
        bioController.text = model.bio!;

        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Edit Profile',
            actions: [
              defaultTextButton(
                function: () {
                  SocialCubit.get(context).updateUser(
                      name: nameController.text,
                      phone: phoneController.text,
                      bio: bioController.text);
                },
                text: 'Update',
              ),
              SizedBox(
                width: 15.0,
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  // if (state is SocialUserUpdateLoadingState)
                    LinearProgressIndicator(),
                  // if (state is SocialUserUpdateLoadingState)
                    SizedBox(
                      height: 10.0,
                    ),
                  Container(
                    height: 190.0,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 140.0,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(
                                      4.0,
                                    ),
                                    topRight: Radius.circular(
                                      4.0,
                                    ),
                                  ),
                                  image: DecorationImage(
                                    image: coverImage == null
                                        ? NetworkImage(
                                      '${model.cover}',
                                    )
                                        : FileImage(coverImage)
                                    as ImageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: CircleAvatar(
                                  radius: 20.0,
                                  child: Icon(
                                    IconBroken.Camera,
                                    size: 16.0,
                                  ),
                                ),
                                onPressed: () {
                                  SocialCubit.get(context).getCoverImage();
                                },
                              ),
                            ],
                          ),
                          alignment: AlignmentDirectional.topCenter,
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 64.0,
                              backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 60.0,
                                backgroundImage: profileImage == null
                                    ? NetworkImage('${model.image}',)
                                    : FileImage(profileImage)
                                as ImageProvider
                              ),
                            ),
                            IconButton(
                              icon: CircleAvatar(
                                radius: 20.0,
                                child: Icon(
                                  IconBroken.Camera,
                                  size: 16.0,
                                ),
                              ),
                              onPressed: () {
                                SocialCubit.get(context).getProfileImage();
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  if (SocialCubit.get(context).profileImage != null ||
                      SocialCubit.get(context).coverImage != null)
                    Row(
                      children: [
                        if (SocialCubit.get(context).profileImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                defaultTextButton(
                                  function: () {
                                    SocialCubit.get(context).uploadProfileImage(
                                      // name: nameController.text,
                                      // phone: phoneController.text,
                                      // bio: bioController.text,
                                    );
                                  },
                                  text: 'upload profile',
                                ),
                                // if (state is SocialUserUpdateLoadingState)
                                //   SizedBox(
                                //     height: 5.0,
                                //   ),
                                // if (state is SocialUserUpdateLoadingState)
                                //   LinearProgressIndicator(),
                              ],
                            ),
                          ),
                        SizedBox(
                          width: 5.0,
                        ),
                        if (SocialCubit.get(context).coverImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                defaultTextButton(
                                  function: ()
                                  {
                                    SocialCubit.get(context).uploadCoverImage(
                                      // name: nameController.text,
                                      // phone: phoneController.text,
                                      // bio: bioController.text,
                                    );
                                  },
                                  text: 'upload cover',
                                ),
                                // if (state is SocialUserUpdateLoadingState)
                                //   SizedBox(
                                //     height: 5.0,
                                //   ),
                                // if (state is SocialUserUpdateLoadingState)
                                //   LinearProgressIndicator(),
                              ],
                            ),
                          ),
                      ],
                    ),
                  if (SocialCubit.get(context).profileImage != null ||
                      SocialCubit.get(context).coverImage != null)
                    SizedBox(
                      height: 20.0,
                    ),
                  TextFormField(
                    controller:nameController ,
                    keyboardType:TextInputType.text,
                    onFieldSubmitted: (String value){
                      print(value);
                    },
                    decoration:InputDecoration(
                      labelText:"Name",
                      prefixIcon: Icon(
                        IconBroken.User,
                      ),
                      border:OutlineInputBorder(),
                    ),
                    validator:(value) {
                      if(value!.isEmpty){
                        return "name must not be empty ";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    controller:bioController ,
                    keyboardType:TextInputType.text,
                    onFieldSubmitted: (String value){
                      print(value);
                    },
                    decoration:InputDecoration(
                      labelText:"bio",
                      prefixIcon: Icon(
                        IconBroken.Info_Circle,
                      ),
                      border:OutlineInputBorder(),
                    ),
                    validator:(value) {
                      if(value!.isEmpty){
                        return "bio must not be empty ";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    controller:phoneController ,
                    keyboardType:TextInputType.phone,
                    onFieldSubmitted: (String value){
                      print(value);
                    },
                    decoration:InputDecoration(
                      labelText:"Phone",
                      prefixIcon: Icon(
                          IconBroken.Call
                      ),
                      border:OutlineInputBorder(),
                    ),
                    validator:(value) {
                      if(value!.isEmpty){
                        return "phone must not be empty ";
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

