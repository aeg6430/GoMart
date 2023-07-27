/*
*  survey_page_widget.dart
*  GoMartClient
*
*  Created by [Author].
*  Copyright © 2018 [Company]. All rights reserved.
    */

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_mart_client/values/values.dart';
import 'package:flutter/services.dart';
import 'package:survey_kit/survey_kit.dart';
import 'package:flutter/cupertino.dart';



class SurveyPageWidget extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Color.fromARGB(255, 253, 141, 126),
        title: Center(
            child: Text("購物偏好調查",
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Noto Sans",
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            )
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Align(
          alignment: Alignment.center,
          child: FutureBuilder<Task>(
            future: getSampleTask(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData &&
                  snapshot.data != null) {
                final task = snapshot.data;



                return SurveyKit(
                  onResult: (SurveyResult result) {
                      if (result.finishReason == FinishReason.COMPLETED) {
                        Navigator.of(context).pushNamedAndRemoveUntil('/routerHomePage',(Route<dynamic>route)=>false);
                        return;
                      }

                    },
                  task: task,
                  showProgress: true,
                  localizations: {
                    'cancel': '取消調查',
                    'next': '下一步',
                  },
                  themeData: Theme.of(context).copyWith(
                    colorScheme: ColorScheme.fromSwatch(
                      primaryColorDark: Color.fromARGB(255, 253, 141, 126),
                    ).copyWith(
                      onPrimary: Colors.white,
                    ),
                    primaryColor: Color.fromARGB(255, 253, 141, 126),
                    backgroundColor: Colors.white,
                    appBarTheme: const AppBarTheme(
                      color: Colors.white,
                      iconTheme: IconThemeData(
                        color: Color.fromARGB(255, 253, 141, 126),
                      ),
                      titleTextStyle: TextStyle(
                        color: Color.fromARGB(255, 253, 141, 126),
                      ),
                    ),
                    iconTheme: const IconThemeData(
                      color: Color.fromARGB(255, 253, 141, 126),
                    ),
                    textSelectionTheme: TextSelectionThemeData(
                      cursorColor: Color.fromARGB(255, 253, 141, 126),
                      selectionColor: Color.fromARGB(255, 253, 141, 126),
                      selectionHandleColor: Color.fromARGB(255, 253, 141, 126),
                    ),
                    cupertinoOverrideTheme: CupertinoThemeData(
                      primaryColor: Color.fromARGB(255, 253, 141, 126),
                    ),
                    outlinedButtonTheme: OutlinedButtonThemeData(
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(
                          Size(150.0, 60.0),
                        ),
                        side: MaterialStateProperty.resolveWith(
                              (Set<MaterialState> state) {
                            if (state.contains(MaterialState.disabled)) {
                              return BorderSide(
                                color: Colors.grey,
                              );
                            }
                            return BorderSide(
                              color: Color.fromARGB(255, 253, 141, 126),
                            );
                          },
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        textStyle: MaterialStateProperty.resolveWith(
                              (Set<MaterialState> state) {
                            if (state.contains(MaterialState.disabled)) {
                              return Theme.of(context)
                                  .textTheme
                                  .button
                                  ?.copyWith(
                                color: Colors.grey,
                              );
                            }
                            return Theme.of(context)
                                .textTheme
                                .button
                                ?.copyWith(
                              color: Color.fromARGB(255, 253, 141, 126),
                            );
                          },
                        ),
                      ),
                    ),
                    textButtonTheme: TextButtonThemeData(
                      style: ButtonStyle(
                        textStyle: MaterialStateProperty.all(
                          Theme.of(context).textTheme.button?.copyWith(
                            color:Color.fromARGB(255, 253, 141, 126),

                          ),
                        ),
                      ),
                    ),
                    textTheme: TextTheme(
                      headline2: TextStyle(
                        fontSize: 28.0,
                        color: Colors.black,
                      ),
                      headline5: TextStyle(
                        fontSize: 24.0,
                        color: Colors.black,
                      ),
                      bodyText2: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black,
                      ),
                      subtitle1: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black,
                      ),
                    ),
                    inputDecorationTheme: InputDecorationTheme(
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  surveyProgressbarConfiguration: SurveyProgressConfiguration(
                    backgroundColor: Colors.white,
                  ),
                );
              }
              return CircularProgressIndicator.adaptive();
            },
          ),
        ),
      ),

    );
  }

  Future<Task> getSampleTask() {
    var task = NavigableTask(
      id: TaskIdentifier(),
      steps: [
        InstructionStep(
          title: '感謝您使用\nGoMart購物趣',
          text: '為了增進您的使用體驗\n填寫問卷以提供更符合您的服務',
          buttonText: '開始',
        ),
        QuestionStep(
          title: '您的年齡為何?',
          answerFormat: IntegerAnswerFormat(
            defaultValue: 25,
            hint: '請輸入您的年齡',
          ),
          isOptional: true,
        ),
        QuestionStep(
          title: '您的性別是?',

          answerFormat: BooleanAnswerFormat(
            positiveAnswer: '男',
            negativeAnswer: '女',
            result: BooleanResult.POSITIVE,
          ),
        ),


        QuestionStep(
          title: 'Known allergies',
          text: '多選題',
          isOptional: false,
          answerFormat: MultipleChoiceAnswerFormat(
            textChoices: [
              TextChoice(text: 'Penicillin', value: 'Penicillin'),
              TextChoice(text: 'Latex', value: 'Latex'),
              TextChoice(text: 'Pet', value: 'Pet'),
              TextChoice(text: 'Pollen', value: 'Pollen'),
            ],
          ),
        ),


        CompletionStep(
          stepIdentifier: StepIdentifier(id: '321'),
          text: '感謝您回答本問卷',
          title: '完成',
          buttonText: '送出問卷',

        ),
      ],
    );

    return Future.value(task);
  }







  Future<Task> getJsonTask() async {
    final taskJson = await rootBundle.loadString('assets/example_json.json');
    final taskMap = json.decode(taskJson);

    return Task.fromJson(taskMap);
  }
}