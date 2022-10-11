import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skill_edge/components/background.dart';
import 'package:skill_edge/components/rounded_button.dart';

class Body extends StatelessWidget {
  const Body({super.key});
  

  @override
  Widget build(BuildContext context){
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            "Skill Edge",
            style: TextStyle(fontWeight: FontWeight.bold),
          ), 
          SvgPicture.asset(
            "assets/icons/chat.svg",
            height: size.height * 0.45,),
          RoundedButton(
            text: 'LOGIN',
            press: () {},
          ),
        ],
        ),
    );
  }
}  