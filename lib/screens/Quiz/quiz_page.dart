import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:skill_edge/components/landing_page.dart';
import 'package:skill_edge/components/quiz_question.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> with TickerProviderStateMixin {
  late AnimationController progressController;
  late CountdownTimerController timerController;
  
  // ENDING TIME OF QUIZ YYYY-MM-DD HH:MM:SS
  static const time = "2022-11-05 19:34:00";
  int timeLeft = DateTime.parse(time).millisecondsSinceEpoch - DateTime.now().millisecondsSinceEpoch;
  int endTime = DateTime.parse(time).millisecondsSinceEpoch;

  @override
  void initState() {
    progressController = AnimationController(
        vsync: this, duration: Duration(milliseconds: timeLeft))
      ..addStatusListener((AnimationStatus status) {
        setState(() {
          if (status == AnimationStatus.completed) {
            
          }
        });
      })
      ..addListener(() {
        setState(() {
        });
      });
    progressController.forward();

    timerController = CountdownTimerController(
      endTime: endTime,
      onEnd: timerOnEnd
    );
    super.initState();
  }

  void timerOnEnd() async {
    await showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text('Quiz is over!'),
        content: Text('Thanks for giving the quiz :)'),
        actions: [
          TextButton(
            onPressed: (){
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LandingPage()), ((route) => false));
            },
            child: Text('Go to homepage')
          ),
          TextButton(onPressed: (){}, child: Text('Check your result')),
        ],
      );
    });

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const LandingPage();
    }));
  }

  @override
  void dispose() {
    progressController.dispose();
    timerController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Science and Nature',
                    style: TextStyle(fontSize: 24),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              LinearProgressIndicator(
                value: progressController.value,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text('Time Left: ', style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      )),
                  CountdownTimer(
                    controller: timerController,
                    endTime: endTime,
                    onEnd: timerOnEnd,
                    textStyle: TextStyle(fontSize: 15,
                    fontWeight: FontWeight.w500,),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Question(),
              const SizedBox(
                height: 80,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                    onPressed: () {},
                    child: Row(
                      children: [
                        Icon(Icons.arrow_left_outlined),
                        Text('Previous Question')
                      ],
                    ),
                  ),
                  ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                    onPressed: () {},
                    child: Row(
                      children: [
                        Icon(Icons.arrow_right_outlined),
                        Text('Next Question')
                      ],
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.black),
                onPressed: (){
                  Navigator.pop(context);
                },
                child: Text('Submit Quiz', style: TextStyle(color: Colors.white),)
              )
            ],
          ),
        ),
      ),
    );
  }
}
