import 'package:cloud_firestore/cloud_firestore.dart';
import "package:provider/provider.dart";
import 'package:flutter/material.dart';
import 'package:skill_edge/components/article_template.dart';
import 'package:skill_edge/providers/user_provider.dart';
import 'package:skill_edge/screens/Courses/course_tile.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../components/company_template.dart';
import '../../models/article_model.dart';
import '../../models/company_model.dart';
import '../../models/course_model.dart';

class Home extends StatefulWidget {
  final TabController tabController;
  const Home({super.key, required this.tabController});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //add provider here
  final String username = "John Doe";
  List<ArticleModel> articleData = [];
  List<Company> companies = [];
  List<CourseModel> courseData = [];
  String doubt = "";
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void loadData() async {
    // Getting data from cloud firestore
    final FirebaseFirestore db = FirebaseFirestore.instance;
    var querySnapshot = await db.collection("articles").get();
    final allData = querySnapshot.docs.map((doc) {
      Map<String, dynamic> cur = doc.data();
      cur["id"] = doc.id;
      return cur;
    }).toList();
    // print(allData);
    articleData = List.from(allData)
        .map<ArticleModel>((article) => ArticleModel.fromMap(article))
        .toList();

    var companyCollection = await db.collection("companies").get();
    final companyData = companyCollection.docs.map((doc) {
      Map<String, dynamic> cur = doc.data();
      cur["id"] = doc.id;
      return cur;
    }).toList();
    companies = List.from(companyData)
        .map<Company>((comp) => Company.fromMap(comp))
        .toList();

    var courseCollection = await db.collection("courses").get();
    final courses = courseCollection.docs.map((doc) {
      Map<String, dynamic> cur = doc.data();
      cur["id"] = doc.id;
      return cur;
    }).toList();

    courseData = List.from(courses)
        .map<CourseModel>((course) => CourseModel.fromMap(course))
        .toList();

    setState(() {});
  }

  _contact() async {
    String email = Uri.encodeComponent("avnishranwa7@gmail.com");
    String subject = Uri.encodeComponent("Doubt");
    String body = Uri.encodeComponent("$doubt");
    Uri mail = Uri.parse('mailto:$email?subject=$subject&body=$body');
    if (await canLaunchUrl(mail)) {
      await launchUrl(mail);
    } else {
      throw 'Could not launch $mail';
    }

    _controller.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: articleData.length != 0 &&
              companies.length != 0 &&
              courseData.length != 0
          ? ListView(
              padding: const EdgeInsets.all(8.0),
              children: [
                Row(
                  children: [
                    const Text("Welcome ", style: TextStyle(fontSize: 20)),
                    Text(context.watch<CurrentUser>().username,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700))
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    const Text("Latest Articles",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w400)),
                    const Spacer(),
                    TextButton(
                        onPressed: () {
                          widget.tabController.animateTo(2);
                        },
                        child: const Text("See all"))
                  ],
                ),
                Container(
                  constraints: const BoxConstraints(maxHeight: 180),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: articleData.length,
                    itemBuilder: ((context, index) =>
                        ArticleTemplate(article: articleData[index])),
                  ),
                ),
                Row(
                  children: [
                    const Text("My Courses",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w400)),
                    const Spacer(),
                    TextButton(
                        onPressed: () {
                          widget.tabController.animateTo(1);
                        },
                        child: const Text("See all"))
                  ],
                ),
                Container(
                  constraints: const BoxConstraints(maxHeight: 180),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: courseData.length,
                    itemBuilder: ((context, index) =>
                        CourseTile(course: courseData[index])),
                  ),
                ),
                Row(
                  children: [
                    const Text("Interview Questions",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w400)),
                    const Spacer(),
                    TextButton(
                        onPressed: () {
                          widget.tabController.animateTo(3);
                        },
                        child: const Text("See all"))
                  ],
                ),
                Container(
                  constraints: const BoxConstraints(maxHeight: 180),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: companies.length,
                    itemBuilder: ((context, index) =>
                        CompanyTemplate(comp: companies[index])),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text("Any Doubts?", style: TextStyle(fontSize: 18)),
                const SizedBox(
                  height: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    TextField(
                      onChanged: (value) {
                        doubt = value;
                      },
                      controller: _controller,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(border: OutlineInputBorder()),
                    ),
                    ElevatedButton(
                        onPressed: _contact, child: const Text('Submit'))
                  ],
                ),
              ],
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
