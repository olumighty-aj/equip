import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'custom_calender_view.dart';

class CalenderPopupView extends StatefulWidget {
  final DateTime? minimumDate;
  final DateTime maximumDate;
  final bool barrierDismissible;
  final DateTime initialStartDate;
  final DateTime initialEndDate;
  final Function(DateTime, DateTime) onApplyClick;
  final Function onCancelClick;

  const CalenderPopupView(
      {Key? key,
      this.minimumDate,
      required this.maximumDate,
      required this.barrierDismissible,
      required this.initialStartDate,
      required this.initialEndDate,
      required this.onApplyClick,
      required this.onCancelClick})
      : super(key: key);
  @override
  _CalenderPopupViewState createState() => _CalenderPopupViewState();
}

class _CalenderPopupViewState extends State<CalenderPopupView>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late DateTime startDate;
  late DateTime endDate;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 400), vsync: this);
    if (widget.initialStartDate != null) {
      startDate = widget.initialStartDate;
    }
    if (widget.initialEndDate != null) {
      endDate = widget.initialEndDate;
    }
    animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Center(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: WillPopScope(
            onWillPop: () async {
              return true;
            },
            child: AnimatedBuilder(
              animation: animationController,
              builder: (BuildContext context, Widget? child) {
                return AnimatedOpacity(
                    duration: const Duration(milliseconds: 100),
                    opacity: animationController.value,
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      onTap: () {
                        if (widget.barrierDismissible) Navigator.pop(context);
                      },
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(24.0)),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    offset: const Offset(4, 4),
                                    blurRadius: 8.0),
                              ],
                            ),
                            child: InkWell(
                              borderRadius:
                                  BorderRadius.all(const Radius.circular(24.0)),
                              onTap: () {},
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Text("From",
                                                textAlign: TextAlign.left,
                                                style: textTheme.headline6!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w100,
                                                        color: Colors.grey
                                                            .withOpacity(0.8))),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            Text(
                                                startDate != null
                                                    ? DateFormat("EEE, dd MMM")
                                                        .format(startDate)
                                                    : "--/-- ",
                                                style: textTheme.headline6!
                                                    .copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  color:
                                                      const Color(0xff3E4A59),
                                                ))
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 74,
                                        width: 1,
                                        color: Colors.white,
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              "To",
                                              style: textTheme.headline6!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w100,
                                                      color: Colors.grey
                                                          .withOpacity(0.8)),
                                            ),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            Text(
                                                endDate != null
                                                    ? DateFormat("EEE, dd MMM")
                                                        .format(endDate)
                                                    : "--/-- ",
                                                style: textTheme.headline6!
                                                    .copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0xff3E4A59),
                                                )),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  const Divider(
                                    height: 1,
                                  ),
                                  CustomCalendarView(
                                    //minimumDate: widget.minimumDate,
                                    maximumDate: widget.maximumDate,
                                    initialEndDate: widget.initialEndDate,
                                    initialStartDate: widget.initialStartDate,
                                    startEndDateChange: (DateTime startDateData,
                                        DateTime endDateData) {
                                      setState(() {
                                        startDate = startDateData;
                                        endDate = endDateData;
                                      });
                                    },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16,
                                        right: 16,
                                        bottom: 16,
                                        top: 8),
                                    child: Container(
                                      height: 48,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(24.0)),
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.6),
                                            blurRadius: 8,
                                            offset: Offset(4, 4),
                                          ),
                                        ],
                                      ),
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(24.0)),
                                          highlightColor: Colors.transparent,
                                          onTap: () {
                                            try {
                                              // animationController.reverse().then((f) {

                                              // });
                                              widget.onApplyClick(
                                                  startDate, endDate);
                                              Navigator.pop(context);
                                            } catch (e) {}
                                          },
                                          child: Center(
                                            child: Text("Apply",
                                                style: textTheme.headline4!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.white)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ));
              },
            ),
          ),
        ),
      ),
    );
  }
}
