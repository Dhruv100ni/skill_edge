import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/icon.dart';
import 'package:flutter/src/widgets/icon_data.dart';

import '../../components/welcome.dart';
import '../Articles/articles.dart';
import '../Courses/courses.dart';


class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  // _ProfileState createState() => _ProfileState();
  State<Profile> createState() => _ProfileState();


}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {  
    return Scaffold(
        
        body: Container(
        padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
        
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              const Text(
                "Edit Profile",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                width: 130,
                height: 130,
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 4,
                        color: Theme.of(context).scaffoldBackgroundColor),
                    boxShadow: [
                      BoxShadow(
                          spreadRadius: 2,
                          blurRadius: 10,
                          color: Color.fromARGB(255, 1, 40, 73).withOpacity(0.1),
                          offset: const Offset(0, 10))
                    ],
                    shape: BoxShape.circle,
                    image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          "https://images.pexels.com/photos/462118/pexels-photo-462118.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                        ))),
              ),
              const SizedBox(
                height: 35,
              ),
              TextField(
                decoration: const InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal)),
                  hintText: 'Input Name',
                ),
                // controller: displayNameController,
                keyboardType: TextInputType.name,
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                decoration: const InputDecoration(
                  labelText: "Age",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.lightBlue)),
                  hintText: 'Input Age',
                ),
                // controller: ageController,
                //
                keyboardType: TextInputType.number,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Email: ", style: TextStyle(fontSize: 20),),
              ),
              const SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text("CANCEL",
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 2.2,
                            color: Colors.black)),
                  ),
                  TextButton(
                    onPressed: () {
                      //Insert code to update user profile
                    },
                    child: const Text(
                      "SAVE",
                      style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Colors.black),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),

    );
    
  }
}