import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imgtobitmap/class/img.dart';
import 'package:imgtobitmap/screen/oled.dart';
import 'package:imgtobitmap/screen/tft.dart';

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
  bool imgLoag = false;
  Img img = Img();
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
        title: Align(child: Text('ConverterImage' ,)),
        elevation: 20,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "ConverterImage",
              style: TextStyle(fontSize: 50 , color: Colors.blue),
            ),
            SizedBox(
              height: 30.0,
            ),
            StreamBuilder(
                stream: confirmarImg(imgLoag, context),
                builder: (BuildContext, AsyncSnapshot) {
                  return
                  Padding(padding: EdgeInsets.only(left: 15.0 , right: 15.0) , child:
                   Text( textAlign: TextAlign.center,
                   style:TextStyle(fontSize: 17.0),
                   "ConverterImage es una herramienta sencilla que permite convertir imágenes en matrices de bytes para su uso en pantallas OLED y TFT con Arduino. ") ,);
                }),
            SizedBox(
              width: 10,
              height: 30.0,
            ),
            btnImage(),
            SizedBox(
              width: 10,
              height: 20.0,
            ),
            SizedBox(
              //cargo la imagen
              child: cargarImage(context),
              width: 500,
              height: 200,
            ),
             SizedBox(
              width: 10,
              height: 20.0,
            ),
            cargarImage2(context),
          ],
        ),
      ),
    );
  }

  Widget cargarImage(BuildContext context) {
    if (file != null) {
      Img img = Img();
      img.file = file!;

      imgLoag = true;
      return Image.network(file!.path);
    } else {
      imgLoag = false;
      return Text("");
    }
  }

  Widget cargarImage2(BuildContext context) {
    if (file != null) {
      img.file = file!;


      return Visibility(child: btnOpciones(), visible: true);

   

    } else {
      return Visibility(child: btnOpciones(), visible: false);
    }
  }

  Widget btnOpciones() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
            onPressed: () {
              pushScren(context, 1);
            },
            child: Padding(
              padding: EdgeInsets.only(left: 20.0, right: 20.0),
              child: Text("TFT"),
            )),
        SizedBox(
          width: 20,
        ),
        ElevatedButton(
            onPressed: () {
              pushScren(context, 0);
            },
            child: Padding(
              padding: EdgeInsets.only(left: 20.0, right: 20.0),
              child: Text("OLED"),
            ))
      ],
    );
  }

  Widget btnImage() {
    return ElevatedButton(
        onPressed: () async {
          ImagePicker picker = ImagePicker();
          XFile? image = await picker.pickImage(source: ImageSource.gallery);
      
         // print("presione el boton");
          if (image != null) {
          //  print("deberia obtener la image");
            setState(() {
              print(image.path.toString());
              file = File(image.path);
              img.image = image;
            });
          }
        },
        child: Padding(padding: EdgeInsets.only(top: 20.0 , bottom: 20.0 , left: 50.0 , right: 50.0),child:Text("Seleccionar  Imagen" , style: TextStyle(fontSize: 20.0),)));
  }

  pushScren(BuildContext context, int id) {
    if (id == 0) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => oled()));
    }
    if (id == 1) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => tft()));
    }
  }

  Stream confirmarImg(bool imgLoad, BuildContext context) async* {
    if (imgLoag == true) {
     // yield* pushScren(context, 0);
      imgLoag = false;
    }
    ;
  }
}

 
