import 'package:calculator_app/logic.dart';
import 'package:calculator_app/theme/dark_light_mode.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  int themeMode = 0;
  @override
  Widget build(BuildContext context) {
    double btnSpacingW = MediaQuery.of(context).size.width / 375 * 16;
    if (btnSpacingW > 16) {
      btnSpacingW = 16;
    }
    double btnSpacingH = MediaQuery.of(context).size.width / 812 * 16;
    if (btnSpacingH > 16) {
      btnSpacingH = 16;
    }
    double btnWidth =
        (MediaQuery.of(context).size.width
            // padding 2 sides, left 20 right 20
            -
            2 * 20
            // 3 space between buttons (btnSpacingW)
            -
            4 * btnSpacingW)
        // 4 buttons
        /
        4;
    double btnHeight =
        (MediaQuery.of(context).size.height -
            16 - // top theme toggle
            32 - // toggle
            16 -
            40 - // history
            16 -
            90 - // current calc
            16 -
            4 * btnSpacingH -
            32 // bottom space
            ) /
        5;
    double btnBoxHeight =
        MediaQuery.of(context).size.height -
        16 -
        32 -
        16 -
        40 -
        16 -
        90 -
        16 -
        48;
    return Scaffold(
      backgroundColor: darkLight[themeMode][0],
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 16, 20, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // theme toggle
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      themeMode == 0
                          ? setState(() {
                              themeMode = 1;
                            })
                          : setState(() {
                              themeMode = 0;
                            });
                    },
                    child: Container(
                      width: 72,
                      height: 32,
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: darkLight[themeMode][4],
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // sun icon
                          if (themeMode == 1)
                            Padding(
                              padding: EdgeInsets.only(left: 4),
                              child: Icon(
                                Icons.light_mode_outlined,
                                color: darkLight[1][2],
                                size: 24,
                              ),
                            ),
                          // the circle thing
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: darkLight[themeMode][3],
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          // moon icon
                          if (themeMode == 0)
                            Padding(
                              padding: EdgeInsets.only(left: 4),
                              child: Icon(
                                Icons.dark_mode_outlined,
                                color: darkLight[0][2],
                                size: 24,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              // calculator history
              Expanded(
                child: SingleChildScrollView(
                  reverse: true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: history
                        .map(
                          (entry) => Text(
                            entry,
                            style: GoogleFonts.workSans(
                              color: darkLight[themeMode][1].withAlpha(40),
                              fontSize: 40,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
              SizedBox(height: 16),
              // current calculator
              SizedBox(
                height: 96,
                child: FittedBox(
                  child: Text(
                    display.isEmpty ? '_' : display,
                    style: GoogleFonts.workSans(
                      color: darkLight[themeMode][1],
                      fontSize: 96,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 16),
              // buttons
              Container(
                height: btnBoxHeight,
                constraints: BoxConstraints(maxHeight: 424),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // clear current calc
                        Btn(
                          btnWidth: btnWidth,
                          btnHeight: btnHeight,
                          color: darkLight[themeMode][3],
                          child: BtnChild(themeMode, text: 'C'),
                          func: () {
                            delete();
                            setState(() {});
                          },
                        ),
                        // positive negative number state
                        Btn(
                          btnWidth: btnWidth,
                          btnHeight: btnHeight,
                          color: darkLight[themeMode][3],
                          child: Image.asset(
                            'assets/numberState.png',
                            fit: BoxFit.fill,
                            height: 32,
                            width: 32,
                            color: darkLight[themeMode][1],
                          ),
                          func: () {
                            toggleSign();
                            setState(() {});
                          },
                        ),
                        // percentage
                        Btn(
                          btnWidth: btnWidth,
                          btnHeight: btnHeight,
                          color: darkLight[themeMode][3],
                          child: BtnChild(themeMode, text: '%'),
                          func: () {
                            percentage();
                            setState(() {});
                          },
                        ),
                        // divide
                        Btn(
                          btnWidth: btnWidth,
                          btnHeight: btnHeight,
                          color: darkLight[themeMode][2],
                          child: BtnChild(0, text: '÷'),
                          func: () {
                            division();
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // 7
                        Btn(
                          btnWidth: btnWidth,
                          btnHeight: btnHeight,
                          color: darkLight[themeMode][4],
                          child: BtnChild(themeMode, text: '7'),
                          func: () {
                            number(7);
                            setState(() {});
                          },
                        ),
                        // 8
                        Btn(
                          btnWidth: btnWidth,
                          btnHeight: btnHeight,
                          color: darkLight[themeMode][4],
                          child: BtnChild(themeMode, text: '8'),
                          func: () {
                            number(8);
                            setState(() {});
                          },
                        ),
                        // 9
                        Btn(
                          btnWidth: btnWidth,
                          btnHeight: btnHeight,
                          color: darkLight[themeMode][4],
                          child: BtnChild(themeMode, text: '9'),
                          func: () {
                            number(9);
                            setState(() {});
                          },
                        ),
                        // multiply
                        Btn(
                          btnWidth: btnWidth,
                          btnHeight: btnHeight,
                          color: darkLight[themeMode][2],
                          child: BtnChild(0, text: 'x'),
                          func: () {
                            multiplication();
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // 4
                        Btn(
                          btnWidth: btnWidth,
                          btnHeight: btnHeight,
                          color: darkLight[themeMode][4],
                          child: BtnChild(themeMode, text: '4'),
                          func: () {
                            number(4);
                            setState(() {});
                          },
                        ),
                        // 5
                        Btn(
                          btnWidth: btnWidth,
                          btnHeight: btnHeight,
                          color: darkLight[themeMode][4],
                          child: BtnChild(themeMode, text: '5'),
                          func: () {
                            number(5);
                            setState(() {});
                          },
                        ),
                        // 6
                        Btn(
                          btnWidth: btnWidth,
                          btnHeight: btnHeight,
                          color: darkLight[themeMode][4],
                          child: BtnChild(themeMode, text: '6'),
                          func: () {
                            number(6);
                            setState(() {});
                          },
                        ),
                        // minus
                        Btn(
                          btnWidth: btnWidth,
                          btnHeight: btnHeight,
                          color: darkLight[themeMode][2],
                          child: BtnChild(0, text: '-'),
                          func: () {
                            subtraction();
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // 1
                        Btn(
                          btnWidth: btnWidth,
                          btnHeight: btnHeight,
                          color: darkLight[themeMode][4],
                          child: BtnChild(themeMode, text: '1'),
                          func: () {
                            number(1);
                            setState(() {});
                          },
                        ),
                        // 2
                        Btn(
                          btnWidth: btnWidth,
                          btnHeight: btnHeight,
                          color: darkLight[themeMode][4],
                          child: BtnChild(themeMode, text: '2'),
                          func: () {
                            number(2);
                            setState(() {});
                          },
                        ),
                        // 3
                        Btn(
                          btnWidth: btnWidth,
                          btnHeight: btnHeight,
                          color: darkLight[themeMode][4],
                          child: BtnChild(themeMode, text: '3'),
                          func: () {
                            number(3);
                            setState(() {});
                          },
                        ),
                        // plus
                        Btn(
                          btnWidth: btnWidth,
                          btnHeight: btnHeight,
                          color: darkLight[themeMode][2],
                          child: BtnChild(0, text: '+'),
                          func: () {
                            addition();
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // dot
                        Btn(
                          btnWidth: btnWidth,
                          btnHeight: btnHeight,
                          color: darkLight[themeMode][4],
                          child: BtnChild(themeMode, text: '.'),
                          func: () {
                            decimal();
                            setState(() {});
                          },
                        ),
                        // 0
                        Btn(
                          btnWidth: btnWidth,
                          btnHeight: btnHeight,
                          color: darkLight[themeMode][4],
                          child: BtnChild(themeMode, text: '0'),
                          func: () {
                            number(0);
                            setState(() {});
                          },
                        ),
                        // backspace
                        Btn(
                          btnWidth: btnWidth,
                          btnHeight: btnHeight,
                          color: darkLight[themeMode][4],
                          child: BtnChild(
                            themeMode,
                            icon: Icons.backspace_outlined,
                          ),
                          func: () {
                            backspace();
                            setState(() {});
                          },
                        ),
                        // equal
                        Btn(
                          btnWidth: btnWidth,
                          btnHeight: btnHeight,
                          color: darkLight[themeMode][2],
                          child: BtnChild(0, text: '='),
                          func: () {
                            equal();
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Btn extends StatelessWidget {
  const Btn({
    super.key,
    required this.btnWidth,
    required this.btnHeight,
    required this.color,
    required this.child,
    required this.func,
  });

  final double btnWidth;
  final double btnHeight;
  final Color color;
  final Widget child;
  final GestureTapCallback func;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: func,
      child: Container(
        width: btnWidth,
        height: btnHeight,
        constraints: BoxConstraints(maxHeight: 72),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Center(child: FittedBox(child: child)),
      ),
    );
  }
}

class BtnChild extends StatelessWidget {
  const BtnChild(this.themeMode, {super.key, this.text = '', this.icon});

  final String text;
  final int themeMode;
  final IconData? icon;
  @override
  Widget build(BuildContext context) {
    if (text.isNotEmpty) {
      return Text(
        text,
        style: GoogleFonts.workSans(
          color: darkLight[themeMode][1],
          fontSize: 32,
        ),
      );
    } else {
      return Icon(icon, color: darkLight[themeMode][1], size: 32);
    }
  }
}
