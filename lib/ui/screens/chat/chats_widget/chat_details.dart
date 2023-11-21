import 'dart:async';
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:equipro/core/model/ChatListModel.dart';
import 'package:equipro/core/model/ChatMessages.dart';
import 'package:equipro/core/model/error_model.dart';
import 'package:equipro/core/services/activities_service.dart';
import 'package:equipro/core/services/auth_service.dart';
import 'package:equipro/ui/screens/chat/chats_widget/chat_bubble.dart';
import 'package:equipro/utils/colors.dart';
import 'package:equipro/utils/helpers.dart';
import 'package:equipro/utils/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class ChatDetailsPage extends StatefulWidget {
  final ChatListModel feed;

  const ChatDetailsPage({Key? key, required this.feed}) : super(key: key);

  @override
  State<ChatDetailsPage> createState() => _ChatDetailsPageState();
}

class _ChatDetailsPageState extends State<ChatDetailsPage> {
  final Authentication _authentication = locator<Authentication>();
  TextEditingController textController = TextEditingController();
  PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();
  ScrollController scrollController = ScrollController();
  String _log = 'output:\n';
  final Activities _activities = locator<Activities>();
  List<ChatMessages> chatResponse = [];

  log(String text) {
    print("LOG: $text");
    setState(() {
      _log += text + "\n";
      Timer(
          const Duration(milliseconds: 100),
          () => scrollController
              .jumpTo(scrollController.position.maxScrollExtent));
    });
  }

  void onConnectionStateChange(dynamic currentState, dynamic previousState) {
    log("Connection: $currentState");
  }

  void onError(String message, int? code, dynamic e) {
    log("onError: $message code: $code exception: $e");
  }

