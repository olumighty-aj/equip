import 'package:cached_network_image/cached_network_image.dart';
import 'package:equipro/core/model/ChatListModel.dart';
import 'package:equipro/ui/screens/chat/chat_view_model.dart';
import 'package:equipro/ui/screens/chat/chats_widget/chat_details.dart';
import 'package:equipro/ui/widget/chat_widget.dart';
import 'package:equipro/ui/widget/noti_widget.dart';
import 'package:equipro/utils/colors.dart';
import 'package:equipro/utils/locator.dart';
import 'package:equipro/utils/router/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app_setup.logger.dart';
import '../../../utils/app_svgs.dart';
import '../../widget/input_fields/custom_text_field.dart';
import '../profile/edit_profile.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  ChatState createState() => ChatState();
}

class ChatState extends State<Chat> {
  final NavService _navigationService = locator<NavService>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late String fcmToken;

  late bool active = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChatViewModel>.reactive(
        viewModelBuilder: () => ChatViewModel(),
        onViewModelReady: (model) => model.init(),
        builder: (context, model, child) {
          return Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              leading: CustomBackButton(),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Chat',
                    style: TextStyle(
                        fontSize: 25,
                        color: AppColors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Gap(10),
                        CustomSearchField(
                          prefixIcon: Icon(
                            Icons.search_outlined,
                            color: Colors.grey,
                          ),
                          hintText: "Search",
                        ),
                        Gap(37),
                        Builder(builder: (context) {
                          if (model.busy("Chats") && model.chats!.isEmpty) {
                            return Expanded(
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            );
                          } else if (!model.busy("Chats") &&
                              model.chats!.isEmpty) {
                            return Column(
                              children: [
                                SvgPicture.asset(AppSvgs.emptyChat),
                                Gap(40),
                                Text(model.emptyChatText ?? "No chat history"),
                              ],
                            );
                          } else {
                            // getLogger("ChatList").i(model.c)
                            return Expanded(
                              child: Column(
                                children: List.generate(
                                    model.chats!.length,
                                    (index) => ChatListTile(
                                        model: model.chats![index])),
                              ),
                            );
                          }
                        })
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class ChatListTile extends StatelessWidget {
  final ChatListModel model;
  const ChatListTile({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChatDetailsPage(feed: model)));
          },
          leading: CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: model.chatWith?.hirersPath != null
                ? model.chatWith?.hirersPath!
                : "",
            imageBuilder: (context, imageProvider) => Container(
              width: 40.0,
              height: 40.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
            ),
            placeholder: (context, url) => SizedBox(
                height: 15,
                child: CircularProgressIndicator(
                  color: AppColors.primaryColor,
                )),
            errorWidget: (context, url, error) => CircleAvatar(
              radius: 20,
              backgroundColor: AppColors.grey,
              child: SvgPicture.asset(AppSvgs.svgLogo),
            ),
          ),

          // CircleAvatar(
          //   // radius: 25,
          //   child: model.chatWith?.hirersPath != null
          //       ? Image.network(
          //           model.chatWith?.hirersPath!,
          //           fit: BoxFit.cover,
          //         )
          //       : SvgPicture.asset(
          //           AppSvgs.svgLogo,
          //           fit: BoxFit.cover,
          //         ),
          // ),
          title: Text(
            model.chatWith?.fullname ?? "",
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontWeight: FontWeight.w500),
          ),
          subtitle: Text(
            model.lastMessage ?? "",
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: Colors.grey),
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                model.dateModified != null
                    ? formatDateTime(DateTime.parse(model.dateModified!))
                    : "",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: AppColors.primaryColor),
              ),
            ],
          ),
        ),
        Gap(3),
        Divider(),
      ],
    );
  }
}

String formatDateTime(DateTime dateTime) {
  DateTime now = DateTime.now();
  DateTime today = DateTime(now.year, now.month, now.day);
  DateTime yesterday = today.subtract(Duration(days: 1));

  if (dateTime.day == today.day) {
    // Return in time format
    return dateTime.formatTimeIn12HourFormat();
  } else if (dateTime.isAtSameMomentAs(yesterday)) {
    // Return "yesterday"
    return 'Yesterday';
  } else {
    // Return in date format
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }
}
