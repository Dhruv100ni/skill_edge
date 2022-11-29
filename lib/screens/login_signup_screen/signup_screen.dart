import '/services/firebase_auth_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '/widgets/customized_button.dart';
import '/widgets/customized_textfield.dart';
import '/widgets/customized_textfield2.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

String _selectedBranch = "Select Branch";
var branch = {'Select Branch' : 'SB','BTech': 'BT', 'MTech': 'MT', 'BCA': 'BCA'};

List _branches = [];
BranchDependentDropDown() {
  branch.forEach((key, value) {
    _branches.add(key);
  });
}

String _selectedField = "Select Field";
var field = {
  'CSE': 'BT',
  'ECE': 'BT',
  'EEE': 'BT',
  'MECH': 'BT',
  'CIVIL': 'BT',
  'AI': 'MT',
  'ROBOTICS': 'MT',
  'COMMUNICATION': 'MT',
  'CIVIL': 'MT',
  'WEB DESIGNING': 'BCA',
  'BANKING': 'BCA',
  'NETWORKING': 'BCA',
};

List _field = ['Select Field'];
FieldDependentDropDown(branchShortName) {
  field.forEach((key, value) {
    if (branchShortName == value) {
      _field.add(key);
    }
  });
  _selectedField = _field[0];
}