  void onEvent(PusherEvent event) {
    log("onEvent: $event");
    var body = json.decode(event.data);
    setState(() {
      chatResponse.add(ChatMessages(
        id: "",
        senderId: body['sender_id'],
        receiverId: body['receiver_id'],
        type: body['type'],
        message: body['message'],
        status: body['status'],
        inboxId: body['inbox_id'],
        dateCreated: DateTime.now().toString(),
        dateModified: DateTime.now().toString(),
      ));
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 600),
        curve: Curves.ease,
      );
    });
  }

  void onSubscriptionSucceeded(String channelName, dynamic data) {
    log("onSubscriptionSucceeded: $channelName data: $data");
    final me = pusher.getChannel(channelName)?.me;
    log("Me: $me");
  }

  void onSubscriptionError(String message, dynamic e) {
    log("onSubscriptionError: $message Exception: $e");
  }

  void onDecryptionFailure(String event, String reason) {
    log("onDecryptionFailure: $event reason: $reason");
  }

  void onMemberAdded(String channelName, PusherMember member) {
    log("onMemberAdded: $channelName user: $member");
  }

  void onMemberRemoved(String channelName, PusherMember member) {
    log("onMemberRemoved: $channelName user: $member");
  }

  void initPusher() async {
    print("Initiated Pusher bro");
    // Remove keyboard

    try {
      await pusher.init(
        apiKey: "947662fc15ce8c1d3977",
        cluster: "us2",
        // onConnectionStateChange: onConnectionStateChange,
        // onError: onError,
        // onSubscriptionSucceeded: onSubscriptionSucceeded,
        // onEvent: onEvent,
        // onSubscriptionError: onSubscriptionError,
        // onDecryptionFailure: onDecryptionFailure,
        // onMemberAdded: onMemberAdded,
        // onMemberRemoved: onMemberRemoved,
        // authEndpoint: "<Your Authendpoint Url>",
        // onAuthorizer: onAuthorizer
      );
      await pusher.connect();
      await pusher.subscribe(
        channelName: "chat_${widget.feed.id}",
        onEvent: onEvent,
      );
    } catch (e) {
      log("ERROR: $e");
    }
  }

  fetchChats() async {
    var result =
        await _activities.fetchChatDetails(widget.feed.chatWith!.id.toString());
    print("resulttt: ${result.toString()}");
    if (result is Map<String, dynamic>) {
      print("Result: ${result["message"]}");
      showErrorToast(result["message"], context: context);
      // return ErrorModel(result.error);
    } else {
      setState(() {
        chatResponse = result as List<ChatMessages>;
        chatResponse = chatResponse.reversed.toList();
      });
    }

    // setState(() {
    //   chatResponse = result;
    //   // print(chatResponse);
    // });

    Timer(const Duration(seconds: 1), () {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 600),
        curve: Curves.ease,
      );
    });
  }

  sendSocket(Map<String, dynamic> data) {
    _activities.newSendChat(data);
    // channel.trigger("sendData", data);
  }

  bool containsEmailOrPhoneNumber(String message) {
    // Regular expressions for Nigerian phone numbers and email addresses
    final RegExp nigeriaRegExp = RegExp(r'\+?(234)?[789]\d{1,4}');
    final RegExp ukRegExp = RegExp(r'^\+(44\s?|0)\d{1,4}$');
    final RegExp emailRegExp =
        RegExp(r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b');

    // Check if the message contains a phone number or email
    return nigeriaRegExp.hasMatch(message) ||
        ukRegExp.hasMatch(message) ||
        emailRegExp.hasMatch(message);
  }

  // bool containsSensitiveInformation(String message) {
  //   // Regular expressions to match phone numbers and emails
  //   final RegExp naijphoneRegExp = RegExp(r'\+?(234)?[789]\d{9}');
  //   final RegExp ukphoneRegExp = RegExp(r'^\+(44\s?|0)\d{10,14}');
  //   final RegExp emailRegExp =
  //       RegExp(r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b');
  //
  //   // Check if the message contains a phone number or email
  //   return naijphoneRegExp.hasMatch(message) ||
  //       ukphoneRegExp.hasMatch(message) ||
  //       emailRegExp.hasMatch(message);
  // }

  // void onTriggerEventPressed() async {
  // //  var eventFormValidated = _eventFormKey.currentState!.validate();
  //
  //   // if (!eventFormValidated) {
  //   //   return;
  //   // }
  //  // SharedPreferences prefs = await SharedPreferences.getInstance();
  //  //  prefs.setString("eventName", _eventName.text);
  //  //  prefs.setString("data", _data.text);
  //   pusher.trigger(PusherEvent(
  //       channelName: _channelName.text,
  //       eventName: _eventName.text,
  //       data: _data.text));
  // }
  @override
  void initState() {
    fetchChats();
    //Initializing the TextEditingController and ScrollController
    // scrollController = ScrollController();
    initPusher();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    final messageList = Padding(
        padding: EdgeInsets.only(bottom: 100),
        child: ListView.builder(
          controller: scrollController,
          scrollDirection: Axis.vertical,
          itemCount: chatResponse.length,
          itemBuilder: (BuildContext context, int index) {
            return ChatBubble(
              message: chatResponse[index],
              authentication: _authentication,
            );
          },
        ));

    final inputBox = Positioned(
      bottom: 20,
      left: 10,
      right: 10,
      child: TextFormField(
        controller: textController,
        maxLines: null,
        keyboardType: TextInputType.multiline,
        textAlign: TextAlign.start,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          suffixIcon: Padding(
            padding: const EdgeInsets.all(12.0),
            child: GestureDetector(
              onTap: () {
                if (textController.text.isNotEmpty &&
                    containsEmailOrPhoneNumber(textController.text)) {
                  showErrorToast(
                      "You can't share phone number or email address",
                      context: context);
                } else if (textController.text.isNotEmpty &&
                    !containsEmailOrPhoneNumber(textController.text)) {
                  //Send the message as JSON data to send_message event
                  var data;

                  data = {
                    "sender_id": _authentication.currentUser.id,
                    "receiver_id": widget.feed.chatWith!.id!,
                    "message": textController.text,
                  };

                  sendSocket(data);
                  setState(() {
                    chatResponse.add(ChatMessages(
                      id: "",
                      senderId: _authentication.currentUser.id,
                      receiverId: widget.feed.chatWith!.id!,
                      message: textController.text,
                      type: "sent",
                      inboxId: "1",
                      status: "0",
                      dateModified: DateTime.now().toString(),
                      dateCreated: DateTime.now().toString(),
                    ));
                  });
                  textController.text = '';
                  //Scrolldown the list to show the latest message
                  scrollController.animateTo(
                    scrollController.position.maxScrollExtent,
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.ease,
                  );
                }
              },
              child: SvgPicture.asset(
                "assets/images/send.svg",
                height: 15,
              ),
            ),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 20.0),
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
    );

    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
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
                        Text(""),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(),
                              // CachedNetworkImage(
                              //   imageUrl:
                              //       widget.feed.chatWith!.hirersPath != null
                              //           ? widget.feed.chatWith!.hirersPath!
                              //           : "",
                              //   imageBuilder: (context, imageProvider) =>
                              //       Container(
                              //     width: 35.0,
                              //     height: 35.0,
                              //     decoration: BoxDecoration(
                              //       shape: BoxShape.circle,
                              //       image: DecorationImage(
                              //           image: imageProvider,
                              //           fit: BoxFit.contain),
                              //     ),
                              //   ),
                              //   placeholder: (context, url) =>
                              //       CircularProgressIndicator(),
                              //   errorWidget: (context, url, error) =>
                              //       CircleAvatar(
                              //     radius: 17,
                              //     backgroundColor: AppColors.grey,
                              //     child: Image.asset(
                              //       "assets/images/icon.png",
                              //       scale: 2,
                              //     ),
                              //   ),
                              // ),
                              // Container(
                              //   width: 10,
                              // ),
                              Column(
                                children: [
                                  Text(
                                    widget.feed.chatWith?.fullname ?? "",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: AppColors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Gap(5),
                                  // Text("Online")
                                ],
                              ),
                            ]),
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
                chatResponse.isNotEmpty
                    ? Flexible(
                        child: messageList,
                      )
                    : Center(
                        child: Text(
                          "There is no available chat between the users",
                          style: TextStyle(color: Colors.grey.shade400),
                        ),
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
