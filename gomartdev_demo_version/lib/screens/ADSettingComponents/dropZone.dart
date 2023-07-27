
import 'dart:convert';
import 'dart:html';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../constants/constants.dart';
import '../../globals.dart';
import 'dart:io';

class dropZone extends StatefulWidget {
  const dropZone({Key? key}) : super(key: key);

  @override
  stateDropZone createState() => stateDropZone();
}

class stateDropZone extends State<dropZone> {

  late DropzoneViewController controller1;

  String message1 = '拖曳廣告檔案或開啟檔案總管選擇檔案';
  bool highlighted1 = false;

  late final thumbnail;











  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(appPadding),
      decoration: BoxDecoration(
        color: primaryColor.withOpacity(0.3),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            height: 300,

            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height*0.05,),


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

                ElevatedButton(
                  onPressed: () async {
                    buildZone1(context);

                    print(await controller1.pickFiles
                      (mime: [
                        'video/x-flv',
                        'video/mp4',
                        'application/x-mpegURL',
                        'video/quicktime',
                        'video/x-msvideo',
                        'video/x-ms-wmv',
                      ]
                     )
                    );
                  },
                  child: const Text('開啟檔案總管'),
                ),
              ],
            ),

          ),

        ],
      ),
    );

  }


  Widget buildZone1(BuildContext context) => Builder(
    builder: (context) => DropzoneView(
      operation: DragOperation.copy,
      cursor: CursorType.grab,
      onCreated: (ctrl) => controller1 = ctrl,
      onLoaded: () => print('Zone 1 loaded'),
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
        final bytes = await controller1.getFileData(ev);
        print("File Data: "+bytes.sublist(0, 20).toString());

        /*final stream =await controller1.getFileStream(ev);
          print(stream.take(20));*/

        VideoResult = bytes;






        print("File Name: "+'${ev.name}');

        final fileUrl =await controller1.createFileUrl(ev);
        print("File URL: "+fileUrl.toString());


        uri = fileUrl.substring(5).toString();















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

        /*thumbnail = await VideoThumbnail.thumbnailFile(
          video: fileUrl.toString(),
          thumbnailPath: (await getTemporaryDirectory()).path,
          imageFormat: ImageFormat.WEBP,
          maxHeight: 64, // specify the height of the thumbnail, let the width auto-scaled to keep the source aspect ratio
          quality: 75,
        );*/

        print('Zone 1 drop: ${ev.name}');
        setState(() {

          child: Text(
            message1 = '${ev.name} 上傳成功\n文件大小: '+filesize,
            textAlign: TextAlign.center,
              );
          highlighted1 = false;
        });




      },

    ),
  );

  getTemporaryDirectory() {/*GCP SQL*/}




}






