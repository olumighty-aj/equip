
import 'package:equipro/ui/screens/chat/chats_widget/colors.dart';
import 'package:equipro/ui/screens/chat/chats_widget/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class ChatBubble extends StatelessWidget {
  final Message message;

  const ChatBubble({ Key? key, required this.message}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final messageBody = message.body;
    final fromMe = message.fromMe;
    return
      InkWell(
        onTap: (){
          showModalBottomSheet(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40), topRight: Radius.circular(40))),
              context: context,
              isDismissible:true,
              enableDrag: false,
              builder: (context) => Padding(
                padding:
                EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/images/redo.svg",
                          width: 20.0,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Reply",
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/images/forward.svg",
                          width: 20.0,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Forward",
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/images/document_copy.svg",
                          width: 20.0,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Copy message",
                        ),
                      ],
                    ),

                    SizedBox(height: 20,),
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/images/report.svg",
                          width: 20.0,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Report Message",
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/images/fancy_delete.svg",
                          width: 20.0,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Delete",
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
                  ],
                ),
              ));
        },
        child:

      Align(
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
        constraints: BoxConstraints(
          minHeight: 20.0,
          minWidth: 30.0,
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        child: Text(
            messageBody,
            style: TextStyle(
              color: fromMe ? Colors.black : Colors.black,
              fontSize: 15.0,
              fontWeight: FontWeight.w500,
            ),

        ),
      ),
      )  );
  }
}
