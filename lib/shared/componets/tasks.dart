import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20,
      ),
      child: Container(
        width: double.infinity,
        height: 5,
        color: Colors.grey[300],
      ),
    );

void navigateAndFinish(
  context,
  widget,
) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (Route<dynamic> route) => false,
    );

Widget defaultTextButton({
  required Function function,
  required String text,
}) =>
    Container(
      width: double.infinity,
      color: Colors.blue,
      child: MaterialButton(
        onPressed: () {},
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );

void showToast({required String text, required ToastStates state}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: choseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

//enum
enum ToastStates { SUCCESS, ERROR, WARING }

Color choseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARING:
      color = Colors.amber;
      break;
  }
  return color;
}

// void signOut(context)
// {
//   CacheHelper.removeData(key: 'token')?.then((value)
//   {
//     if(value)
//     {
//       navigateAndFinish(context, ShopLoginScreen());
//     }
//   });
// }

// Widget buildListProduct( model,context,{bool oldPrice=true})=> Padding(
//   padding: const EdgeInsets.all(20),
//   child: Container(
//     height: 120,
//     child: Row(
//       children: [
//         Stack(
//             alignment: AlignmentDirectional.bottomStart,
//             children: [
//               Image(
//                 image:NetworkImage(
//                   model.image!,
//                 ),
//                 width:120,
//                 height: 120,
//               ),
//               if(model.discount!=0&&oldPrice)
//                 Container(
//                   color: Colors.red,
//                   padding: EdgeInsets.symmetric(horizontal: 5.0),
//                   child: Text(
//                     'Discount',
//                     style: TextStyle(
//                       fontSize:15,
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                     ),),
//                 )
//             ]
//         ),
//         SizedBox(
//           width: 20,
//         ),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(model.name!,
//                 maxLines: 3,
//                 overflow: TextOverflow.ellipsis,
//                 style: TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.bold,
//                   height: 1.3,
//                 ),),
//               Spacer(),
//               Row(
//                 children: [
//                   Text(
//                     model.price.toString(),
//                     style: TextStyle(
//                         fontSize: 12,
//                         fontWeight: FontWeight.bold,
//                         color: defaultColor
//                     ),),
//                   SizedBox(
//                     width: 5,
//                   ),
//                   if(model.discount!=0&&oldPrice)
//                     Text(
//                       model.oldPrice.toString(),
//                       style: TextStyle(
//                           fontSize: 10,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.grey,
//                           decoration: TextDecoration.lineThrough
//                       ),),
//                   Spacer(),
//                   IconButton(
//                     icon: CircleAvatar(
//                       backgroundColor:ShopLayoutCubit.get(context).favorites![ model.id]!?defaultColor:Colors.grey,
//                       //ShopLayoutCubit.get(context).favorites![model.id]!?defaultColor:
//                       radius: 15,
//                       child: Icon(
//                         size:14,
//                         Icons.favorite_border,
//                         color: Colors.white,
//                       ),
//                     ),
//                     onPressed: ()
//                     {
//                       ShopLayoutCubit.get(context).changeFavorites(model.id!);
//                       // print(model.id);
//                     },)
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ],
//     ),
//   ),
// );
//print full text
void printFullText(String text) {
  final pattern = RegExp('.{1.800}'); //80is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String? token = '';
