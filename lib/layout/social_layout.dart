import 'package:buildcondition/buildcondition.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/layout/cubit.dart';
import 'package:socialapp/layout/states.dart';
import 'package:socialapp/shared/componets/tasks.dart';

class SocialLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('News Feed'),
          ),
          body: BuildCondition(
            condition: SocialCubit.get(context).model != null,
            builder: (context) {
              var model = SocialCubit.get(context).model;

              return Column(
                children: [
                  if (!model!.isEmailVerified!)
                    // if(FirebaseAuth.instance.currentUser!.emailVerified)
                    Container(
                      color: Colors.amber.withOpacity(0.6),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: Text('please verify your email'),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              child: MaterialButton(
                                onPressed: () {
                                  FirebaseAuth.instance.currentUser!
                                      .sendEmailVerification()
                                      .then((value) {
                                    showToast(
                                        text: 'chek your mail',
                                        state: ToastStates.SUCCESS);
                                  });
                                },
                                child: Text(
                                  'Send',
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              );
            },
            fallback: (context) => Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }
}
