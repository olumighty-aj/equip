import 'package:equipro/ui/screens/hirer/active_rentals/rentals_view_model.dart';
import 'package:equipro/ui/widget/base_button.dart';
import 'package:equipro/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:stacked/stacked.dart';

class Rating extends StatefulWidget {
  final String id;
  const Rating({Key? key, required this.id}) : super(key: key);

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Rating> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  double? rate = 1;
  TextEditingController commentController = TextEditingController();
  AnimationController? _navController;
  @override
  void initState() {
    super.initState();
    _navController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _navController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RentalsViewModel>.reactive(
        viewModelBuilder: () => RentalsViewModel(),
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
                                  Text(
                                    "Return Successful",
                                    style: TextStyle(
                                        color: AppColors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Text(
                                    "Thank you for returning this equipment",
                                    style: TextStyle(
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Text(
                                    "Rate this equipment you hired:",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18),
                                  ),
                                  SizedBox(
                                    height: 50,
                                  ),
                                  Center(
                                      child: FittedBox(
                                          child: SmoothStarRating(
                                              defaultIconData:
                                                  Icons.star_outline_rounded,
                                              allowHalfRating: true,
                                              onRated: (v) {
                                                rate = v;
                                              },
                                              starCount: 5,
                                              rating: rate!,
                                              size: 70,
                                              isReadOnly: false,
                                              filledIconData:
                                                  Icons.star_rounded,
                                              halfFilledIconData:
                                                  Icons.star_half_rounded,
                                              color: Color(0xffF6DF08),
                                              borderColor: Colors.grey,
                                              spacing: 0.5))),
                                  SizedBox(
                                    height: 50,
                                  ),
                                  TextFormField(
                                    maxLines: 4,
                                    controller: commentController,
                                    decoration: InputDecoration(
                                      hintText: 'Comment goes here',
                                      hintStyle: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                      focusedBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4)),
                                        borderSide: BorderSide(
                                            width: 1, color: Colors.grey),
                                      ),
                                      disabledBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4)),
                                        borderSide: BorderSide(
                                            width: 1, color: Colors.grey),
                                      ),
                                      enabledBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4)),
                                        borderSide: BorderSide(
                                            width: 1, color: Colors.grey),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        borderSide: const BorderSide(),
                                      ),
                                    ),
                                    keyboardType: TextInputType.emailAddress,
                                    style: const TextStyle(color: Colors.black),
                                    cursorColor: Colors.black,
                                  ),
                                  SizedBox(
                                    height: 50,
                                  ),
                                  BaseButton(
                                      onPressed: () {
                                        model.giveFeedback(
                                            widget.id,
                                            commentController.text,
                                            rate!,
                                            context);
                                      },
                                      isBusy: model.busy("feedback"),
                                      label: "Submit")
                                ]))))),
          );
        });
  }
}
