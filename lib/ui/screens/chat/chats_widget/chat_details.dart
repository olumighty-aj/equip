import 'package:equipro/ui/screens/chat/chats_widget/chat_bubble.dart';
import 'package:equipro/ui/screens/chat/chats_widget/message.dart';
import 'package:equipro/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChatDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;


    final messageList = ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: messages.length,
      itemBuilder: (BuildContext context, int index) {
        return ChatBubble(
          message: messages[index],
        );
      },
    );

    final inputBox = Positioned(
      bottom: 20,
      left: 10,
      right: 10,
      child: Container(
        color: Colors.white,
        height: 60.0,
        child: TextFormField(
          maxLines: null,
          keyboardType: TextInputType.multiline,
          textAlign: TextAlign.start,
          decoration: InputDecoration(
            suffixIcon: Container(
                width: 90,
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: SvgPicture.asset(
                        "assets/images/attach.svg",
                        width: 30,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    InkWell(
                      onTap: () {},
                      child: SvgPicture.asset(
                        "assets/images/send.svg",
                        width: 30,
                      ),
                    ),
                  ],
                )),
            contentPadding:
                EdgeInsets.symmetric(vertical: 2.0, horizontal: 20.0),
            hintText: "Type here...",
            //hintText: tr.text( "Upcoming feature"),
            hintStyle: TextStyle(
              color: Color(0XFF818181),
              fontSize: 15,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(30.0),
              ),
              borderSide: BorderSide(color: Colors.grey),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(30.0),
              ),
              borderSide: BorderSide(color: Colors.grey),
            ),
          ),
          onChanged: (value) {
            //  setState(() {
            // searchWord = value;
            // print(searchWord);
            // });
          },
        ),
      ),
    );

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: deviceHeight,
            width: deviceWidth,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 30,
                ),
                Padding(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Container(
                            // margin: EdgeInsets.all(20),
                            padding: EdgeInsets.only(left: 8),
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: AppColors.white,
                            ),
                            child: InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const Icon(
                                  Icons.arrow_back_ios,
                                  color: AppColors.primaryColor,
                                ))),
                        SizedBox(
                          width: 5,
                        ),
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 40,
                        ),
                        const Text(
                          'Alex Johnson',
                          style: TextStyle(
                              fontSize: 20,
                              color: AppColors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        SvgPicture.asset("assets/images/more.svg"),
                        // SvgPicture.asset(
                        //   "assets/images/sort.svg",
                        //   width: 23.0,
                        // ),
                      ],
                    )),
                SizedBox(
                  height: 20,
                ),
                Divider(
                  thickness: 4,
                ),
                // appBar,

                Flexible(
                  child: messageList,
                ),
              ],
            ),
          ),
          inputBox
        ],
      ),
    );
  }
}
