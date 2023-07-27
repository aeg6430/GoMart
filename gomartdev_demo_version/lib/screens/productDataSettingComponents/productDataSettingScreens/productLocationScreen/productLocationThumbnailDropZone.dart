
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:provider/provider.dart';




import '../../../../../constants/constants.dart';
import '../../../../../globals.dart';
class productLocationThumbnailDropZone extends StatefulWidget {
  const productLocationThumbnailDropZone({Key? key}) : super(key: key,);

  @override
  stateProductLocationThumbnailDropZone createState() => stateProductLocationThumbnailDropZone();
}

class stateProductLocationThumbnailDropZone extends State<productLocationThumbnailDropZone>{

  late DropzoneViewController controller1;



  String message1 = '拖曳JPG檔案或開啟檔案總管選擇檔案';
  bool highlighted1 = false;










  @override
  Widget build(BuildContext context) {
    return Provider<stateProductLocationThumbnailDropZone>(
      create:(_)=>stateProductLocationThumbnailDropZone(),
      child: SafeArea(
          child: Dialog(
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Container(
                  height:MediaQuery.of(context).size.height*0.38,
                  width: MediaQuery.of(context).size.width*0.35,
                  decoration: new BoxDecoration( color: primaryColor.withOpacity(0.3) ),
                  child:Column(
                    children: [
                      Container(
                          width: double.infinity,
                          height: 50,
                          decoration: new BoxDecoration(
                              color: primaryColor,
                              borderRadius: new BorderRadius.only(
                                  topLeft:  const  Radius.circular(10.0),
                                  topRight: const  Radius.circular(10.0))
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              '商品陳列位置圖上傳',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 25,color: Colors.white),),
                          )
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height*0.29,
                            child: Column(
                              children: [
                                Expanded(
                                  child: Container(
                                    color: highlighted1 ? Colors.red : Colors.transparent,
                                    child: Stack(
                                      children: [
                                        buildZone1(context),
                                        Center(
                                            child:
                                            Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.cloud_upload,
                                                    size: 40,
                                                    color: Colors.white,
                                                  ),
                                                  Text(
                                                    message1,
                                                    style: TextStyle(color:Colors.white,fontSize: 14),),
                                                  const SizedBox(height: 16,),
                                                ]
                                            )
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20,),

                                ElevatedButton(
                                  onPressed: () async {
                                    buildZone1(context);

                                    print(await controller1.pickFiles(mime: ['image/jpeg','image/png',"image/x-ms-bmp"]));

                                  },

                                  child: const Text('開啟檔案總管'),
                                ),
                                SizedBox(height: 20,)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
              )
          )
      ),
    );
  }

  Widget buildZone1(BuildContext context) => Builder(
    builder: (context) => DropzoneView(
      operation: DragOperation.copy,
      cursor: CursorType.grab,
      onCreated: (ctrl) => controller1 = ctrl,
      onLoaded: () => print('Zone 1 loaded',),
      onError: (ev) => print('Zone 1 error: $ev'),
      onHover: () {
        setState(() => highlighted1 = true);
        print('Zone 1 hovered');
      },
      onLeave: () {
        setState(() => highlighted1 = false);
        print('Zone 1 left');
      },
      onDrop: (ev) async {
        var bytes = await controller1.getFileData(ev);
        //print("File Data: "+bytes.sublist(0, 20).toString());
        //print("File Data: "+bytes.toString());

        print("File Name: "+'${ev.name}');

        final fileUrl =await controller1.createFileUrl(ev);
        print("File URL: "+fileUrl.toString());
        final fileSize =await controller1.getFileSize(ev);
        if(fileSize>0&& fileSize<1048576)
        {
          print("File Size: "+(fileSize/1024).toStringAsFixed(2)+"KB");
          filesize=((fileSize/1024).toStringAsFixed(2)+"KB");
        }
        else if(fileSize>=1048576 && fileSize<1073741824)
        {
          print("File Size: "+(fileSize/1048576).toStringAsFixed(2)+"MB");
          filesize=((fileSize/1048576).toStringAsFixed(2)+"MB");
        }
        else
        {
          print("File Size: "+(fileSize/1073741824).toStringAsFixed(2)+"GB");
          filesize=((fileSize/1073741824).toStringAsFixed(2)+"GB");
        }
        final lastModified = await controller1.getFileLastModified(ev);
        print("File Last Modified Time: "+lastModified.toString());

        final MIME = await controller1.getFileMIME(ev);
        print("File MIME: "+MIME.toString());

        print('Zone 1 drop: ${ev.name}');
        setState(() {
          debugPrint('url'+fileUrl.toString());
          Center(
              child:Text(
                message1 = '${ev.name} 上傳成功\n文件大小: '+filesize,
                textAlign: TextAlign.center,),
              );
          highlighted1 = false;
         }
        );
      },
    ),
  );
}







