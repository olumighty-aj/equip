import 'package:equipro/core/model/EquipmentModel.dart';
import 'package:equipro/ui/screens/drawer.dart';
import 'package:equipro/ui/screens/owner/home_owner/home_view_model.dart';
import 'package:equipro/ui/widget/booking_request.dart';
import 'package:equipro/ui/widget/dash_painter.dart';
import 'package:equipro/ui/widget/general_button.dart';
import 'package:equipro/utils/locator.dart';
import 'package:equipro/utils/router/navigation_service.dart';
import 'package:equipro/utils/router/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:equipro/utils/colors.dart';

class EquipOwnerDetails extends StatefulWidget {
  final EquipmentModel model;
  const EquipOwnerDetails({Key? key, required this.model}) : super(key: key);

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<EquipOwnerDetails>
    with TickerProviderStateMixin {
  final NavigationService _navigationService = locator<NavigationService>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int? selectedQuantity;
  String? pickupTime = DateTime.now().toString();
  String? selectedDate;
  String? selectedWeek;
  TextEditingController emailController = TextEditingController();
  AnimationController? _navController;
  Animation<Offset>? _navAnimation;

  displayDialog(BuildContext context, HomeOwnerViewModel model) {
    return showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(15),
        ),
        content: Container(
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Delete Equipment?",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 100,
                      child: GeneralButton(
                        splashColor: AppColors.grey,
                        buttonTextColor: AppColors.black,
                        buttonText: 'No',
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Container(
                      width: 100,
                      child: GeneralButton(
                        buttonText: 'Yes',
                        onPressed: () {
                          Navigator.pop(context);
                          model.deleteEquip(widget.model.id.toString());
                        },
                      ),
                    ),
                  ],
                )
              ],
            )),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _navController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..forward();
    _navAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.99),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _navController!,
      curve: Curves.easeIn,
    ));
  }

  @override
  void dispose() {
    _navController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeOwnerViewModel>.reactive(
        viewModelBuilder: () => HomeOwnerViewModel(),
        builder: (context, model, child) {
          return Scaffold(
            key: _scaffoldKey,
            body: SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.all(20),
                    child: AnimationLimiter(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: AnimationConfiguration.toStaggeredList(
                                duration: const Duration(milliseconds: 200),
                                childAnimationBuilder: (widget) =>
                                    SlideAnimation(
                                      horizontalOffset:
                                          -MediaQuery.of(context).size.width /
                                              4,
                                      child: FadeInAnimation(
                                          curve: Curves.fastOutSlowIn,
                                          child: widget),
                                    ),
                                children: [
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                          //  margin: EdgeInsets.all(20),
                                          padding: EdgeInsets.only(left: 8),
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            color: AppColors.white,
                                          ),
                                          child: InkWell(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Icon(
                                                Icons.arrow_back_ios,
                                                color: AppColors.primaryColor,
                                              )))
                                    ],
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        widget.model.equipName!,
                                        style: TextStyle(
                                            color: AppColors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25),
                                      ),
                                      PopupMenuButton<int>(
                                        offset: Offset(10, 10),
                                        child: SvgPicture.asset(
                                            "assets/images/more.svg"),
                                        onSelected: (int selectedValue) async {
                                          switch (selectedValue) {
                                            case 0:
                                              _navigationService.navigateTo(
                                                  EditEquipmentRoute,
                                                  arguments: widget.model);
                                              break;
                                            case 1:
                                              displayDialog(context, model);
                                              break;
                                            default:
                                          }
                                        },
                                        itemBuilder: (context) => [
                                          PopupMenuItem(
                                            value: 0,
                                            child: Text(
                                              "Edit Details",
                                            ),
                                          ),
                                          PopupMenuItem(
                                              value: 1,
                                              child: Text(
                                                "Delete",
                                              )),
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${widget.model.costOfHire} per ${widget.model.costOfHireInterval == "1" ? "Day" : widget.model.costOfHireInterval == "7" ? "Week" : "Month"}",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: AppColors.green,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "QTY Available: ${widget.model.quantity!}",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ]),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "Description:",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    widget.model.description!,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 15),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Text(
                                    "Availability: ${DateFormat(
                                      "y-MM-dd",
                                    ).format(DateTime.parse(widget.model.availFrom!)).toString()} - ${DateFormat(
                                      "y-MM-dd",
                                    ).format(DateTime.parse(widget.model.availTo!)).toString()}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  CustomPaint(painter: LineDashedPainter()),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "Booking requests (${widget.model.equipRequest != null ? widget.model.equipRequest.toString() : "0"})",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  widget.model
                                      .equipRequest != null
                                      ? Container(
                                      height: 70.0,
                                      child: Container(
                                        child: ListView.builder(
                                            itemCount: widget
                                                .model
                                                .equipRequest!
                                                .length,
                                            scrollDirection:
                                            Axis.horizontal,
                                            itemBuilder: (context, i) {
                                              return  BookingRequest(
                                                feed: widget
                                                    .model
                                                    .equipRequest![i],
                                              );
                                            }),
                                      ))
                                      : Container(
                                    child: Text(
                                      "Not available",
                                    ),
                                  ),
                                ]))))),
            drawer: CollapsingNavigationDrawer(),
          );
        });
  }
}
