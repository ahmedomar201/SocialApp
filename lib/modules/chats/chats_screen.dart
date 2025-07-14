import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit.dart';
import 'package:social_app/layout/states.dart';
import 'package:social_app/models/users_model.dart';
import 'package:social_app/modules/chats/chat_detalis.dart';
import 'package:social_app/shared/componets/tasks.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return BuildCondition(
          condition: SocialCubit.get(context).users!.isNotEmpty,
          builder: (context) => ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) =>
                buildChatItem(SocialCubit.get(context).users![index], context),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: SocialCubit.get(context).users!.length,
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildChatItem(UserModel model, context) => InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatDetailsScreen(userModel: model),
        ),
      );
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25.0,
            backgroundImage: NetworkImage(model.image),
          ),
          SizedBox(width: 15.0),
          Text(model.name, style: TextStyle(height: 1.4)),
        ],
      ),
    ),
  );
}
