import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imgtobitmap/class/img.dart';
import 'package:imgtobitmap/screen/oled.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'ImgtoBitmap'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  File? file;
  StringBuffer? path;
  bool imgLoag=false;
  Img img =Img();
// final file2 = File('file.txt');

  @override
  void initState() {
    _counter = 0;
    super.initState();
  }

  Future selectImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc'],
    );
  }

  Widget imgg(File file) {
    if (file != null) {
      return Text(file.toString());
    } else {
      return Text("null");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(child: Text('ImgtoBitmap')),
        elevation: 20,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "ImgtoBitmap",
              style: TextStyle(fontSize: 50),
            ),
            SizedBox(
              height: 15.0,
            ),
            StreamBuilder(
              stream: confirmarImg(imgLoag , context),
              builder: (BuildContext , AsyncSnapshot){
                return   Text("Convierte imagenes para  tus pantallas oled");
              }),
         
            SizedBox(
              height: 17.0,
            ),

            SizedBox(
              height: 15.0,
            ),
            btnImage(),
            /*
      ElevatedButton(onPressed: (){
        pushScren(context);
      } , child: Text("Oled")),
      */
            SizedBox(
              child: cargarImage(context),
              width: 500,
              height: 200,
            ),
            //img(result.),
          ],
        ),
      ),
    );
  }

  Widget cargarImage(BuildContext context) {
    
    if (file != null) {
      Img img =Img();
      img.file=file!;
      
      imgLoag=true;
      return Image.network(file!.path);

    } else {
          imgLoag=false;
      return Text("");
    }
  }
void cargarImage2(BuildContext context) {
    
    if (file != null) {
      
      img.file=file!;
      pushScren(context);
   //   return Image.network(file!.path);

    } else {
     Text("No se acargado ninguna imagen");
    }
  }

  Widget btnImage() {
    return ElevatedButton(
        onPressed: () async {
          ImagePicker picker = ImagePicker();
          XFile? image = await picker.pickImage(source: ImageSource.gallery);
          //var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
          print("presione el boton");
          if (image != null) {
            print("deberia obtener la image");
            setState(() {
              print(image.path.toString());
              file = File(image.path);
              img.image=image;
            });
          }
        },
        child: Text("Seleciona  imagen"));
  }

  pushScren(BuildContext context) {
   
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => oled()));
  }

  Stream confirmarImg(bool imgLoad , BuildContext context) async*{

     if(imgLoag == true){
      yield* pushScren(context) ;
      imgLoag=false;
     };
  }
}

         /*  FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
         allowedExtensions: ['jpg', 'png'],
);

 if(result != null){

 PlatformFile file = result.files.first;

  print("name " + file.name);//name
//  print(file.bytes);
  print("tamaño " +  file.size.toString());//size
  print("ext  " + file.extension.toString());//extension
  print("direccion " + file.path.toString());

 }*/

