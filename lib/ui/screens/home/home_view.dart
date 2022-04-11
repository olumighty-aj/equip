import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:equipro/ui/screens/login/login_view_model.dart';
import 'package:equipro/utils/colors.dart';
import 'package:equipro/utils/locator.dart';
import 'package:equipro/utils/router/navigation_service.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Home> {
  final NavigationService _navigationService = locator<NavigationService>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
        viewModelBuilder: () => LoginViewModel(),
        builder: (context, model, child) {
          return Scaffold(
              key: _scaffoldKey,
              body: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(
                          height: 60,
                        ),
                        Padding(
                            padding: EdgeInsets.all(20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    _scaffoldKey.currentState!.openDrawer();
                                  },
                                  child: Icon(
                                    Icons.notes,
                                    size: 30,
                                  ),
                                ),
                                const Text(
                                  'Home',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: AppColors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            )),
                      ]
                  )));
        });
  }
}
