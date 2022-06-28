
import 'package:equipro/core/model/ChatListModel.dart';
import 'package:equipro/ui/screens/chat/chat_view_model.dart';
import 'package:equipro/ui/widget/chat_widget.dart';
import 'package:equipro/utils/colors.dart';
import 'package:equipro/utils/locator.dart';
import 'package:equipro/utils/router/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stacked/stacked.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Chat> {
  final NavigationService _navigationService = locator<NavigationService>();
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
        builder: (context, model, child) {
          return Scaffold(
            key: _scaffoldKey,
            body:   Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    height: 60,
                  ),
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
                   SizedBox(height: 20,),
                   Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Chat',
                            style: TextStyle(
                                fontSize: 25,
                                color: AppColors.black,
                                fontWeight: FontWeight.bold),
                          ),
                         SvgPicture.asset("assets/images/more.svg"),
                          // SvgPicture.asset(
                          //   "assets/images/sort.svg",
                          //   width: 23.0,
                          // ),
                        ],
                      ),
                 
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                      height: 60.0,
                      child: TextFormField(
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.search_outlined,color: Colors.grey,
                            size: 30,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 2.0, horizontal: 20.0),
                          hintText: "Search",
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
                          setState(() {
                            // searchWord = value;
                            // print(searchWord);
                          });
                        },
                      ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  Expanded(
                    //  height: Responsive.height(context) / 1.3,
                    child: FutureBuilder<
                        List<ChatListModel>>(
                        future: model
                            .chatList(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Container(
                                height: 400,
                                padding:
                                EdgeInsets.only(
                                    left: 20.0,
                                    right: 20),
                                child: Center(
                                  child: Shimmer
                                      .fromColors(
                                      direction:
                                      ShimmerDirection
                                          .ltr,
                                      period: Duration(
                                          seconds:
                                          2),
                                      child:
                                      ListView(
                                        scrollDirection:
                                        Axis.vertical,
                                        // shrinkWrap: true,
                                        children: [
                                          0,
                                          1,
                                          2,
                                          3
                                        ]
                                            .map((_) =>
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Container(
                                                          width: double.infinity,
                                                          height: 8.0,
                                                          color: Colors.white,
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                                                        ),
                                                        Container(
                                                          width: double.infinity,
                                                          height: 8.0,
                                                          color: Colors.white,
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                                                        ),
                                                        Container(
                                                          width: 40.0,
                                                          height: 8.0,
                                                          color: Colors.white,
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ))
                                            .toList(),
                                      ),
                                      baseColor:
                                      AppColors
                                          .grey,
                                      highlightColor:
                                      Colors
                                          .white),
                                ));
                          } else if (snapshot
                              .data!.isNotEmpty) {
                            return ListView(
                                scrollDirection:
                                Axis.vertical,
                                // shrinkWrap: true,
                                children: snapshot
                                    .data!
                                    .map((feed) => InkWell(
                                    onTap: () {},
                                    child: Padding(
                                        padding:
                                        EdgeInsets.all(
                                            5),
                                        child:
                                        ChatItem(model: feed,))))
                                    .toList());
                          } else if (snapshot
                              .hasError) {
                            return Center(
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: 100,
                                    ),
                                    Text(
                                      'Network error',
                                      style: TextStyle(
                                        fontWeight:
                                        FontWeight
                                            .bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text('Network error'),
                                    SizedBox(
                                      height: 100,
                                    ),
                                  ],
                                ));
                          } else {
                            return Center(
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment
                                      .center,
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "You don't have any chat yet",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight:
                                          FontWeight
                                              .bold,
                                          color: AppColors
                                              .black),
                                      textAlign: TextAlign
                                          .center,
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                  ],
                                ));
                          }
                        }),
                  ),
                  //
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  // ChatItem(
                  //   onPressed: (){
                  //     _navigationService.navigateTo(chatDetailsPageRoute);
                  //   },
                  //
                  // ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  // ChatItem(
                  //   onPressed: (){
                  //     _navigationService.navigateTo(chatDetailsPageRoute);
                  //   },
                  //
                  // ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  // ChatItem(
                  //   onPressed: (){
                  //     _navigationService.navigateTo(chatDetailsPageRoute);
                  //   },
                  //
                  // ),
                ],
              ),
            ),
          );
        });
  }
}