// const List<String> list = <String>['Select Branch', 'BTech', 'MTech', 'BCA'];
// const List<String> btechList = <String>[
//   'Select Field',
//   'CSE',
//   'ECE',
//   'MECH',
//   'CIVIL'
// ];
// const List<String> mtechList = <String>[
//   'Select Field',
//   'AI',
//   'Robotics',
//   'Communication Engineering',
//   'CIVIL'
// ];
// const List<String> bcaList = <String>[
//   'Select Field',
//   'Web Designing',
//   'Banking',
//   'Networking',
// ];

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  // String branchValue = list.first;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BranchDependentDropDown();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: IconButton(
                        icon: const Icon(Icons.arrow_back_ios_sharp),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text("Hello!  Register to get \nStarted",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                CustomizedTextfield2(
                  myController: _usernameController,
                  hintText: "Username",
                  isPassword: false,
                ),
                CustomizedTextfield2(
                  myController: _emailController,
                  hintText: "Email",
                  isPassword: false,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xffE8ECF4)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: DropdownButton(
                        value: _selectedBranch,
                        elevation: 16,
          
                        onChanged: (newValue) {
                          setState(() {
                            _field = [];
                            FieldDependentDropDown(branch[newValue]);
                            _selectedBranch = "$newValue";
                          });
                        },
                        items: _branches.map((branch) {
                          return DropdownMenuItem(
                            child: new Text(branch),
                            value: branch,
                          );
                        }).toList(),
                        // items: list.map<DropdownMenuItem<String>>((String value) {
                        //   return DropdownMenuItem<String>(
                        //     value: value,
                        //     child: Text(
                        //       value,
                        //       style: TextStyle(
                        //         color: value == 'Select Branch'
                        //             ? Color.fromARGB(255, 136, 135, 135)
                        //             : Colors.black, //Font color
                        //         fontSize: 16,
                        //         //font size on dropdown button,
                        //       ),
                        //     ),
                        //   );
                        // }).toList(),
                        borderRadius: BorderRadius.circular(10),
                        icon: const Padding(
                            //Icon at tail, arrow bottom is default icon
                            padding: EdgeInsets.only(left: 10.0),
                            child: Icon(Icons.arrow_circle_down_sharp)),
                        iconEnabledColor: Colors.grey, //Icon color
          
                        dropdownColor:
                            const Color(0xffE8ECF4), //dropdown background color
                        underline: Container(
                          //line under dropdown button
                          height: 1,
                          color: const Color(0xffE8ECF4),
                        ), //remove underline
                        isExpanded: true, //make true to make width 100%
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xffE8ECF4)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: DropdownButton(
                        // value: branchValue,
                        elevation: 16,
                        value: _selectedField,
                        onChanged: (newValue) {
                          print(newValue);
                          setState(() {
                            print(newValue);
          
                            _selectedField = "$newValue";
                          });
                        },
                        items: _field.map((field) {
                          return DropdownMenuItem(
                            child: new Text(field),
                            value: field,
                          );
                        }).toList(),
                        // onChanged: (String? value) {
                        //   // This is called when the user selects an item.
                        //   setState(() {
                        //     branchValue = value!;
                        //   });
                        // },
                        // items: list.map<DropdownMenuItem<String>>((String value) {
                        //   return DropdownMenuItem<String>(
                        //     value: value,
                        //     child: Text(
                        //       value,
                        //       style: TextStyle(
                        //         color: value == 'Select Branch'
                        //             ? Color.fromARGB(255, 136, 135, 135)
                        //             : Colors.black, //Font color
                        //         fontSize: 16,
                        //         //font size on dropdown button,
                        //       ),
                        //     ),
                        //   );
                        // }).toList(),
                        borderRadius: BorderRadius.circular(10),
                        icon: const Padding(
                            //Icon at tail, arrow bottom is default icon
                            padding: EdgeInsets.only(left: 10.0),
                            child: Icon(Icons.arrow_circle_down_sharp)),
                        iconEnabledColor: Colors.grey, //Icon color
          
                        dropdownColor:
                            const Color(0xffE8ECF4), //dropdown background color
                        underline: Container(
                          //line under dropdown button
                          height: 1,
                          color: const Color(0xffE8ECF4),
                        ), //remove underline
                        isExpanded: true, //make true to make width 100%
                      ),
                    ),
                  ),
                ),
                CustomizedTextfield(
                  myController: _passwordController,
                  hintText: "Password",
                  isPassword: true,
                ),
                CustomizedTextfield(
                  myController: _confirmPasswordController,
                  hintText: "Confirm Password",
                  isPassword: true,
                ),
                CustomizedButton(
                  buttonText: "Register",
                  buttonColor: Colors.black,
                  textColor: Colors.white,
                  onPressed: () async {
                    try {
                      final userCredential = await FirebaseAuthService().signup(
                          _usernameController.text.trim(),
                          _emailController.text.trim(),
                          _passwordController.text.trim(),
                          _selectedBranch.toLowerCase(),
                          _selectedField.toLowerCase(),
                          
                          );
          
                      if (!mounted) return;
          
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                    } on FirebaseException catch (e) {
                      debugPrint(e.message);
                    }
          
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (_) => const LoginScreen()));
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 1,
                        width: MediaQuery.of(context).size.height * 0.15,
                        color: Colors.grey,
                      ),
                      const Text("Or Register with"),
                      Container(
                        height: 1,
                        width: MediaQuery.of(context).size.height * 0.16,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                          height: 50,
                          width: 100,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: IconButton(
                            icon: const Icon(
                              FontAwesomeIcons.facebookF,
                              color: Colors.blue,
                            ),
                            onPressed: () {},
                          )),
                      Container(
                        height: 50,
                        width: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: IconButton(
                          icon: const Icon(
                            FontAwesomeIcons.google,
                            // color: Colors.blue,
                          ),
                          onPressed: () {},
                        ),
                      ),
                      Container(
                          height: 50,
                          width: 100,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: IconButton(
                            icon: const Icon(
                              FontAwesomeIcons.apple,
                              // color: Colors.blue,
                            ),
                            onPressed: () {},
                          ))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account?",
                          style: TextStyle(
                            color: Color(0xff1E232C),
                            fontSize: 15,
                          )),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const LoginScreen()));
                        },
                        
                        child: const Text("  Login Now",
                            style: TextStyle(
                              color: Color(0xff35C2C1),
                              fontSize: 15,
                            )),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
