import "package:flutter/material.dart";

class NavigationText extends StatelessWidget {
  final String opt;
  final bool blacked;
  const NavigationText({super.key, required this.opt, required this.blacked});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print("/${opt.toLowerCase()}");
        Navigator.pushNamed(context, "/${opt.toLowerCase()}");
      },
      child: Container(
        decoration: BoxDecoration(
            color: blacked ? Colors.black : Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12.0),
          child: Text(
            opt,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: blacked ? Colors.white : Colors.black),
          ),
        ),
      ),
    );
  }
}

class NavigationMenu extends StatelessWidget {
  final int ind;
  const NavigationMenu({super.key, required this.ind});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      height: 40,
      constraints: const BoxConstraints(maxWidth: 600),
      // ignore: prefer_const_literals_to_create_immutables
      child: Row(children: [
        NavigationText(opt: "Home", blacked: ind == 0),
        const Spacer(),
        NavigationText(opt: "Courses", blacked: ind == 1),
        const Spacer(),
        NavigationText(opt: "Articles", blacked: ind == 2),
        const Spacer(),
        NavigationText(opt: "Profile", blacked: ind == 3),
      ]),
    );
  }
}
