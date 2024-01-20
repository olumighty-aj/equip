import 'package:equipro/core/model/ChatMessages.dart';
import 'package:equipro/core/services/auth_service.dart';
import 'package:equipro/ui/screens/chat/chats_widget/colors.dart';
import 'package:equipro/ui/widget/noti_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ChatBubble extends StatelessWidget {
  final ChatMessages message;

  const ChatBubble(
      {Key? key, required this.message, required this.authentication})
      : super(key: key);
  final Authentication authentication;
  @override
  Widget build(BuildContext context) {
    final messageBody = message.message;
    final bool fromMe = message.senderId == authentication.currentUser.id;
    return GestureDetector(
        onTap: () {
          // showModalBottomSheet(
          //     shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.only(
          //             topLeft: Radius.circular(40), topRight: Radius.circular(40))),
          //     context: context,
          //     isDismissible:true,
          //     enableDrag: false,
          //     builder: (context) => Padding(
          //       padding:
          //       EdgeInsets.symmetric(vertical: 20,horizontal: 20),
          //       child: Column(
          //         mainAxisSize: MainAxisSize.min,
          //         children: [
          //           Row(
          //             children: [
          //               SvgPicture.asset(
          //                 "assets/images/redo.svg",
          //                 width: 20.0,
          //               ),
          //               SizedBox(
          //                 width: 10,
          //               ),
          //               Text(
          //                 "Reply",
          //               ),
          //             ],
          //           ),
          //           SizedBox(height: 20,),
          //           Row(
          //             children: [
          //               SvgPicture.asset(
          //                 "assets/images/forward.svg",
          //                 width: 20.0,
          //               ),
          //               SizedBox(
          //                 width: 10,
          //               ),
          //               Text(
          //                 "Forward",
          //               ),
          //             ],
          //           ),
          //           SizedBox(height: 20,),
          //           Row(
          //             children: [
          //               SvgPicture.asset(
          //                 "assets/images/document_copy.svg",
          //                 width: 20.0,
          //               ),
          //               SizedBox(
          //                 width: 10,
          //               ),
          //               Text(
          //                 "Copy message",
          //               ),
          //             ],
          //           ),
          //
          //           SizedBox(height: 20,),
          //           Row(
          //             children: [
          //               SvgPicture.asset(
          //                 "assets/images/report.svg",
          //                 width: 20.0,
          //               ),
          //               SizedBox(
          //                 width: 10,
          //               ),
          //               Text(
          //                 "Report Message",
          //               ),
          //             ],
          //           ),
          //           SizedBox(height: 20,),
          //           Row(
          //             children: [
          //               SvgPicture.asset(
          //                 "assets/images/fancy_delete.svg",
          //                 width: 20.0,
          //               ),
          //               SizedBox(
          //                 width: 10,
          //               ),
          //               Text(
          //                 "Delete",
          //               ),
          //             ],
          //           ),
          //           SizedBox(height: 20,),
          //         ],
          //       ),
          //     ));
        },
        child: Align(
          alignment: fromMe ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            padding: EdgeInsets.all(15.0),
            margin: fromMe
                ? EdgeInsets.only(
                    right: 20.0,
                    bottom: 20.0,
                  )
                : EdgeInsets.only(
                    left: 20.0,
                    bottom: 20.0,
                  ),
            decoration: BoxDecoration(
              gradient: fromMe ? chatBubbleGradient : chatBubbleGradient2,
              borderRadius: fromMe
                  ? BorderRadius.only(
                      topLeft: Radius.circular(12.0),
                      bottomLeft: Radius.circular(12.0),
                      topRight: Radius.circular(12.0),
                    )
                  : BorderRadius.only(
                      topRight: Radius.circular(12.0),
                      topLeft: Radius.circular(12.0),
                      bottomRight: Radius.circular(12.0),
                    ),
            ),
            // constraints: BoxConstraints(
            //   minHeight: 10.0,
            //   minWidth: 30.0,
            //   maxWidth: MediaQuery.of(context).size.width * 0.7,
            // ),
            child: Column(
              crossAxisAlignment:
                  fromMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Text(
                  messageBody!,
                  style: TextStyle(
                    color: fromMe ? Colors.black : Colors.black,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Gap(5),
                Text(
                  DateTime.parse(message.dateModified!)
                      .formatTimeIn12HourFormat(),
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(fontSize: 7),
                  textAlign: TextAlign.end,
                ),
              ],
            ),
          ),
        ));
  }
}
