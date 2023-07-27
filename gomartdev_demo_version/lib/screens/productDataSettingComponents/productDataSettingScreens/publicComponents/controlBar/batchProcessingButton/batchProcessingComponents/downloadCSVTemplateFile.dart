import 'package:flutter/material.dart';


class downloadCSVTemplateFile extends StatefulWidget {
  const downloadCSVTemplateFile ({Key? key}) : super(key: key,);

  @override
  stateDownloadCSVTemplateFile createState() => stateDownloadCSVTemplateFile ();
}

class stateDownloadCSVTemplateFile  extends State<downloadCSVTemplateFile > {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(1),
      child:SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height*0.05,

          child: Center(child:  ElevatedButton(
            onPressed: () async {
              debugPrint('Download CSV Template File');

            },
            child: const Text('下載CSV範本文件'),
          ),
          )
      ),
    );
  }
}






