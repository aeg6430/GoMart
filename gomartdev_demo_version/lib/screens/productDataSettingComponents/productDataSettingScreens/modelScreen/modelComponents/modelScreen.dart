import 'package:flutter/material.dart';
import 'package:gomartdev/GraphQLConfig/GraphQLConfig.dart';
import 'package:gomartdev/globals.dart';
import 'package:graphql/client.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:uuid/uuid.dart';
import '../../../../../constants/constants.dart';
import '../../publicComponents/controlBar/batchProcessingButton/batchProcessingPopUpWindow.dart';
import '../../publicComponents/controlBar/deleteButton/deleteDataPopUpWindow.dart';
import '../../publicComponents/controlBar/searchingButton/selectDataPopUpWindow.dart';




class modelScreen extends StatefulWidget{
  modelScreen({Key? key,}) : super(key: key);


  @override
  stateModelScreen createState() => stateModelScreen();
}

class stateModelScreen extends State<modelScreen>{


  TextEditingController modelNameTextController = TextEditingController();
   TextEditingController modelIDTextController = TextEditingController();







   bool enabled = false;
   bool readOnly= true;
   int tapCounter=1;

   late String inputModelID;
   late String inputModelName;



  /*String modelMuntation="""
  mutation MyMutation{
  insert_model(objects: {modelID: $inputModelID, modelName: $inputModelName}) {
    returning {
      modelID
      modelName
    }
  }
}
""";*/

 String  modelMuntation="""
  mutation addModel(\$modelID:uuid!,\$modelName:String!) {
  insert_Model( objects: {modelID: \$modelID, modelName: \$modelName}) {

  }
}""";






