import 'dart:async';
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:equipro/core/model/ChatListModel.dart';
import 'package:equipro/core/model/ChatMessages.dart';
import 'package:equipro/core/model/error_model.dart';
import 'package:equipro/core/services/activities_service.dart';
import 'package:equipro/core/services/auth_service.dart';
import 'package:equipro/ui/screens/chat/chats_widget/chat_bubble.dart';
import 'package:equipro/ui/widget/noti_widget.dart';
import 'package:equipro/utils/colors.dart';
import 'package:equipro/utils/extensions.dart';
import 'package:equipro/utils/helpers.dart';
import 'package:equipro/utils/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../app/app_setup.logger.dart';
import '../../../../utils/app_svgs.dart';

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
  final logger = getLogger("ChatDetails");
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
    logger.i("Connection: $currentState");
  }

  void onError(String message, int? code, dynamic e) {
    logger.e("onError: $message code: $code exception: $e");
  }

  onEvent(event) {
    fetchChats();
    logger.i("This is event");
    // logger.i("onEvent: $event");
    // var body = json.decode(event.data);
    // setState(() {
    // chatResponse.add(ChatMessages(
    //   id: "",
    //   senderId: body['sender_id'],
    //   receiverId: body['receiver_id'],
    //   type: body['type'],
    //   message: body['message'],
    //   status: body['status'],
    //   inboxId: body['inbox_id'],
    //   dateCreated: DateTime.now().toString(),
    //   dateModified: DateTime.now().toString(),
    // ));
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 600),
      curve: Curves.ease,
    );
    return "hi";
    // });
  }

  void onSubscriptionSucceeded(String channelName, dynamic data) {
    // logger.i("onSubscriptionSucceeded: $channelName data: $data");
    logger.i("ChannelName: $channelName");
    final me = pusher.getChannel(channelName)?.members;
    logger.i("Me: $me");
  }

  void onTriggerEventPressed() async {
    logger.i("Trigger Event");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("eventName", "chat_${widget.feed.id}");
    prefs.setString("data", jsonEncode(widget.feed.toJson()));
    pusher.trigger(PusherEvent(
        channelName: "chat_${widget.feed.id}",
        eventName: "chat_${widget.feed.id}",
        data: jsonEncode(widget.feed.toJson())));
  }

  void onSubscriptionError(String message, dynamic e) {
    logger.e("onSubscriptionError: $message Exception: $e");
  }

  void onDecryptionFailure(String event, String reason) {
    log("onDecryptionFailure: $event reason: $reason");
  }

  void onMemberAdded(String channelName, PusherMember member) {
    fetchChats();
    logger.i("onMemberAdded: $channelName user: $member");
  }

  void onMemberRemoved(String channelName, PusherMember member) {
    logger.i("onMemberRemoved: $channelName user: $member");
  }

  void initPusher() async {
    print("Initiated Pusher bro");
    // Remove keyboard

    try {
      await pusher.init(
        // apiKey: "947662fc15ce8c1d3977",
        apiKey: "93cf69dd2067be15f82e",
        cluster: "us2",
        onConnectionStateChange: onConnectionStateChange,
        onError: onError,
        onSubscriptionSucceeded: onSubscriptionSucceeded,
        onEvent: onEvent,
        onSubscriptionError: onSubscriptionError,
        // onDecryptionFailure: onDecryptionFailure,

        onMemberAdded: onMemberAdded,
        onMemberRemoved: onMemberRemoved,
        // authEndpoint: "<Your Authendpoint Url>",
        // onAuthorizer: onAuthorizer
      );
      await pusher.connect().then((value) => logger.i("Connected"));

      logger.i("Subscribing");
      await pusher
          .subscribe(
              channelName: "chat_${widget.feed.id}",
              onEvent: onEvent,
              onSubscriptionError: (error) {
                logger.e("error: $error");
              })
          .then((value) => value.onSubscriptionSucceeded!(fetchChats()));
      // channel.onMemberAdded(PusherMember(userId, userInfo))

      // channel.trigger(PusherEvent(channelName: channelName, eventName: eventName));
      logger.i("Done Subscribing");
    } catch (e) {
      logger.e("e: $e");
    }
  }

  fetchChats() async {
    logger.i("Chat To Json: ${widget.feed.toJson()}");
    var result = await _activities.newFetchChatDetails(
        senderId: widget.feed.userId,
        receiverId: widget.feed.chatWithId.toString());
    logger.i(
        "Receiver ID ${widget.feed.chatWith!.id.toString()}, Sender ID ${_authentication.currentUser.id}");
    print("resulttt: ${result.toString()}");
    if (result is Map<String, dynamic>) {
      print("Result: ${result["message"]}");
      // showErrorToast(result["message"], context: context);
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
    pusher.trigger(PusherEvent(
        channelName: "chat_${widget.feed.id}", eventName: "chat", data: data));
  }

  listener() {}

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

  String getDateSeparator(DateTime date) {
    if (date.isToday()) {
      return "Today";
    } else if (date.isYesterday()) {
      return "Yesterday";
    } else {
      return date.toDate();
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    final messageList = ListView.builder(
      controller: scrollController,
      scrollDirection: Axis.vertical,
      itemCount: chatResponse.length,
      itemBuilder: (BuildContext context, int index) {
        return ChatBubble(
          message: chatResponse[index],
          authentication: _authentication,
        );
      },
    );

    final newMessageList = GroupedListView<ChatMessages, String>(
        controller: scrollController,
        physics: BouncingScrollPhysics(
            decelerationRate: ScrollDecelerationRate.fast),
        useStickyGroupSeparators: true,
        shrinkWrap: true,
        elements: chatResponse,
        groupBy: (type) => DateTime.parse(type.dateModified!).toDate(),
        groupComparator: (group1, group2) => group1.compareTo(group2),
        itemComparator: (item1, item2) => DateTime.parse(item1.dateModified!)
            .toDate()
            .compareTo(DateTime.parse(item2.dateModified!).toDate()),
        groupSeparatorBuilder: (String date) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              getDateSeparator(date.parseDateString()),
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Colors.grey.shade500),
            ),
          );
        },
        indexedItemBuilder: (context, ChatMessages model, index) {
          return ChatBubble(
            message: model,
            authentication: _authentication,
          );
        });

    final inputBox = TextFormField(
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
                showErrorToast("You can't share phone number or email address",
                    context: context);
              } else if (textController.text.isNotEmpty &&
                  !containsEmailOrPhoneNumber(textController.text)) {
                //Send the message as JSON data to send_message event
                var data;
                print("ID: ${widget.feed.chatWith!.id}");
                data = {
                  "sender_id": widget.feed.userId,
                  "receiver_id": widget.feed.chatWithId,
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
    );

    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
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
                  Column(
                    children: [
                      Text(widget.feed.chatWith?.fullname ?? "",
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                  fontSize: 20, fontWeight: FontWeight.w600)),
                      Gap(5),
                      // Text("Online")
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Divider(
                    thickness: 4,
                  ),
                  // appBar,
                  chatResponse.isNotEmpty
                      ? Flexible(
                          child: newMessageList,
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Gap(100),
                            SvgPicture.asset(AppSvgs.emptyChat),
                            Gap(10),
                            Text(
                                "Ask ${widget.feed.chatWith!.fullname} a question"),
                          ],
                        )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: inputBox,
          )
        ],
      ),
    );
  }
}
