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
      )


      );
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 600),
        curve: Curves.ease,
      );
    }

      );
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
    // Remove keyboard

    try {
      await pusher.init(
        apiKey: "947662fc15ce8c1d3977",
        cluster: "us2",
        onConnectionStateChange: onConnectionStateChange,
        onError: onError,
        onSubscriptionSucceeded: onSubscriptionSucceeded,
        onEvent: onEvent,
        onSubscriptionError: onSubscriptionError,
        onDecryptionFailure: onDecryptionFailure,
        onMemberAdded: onMemberAdded,
        onMemberRemoved: onMemberRemoved,
        // authEndpoint: "<Your Authendpoint Url>",
        // onAuthorizer: onAuthorizer
      );
      await pusher.subscribe(channelName: "chat_${widget.feed.id}");
      await pusher.connect();
    } catch (e) {
      log("ERROR: $e");
    }
  }

  fetchChats() async {
    var result = await _activities.fetchChat(widget.feed.chatWith!.id.toString());
    if (result is ErrorModel) {
      showErrorToast(result.error);
      return ErrorModel(result.error);
    }

    setState(() {
      chatResponse = result;
      // print(chatResponse);
    });

    Timer(const Duration(seconds: 1), () {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 600),
        curve: Curves.ease,
      );
    });
  }

  sendSocket(Map<String, dynamic> data) {
    _activities.sendChat(data);
    // channel.trigger("sendData", data);
  }

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
    scrollController = ScrollController();
    initPusher();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    final messageList =
    Padding(padding: EdgeInsets.only(bottom: 100),child:
    ListView.builder(
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
      child: Container(
        color: Colors.white,
        height: 60.0,
        child: TextFormField(
          controller: textController,
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
                      onTap: () {
                        if (textController.text.isNotEmpty) {
                          //Send the message as JSON data to send_message event
                          var data;

                          data = {
                            "sender_id": _authentication.currentUser.id,
                            "receiver_id": widget.feed.chatWith!.id!,
                            "message": textController.text,
                          };

                          sendSocket(data);
                          // setState(() {
                          //   chatResponse.add(ChatMessages(
                          //     id: "",
                          //     senderId: _authentication.currentUser.id,
                          //     receiverId: widget.feed.chatWith!.id!,
                          //     message: textController.text,
                          //     type: "sent",
                          //     inboxId: "1",
                          //     status: "0",
                          //     dateModified: DateTime.now().toString(),
                          //     dateCreated: DateTime.now().toString(),
                          //   ));
                          // });
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
                        Text(""),
                      Row(
                    //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CachedNetworkImage(
                          imageUrl:  widget.feed.chatWith!.hirersPath != null
                              ?  widget.feed.chatWith!.hirersPath!
                              : "",
                          imageBuilder: (context, imageProvider) => Container(
                            width: 35.0,
                            height: 35.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.contain),
                            ),
                          ),
                          placeholder: (context, url) => CircularProgressIndicator(),
                          errorWidget: (context, url, error) => CircleAvatar(
                            radius: 17,
                            backgroundColor: AppColors.grey,
                            child: Image.asset(
                              "assets/images/icon.png",
                              scale: 2,
                            ),
                          ),
                        ),
                        Container(
                          width: 10,
                        ),

                        Text(
                          widget.feed.chatWith!.fullname!,
                          style: TextStyle(
                              fontSize: 20,
                              color: AppColors.black,
                              fontWeight: FontWeight.bold),
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
                chatResponse.isNotEmpty?
                Flexible(
                  child: messageList,
                ):Container(
                  child: Text("Loading....",style: TextStyle(color: Colors.red),),
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
