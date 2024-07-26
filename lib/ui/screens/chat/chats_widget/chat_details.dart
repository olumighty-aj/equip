import 'dart:async';
import 'dart:convert';

import 'package:equipro/core/model/chat_list/chat_list.dart';
import 'package:equipro/core/model/chat_messages.dart';
import 'package:equipro/core/services/activities_service.dart';
import 'package:equipro/core/services/auth_service.dart';
import 'package:equipro/ui/screens/chat/chats_widget/chat_bubble.dart';
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
  final Activities _activities = locator<Activities>();
  List<ChatMessages> chatResponse = [];

  log(String text) {
    print("LOG: $text");
    setState(() {
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
    var result = await _activities.newFetchChatDetails(
        senderId: widget.feed.user_id,
        receiverId: widget.feed.chat_with_id.toString());
    logger.i(
        "Receiver ID ${widget.feed.chat_with!.id.toString()}, Sender ID ${_authentication.currentUser.id}");
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
    final newMessageList = GroupedListView<ChatMessages, DateTime>(
        controller: scrollController,
        physics: BouncingScrollPhysics(
            decelerationRate: ScrollDecelerationRate.fast),
        useStickyGroupSeparators: true,
        shrinkWrap: true,
        elements: chatResponse,
        groupBy: (type) => DateTime.parse(type.date_created!).toDateTimeDate(),
        groupComparator: (group1, group2) => group1.compareTo(group2),
        itemComparator: (item1, item2) => DateTime.parse(item1.date_created!)
            .toDate()
            .compareTo(DateTime.parse(item2.date_created!).toDate()),
        groupSeparatorBuilder: (DateTime date) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              getDateSeparator(date),
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Colors.grey.shade500),
            ),
          );
        },
        order: GroupedListOrder.ASC,
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
                print("ID: ${widget.feed.chat_with!.id}");
                data = {
                  "sender_id": widget.feed.user_id,
                  "receiver_id": widget.feed.chat_with_id,
                  "message": textController.text,
                };

                sendSocket(data);
                setState(() {
                  chatResponse.add(ChatMessages(
                    id: "",
                    sender_id: _authentication.currentUser.id,
                    receiver_id: widget.feed.chat_with!.id,
                    message: textController.text,
                    type: "sent",
                    inbox_id: "1",
                    status: "0",
                    date_modified: DateTime.now().toString(),
                    date_created: DateTime.now().toString(),
                  ));
                });
                textController.clear();
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
      onChanged: (value) {},
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
                      Text(widget.feed.chat_with?.fullname ?? "",
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
                                "Ask ${widget.feed.chat_with!.fullname} a question"),
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