   @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: GraphQLConfiguration.client,
      child:  Scaffold(
        backgroundColor: bgColor,
        body: SafeArea(
            child:Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    height:MediaQuery.of(context).size.height*0.05,
                    child: Row(
                      mainAxisAlignment:  MainAxisAlignment.start,
                      children: [
                        SizedBox(width:MediaQuery.of(context).size.width*0.01),
                        Container(
                          decoration: new BoxDecoration(
                              color: primaryColor,
                              borderRadius: new BorderRadius.all(Radius.circular(5))
                          ),
                          child:TextButton.icon(
                            icon:Icon(Icons.add_box,color: Colors.white,),
                            label:Text('新增',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 12,color:Colors.white )
                            ),
                            onPressed: (){
                              debugPrint('button add');
                              setState(() {
                                tapCounter++;
                                if(tapCounter %2==0)
                                {
                                  enabled =true;
                                }
                              },

                              );
                            },
                          ),
                        ),
                        SizedBox(width:MediaQuery.of(context).size.width*0.01),
                        Container(
                          decoration: new BoxDecoration(
                              color: primaryColor,
                              borderRadius: new BorderRadius.all(Radius.circular(5))
                          ),
                          child:TextButton.icon(
                            icon:Icon(Icons.delete_forever,color: Colors.white,),
                            label:Text('刪除',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 12,color:Colors.white )
                            ),
                            onPressed: ()async{
                              debugPrint('button delete');
                              showDialog(
                                anchorPoint:Offset.infinite, //Offset(1000, 1000),
                                context: context,
                                builder: (_) => deleteDataPopUpWindow(),

                              );
                            },
                          ),
                        ),
                        SizedBox(width:MediaQuery.of(context).size.width*0.05),
                        Container(
                          decoration: new BoxDecoration(
                              color: Colors.amberAccent.withOpacity(0.8),
                              borderRadius: new BorderRadius.all(Radius.circular(5))
                          ),
                          child:TextButton.icon(
                            icon:Icon(Icons.file_copy_rounded,color: Colors.white,),
                            label:Text('批量處理',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 12,color:Colors.white )
                            ),
                            onPressed: () async{
                              showDialog(
                                anchorPoint:Offset.infinite, //Offset(1000, 1000),
                                context: context,
                                builder: (_) => batchProcessingPopUpWindow(),

                              );
                            },
                          ),
                        ),
                        SizedBox(width:MediaQuery.of(context).size.width*0.01),
                        Container(
                          decoration: new BoxDecoration(
                              color: primaryColor,
                              borderRadius: new BorderRadius.all(Radius.circular(5))
                          ),
                          child:TextButton.icon(
                            icon:Icon(Icons.search,color: Colors.white,),
                            label:Text('搜尋',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 12,color:Colors.white )
                            ),
                            onPressed: () async{
                              showDialog(
                                anchorPoint:Offset.infinite, //Offset(1000, 1000),
                                context: context,
                                builder: (_) => selectDataPopUpWindow(),

                              );
                            },
                          ),
                        ),
                        SizedBox(width:MediaQuery.of(context).size.width*0.01),
                        Container(
                          decoration: new BoxDecoration(
                              color: Colors.green,
                              borderRadius: new BorderRadius.all(Radius.circular(5))
                          ),
                          child:TextButton.icon(
                            icon:Icon(Icons.save,color: Colors.white,),
                            label:Text('儲存',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 12,color:Colors.white )
                            ),
                            onPressed: (){
                              debugPrint('button save');
                              setState(() {
                                tapCounter++;
                                if(tapCounter %2==0)
                                {
                                  enabled =false;
                                }
                              });
                            },
                          ),
                        ),
                        SizedBox(width:MediaQuery.of(context).size.width*0.01),
                        Container(
                          decoration: new BoxDecoration(
                              color: Colors.red,
                              borderRadius: new BorderRadius.all(Radius.circular(5))
                          ),
                          child:TextButton.icon(
                            icon:Icon(Icons.cancel,color: Colors.white,),
                            label:Text('取消',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 12,color:Colors.white )
                            ),
                            onPressed: (){
                              debugPrint('button cancel');
                              setState(() {
                                tapCounter++;
                                if(tapCounter %2==1)
                                {
                                  enabled =false;
                                }
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                Expanded(
                  child: DefaultTabController(
                    animationDuration: Duration.zero,
                    length: 1,
                    child: SizedBox(
                      height:MediaQuery.of(context).size.height*0.8,
                      child: Column(
                        children: <Widget>[
                          Container(
                            height:MediaQuery.of(context).size.height*0.05,

                            color: textColor.withOpacity(0.25),
                            child: TabBar(
                              indicator: BoxDecoration(
                                color: Colors.white,
                              ),
                              unselectedLabelColor: textColor,
                              labelColor: secondaryColor,

                              tabs: <Tab>[
                                Tab(
                                  child: Text(
                                    "基本資料",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color:textColor),),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: TabBarView(
                              children: <Widget>[
                                Container(
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Container(
                                              height:MediaQuery.of(context).size.height*0.5,
                                              child: Column(
                                                children: [
                                                  SizedBox(height: 20,),
                                                  Mutation(
                                                      options: MutationOptions(
                                                        document: gql(modelMuntation),
                                                        onError: (result){
                                                          //debugPrint(result.toString());
                                                          debugPrint(result?.graphqlErrors.toString());
                                                          debugPrint(result?.linkException.toString());
                                                        }
                                                      ),
                                                    builder: (
                                                        MultiSourceResult<Object?> Function(Map<String, dynamic>, {Object? optimisticResult})
                                                        runMutation,
                                                        QueryResult<Object?>? result) {
                                                        return Container(
                                                          width: MediaQuery.of(context).size.width*0.15,
                                                          padding: EdgeInsets.symmetric(horizontal: 2),
                                                          child: TextField(
                                                            controller: modelNameTextController,
                                                            enabled: enabled,
                                                            readOnly: false,
                                                            decoration:
                                                            InputDecoration(
                                                                floatingLabelBehavior: FloatingLabelBehavior.always,

                                                                isDense: true,
                                                                contentPadding: EdgeInsets.all(10),
                                                                labelText: '品名',
                                                                helperText: '輸入完成後按Enter鍵'
                                                            ),
                                                            onSubmitted: (value) async {
                                                              String uuid = Uuid().v4();
                                                              modelIDTextController.text = uuid ;
                                                              debugPrint('品名: '+modelNameTextController.text);
                                                              debugPrint('uuid: '+uuid);

                                                              runMutation(

                                                              {
                                                              "modelID": uuid,
                                                              'modelName': modelNameTextController.text,
                                                              }

                                                              );
                                                            },
                                                          ),
                                                        );
                                                    },
                                                  ),
                                                  SizedBox(height: 20,),
                                                  Container(
                                                    width: MediaQuery.of(context).size.width*0.15,
                                                    padding: EdgeInsets.symmetric(horizontal: 2),
                                                    child: TextField(
                                                      controller: modelIDTextController,
                                                      enabled: enabled,
                                                      readOnly: true,
                                                      keyboardType: TextInputType.multiline,
                                                      maxLines: null,
                                                      minLines: 2,
                                                      decoration:
                                                      InputDecoration(
                                                        floatingLabelBehavior: FloatingLabelBehavior.always,
                                                        isDense: true,
                                                        contentPadding: EdgeInsets.all(10),
                                                        labelText: '品號',
                                                        helperText: '自動產生品號',
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                      ),
                                    ],
                                  ) ,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )
        ),
      )
    );
  }
}


