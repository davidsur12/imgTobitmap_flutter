import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imgtobitmap/class/img.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:fast_image_resizer/fast_image_resizer.dart';
import 'dart:typed_data';

//https://pub.dev/packages/image_cropper
class oled extends StatefulWidget {
  const oled({super.key});

  @override
  State<oled> createState() => _oledState();
}

class _oledState extends State<oled> {
  Img img = Img();
  bool EstadoInvertirColores = false;
  String filecopper = "";
  Widget? imagen;
  bool cambio = false;
  double widthh = 100, heightt = 100;
  TextEditingController myController = TextEditingController(text: "123");

  //var imagen2 = Image.memory();
  @override
  void initState() {
    // TODO: implement initState

    //myController.addListener(_printLatestValue);
    imagen = Image.network("");
    super.initState();
  }

  //Image.network(img.file!.path)
  @override
  Widget build(BuildContext context) {
    //  croppie(context);
    return Scaffold(
      appBar: AppBar(
        title: Align(
            child: Text(
          "ImgToBitmap",
        )),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder(
                stream: imageResized(widthh, heightt),
                builder: (BuildContext, AsyncSnapshot) {
                  // imgPrincipal(widthh, heightt);
                  return imagen!;
                }) /*imgPrincipal() */,
            menuConfig()
          ],
        ),
      ),
    );
  }

  Widget imgPrincipal(double width, double height) {
    imagen = Image.network(img.file!.path);
    return Align(
        child: SizedBox(
            //   width: 200, height: 200, child: Image.network(img.file!.path)));
            width: width,
            height: height,
            child: imagen));
  }

  Widget menuConfig() {
    return Align(
        child: Column(
      //mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //color: Colors.amberAccent,
        Container(child: Align(child: confWidth())),
        // Container(child: Align(child: imagen  )),
        Container(child: Align(child: confHeight())),
        Container(child: Align(child: invColores())),
        Container(child: Align(child: invGrados())),
        Container(child: Align(child: VoltearImagen())),
        Container(child: Align(child: btn())),
      ],
    ));
  }

  Widget btn() {
    cambio = true;
/*
widthh=double.parse(myController.toString());
heightt=double.parse(myController.toString());
*/

    print("valor tect " + myController.text.toString());

    widthh = double.parse(myController.text.toString());
    heightt = double.parse(myController.text.toString());

    return ElevatedButton(
        onPressed: () {
          widthh = double.parse(myController.text.toString());
          heightt = double.parse(myController.text.toString());
          setState(() {
            //imagen=Image.network("");
            print("cambio la imagen");
            // print(imagen. width.toString());
          });
        },
        child: Text("btn"));
  }

  Widget confWidth() {
    TextEditingController controlador = TextEditingController();
    return (Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        "Width (px) :",
        style: Style(1),
      ),
      SizedBox(width: 50),
      Padding(
          padding: EdgeInsets.only(left: 7, top: 10, right: 7, bottom: 10),
          child: Container(
              //color: Colors.cyanAccent,
              child: SizedBox(
                  width: 200,
                  child: TextField(
                    controller: myController,
                    keyboardType: TextInputType.number,
                    maxLength: 4,
                    decoration: InputDecoration(
                        hintText: 'Ingresa un valor',
                        border: OutlineInputBorder()),
                  ))))
    ]));
  }

  Widget confHeight() {
    TextEditingController controlador = TextEditingController();
    return (Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        "Height (px) :",
        style: Style(1),
      ),
      SizedBox(width: 50),
      Padding(
          padding: EdgeInsets.only(left: 7, top: 10, right: 7, bottom: 10),
          child: Container(
              //color: Colors.cyanAccent,
              child: SizedBox(
                  width: 200,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    maxLength: 4,
                    decoration: InputDecoration(
                        hintText: 'Ingresa un valor',
                        border: OutlineInputBorder()),
                  ))))
    ]));
  }

  Widget invColores() {
    return (Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        "Invertir Colores  :",
        style: Style(1),
      ),
      SizedBox(width: 50),
      Padding(
          padding: EdgeInsets.only(left: 7, top: 10, right: 7, bottom: 10),
          child: Container(
              //color: Colors.cyanAccent,
              child: SizedBox(
                  width: 200,
                  child: Checkbox(
                    value: EstadoInvertirColores,
                    onChanged: (newvalue) => {
                      setState(() {
                        EstadoInvertirColores = newvalue!;
                      })
                    },
                  ))))
    ]));
  }

  Widget invGrados() {
    return (Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        "Invertir  :",
        style: Style(1),
      ),
      SizedBox(width: 50),
      Text(
        "90",
        style: Style(1),
      ),
      Padding(
          padding: EdgeInsets.only(left: 0, top: 10, right: 7, bottom: 10),
          child: Container(
              // color: Colors.cyanAccent,
              child: SizedBox(
                  child: Checkbox(
            value: EstadoInvertirColores,
            onChanged: (newvalue) => {
              setState(() {
                EstadoInvertirColores = newvalue!;
              })
            },
          )))),
      SizedBox(width: 50),
      Text(
        "180",
        style: Style(1),
      ),
      Padding(
          padding: EdgeInsets.only(left: 0, top: 10, right: 7, bottom: 10),
          child: Container(
              // color: Colors.cyanAccent,
              child: SizedBox(
                  child: Checkbox(
            value: EstadoInvertirColores,
            onChanged: (newvalue) => {
              setState(() {
                EstadoInvertirColores = newvalue!;
              })
            },
          ))))
    ]));
  }

  Widget VoltearImagen() {
    return (Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        "Voltear Imagen  :",
        style: Style(1),
      ),
      SizedBox(width: 50),
      Text(
        "Horizontal",
        style: Style(1),
      ),
      Padding(
          padding: EdgeInsets.only(left: 0, top: 10, right: 3, bottom: 10),
          child: Container(
              // color: Colors.cyanAccent,
              child: SizedBox(
                  child: Checkbox(
            value: EstadoInvertirColores,
            onChanged: (newvalue) => {
              setState(() {
                EstadoInvertirColores = newvalue!;
              })
            },
          )))),
      SizedBox(width: 50),
      Text(
        "Vertical",
        style: Style(1),
      ),
      Padding(
          padding: EdgeInsets.only(left: 0, top: 10, right: 3, bottom: 10),
          child: Container(
              // color: Colors.cyanAccent,
              child: SizedBox(
                  child: Checkbox(
            value: EstadoInvertirColores,
            onChanged: (newvalue) => {
              setState(() {
                EstadoInvertirColores = newvalue!;
              })
            },
          ))))
    ]));
  }

  TextStyle Style(int id) {
    if (id == 1) {
      return TextStyle(
        fontSize: 18,
      );
    } else {
      return TextStyle(
        fontSize: 70,
      );
    }
  }

  Future croppie(BuildContext context) async {
//var c= await ImageCropper().cropImage(sourcePath:"img.file!.path" );
    print("iniciando");

    var cropper = await ImageCropper().cropImage(
      sourcePath: img.file!.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ], /*compressQuality: 60, 
          maxHeight: 100, 
          maxWidth: 100
          , uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
        WebUiSettings(
          context: context,
        ),
      ],*/
    );

    print("ruta = " + filecopper);
    setState(() {
      filecopper = (cropper != null) ? cropper!.path : "";
      print("ruta = " + filecopper);
    });
  }

  Stream cambiopropiedades() async* {
    if (imagen != null) {
      yield* imageResized(90, 90);
    }
  }

  Stream imageResized(double width, double height) async* {
    if (cambio) {
      print("cambio de build");
      final ImagePicker _picker = ImagePicker();
//final XFile? image =
      //  await _picker.pickImage(source: ImageSource.gallery);
      XFile image = img.image!;
      if (image != null) {
        final rawImage = await image.readAsBytes();
        final bytes = await resizeImage(Uint8List.view(rawImage.buffer),
            width: width.toInt(), height: height.toInt());
        if (bytes != null) {
           print(bytes.toString());
           print(bytes.buffer);
           print(bytes.lengthInBytes);
           print(bytes.elementSizeInBytes);

          final testing = Image.memory(Uint8List.view(bytes.buffer),
              width: width, height: height);
          // imagen=testing;

          cambio = false;
          yield imagen = testing;
          print("algo esta camband");

          /*
setState(() {
 imagen=testing;
  print("new image");
 // print(imagen. width.toString());
});*/
          /* showDialog(
            context: context,
            builder: (BuildContext context) {
                return AlertDialog(
                    title: Text("Image ancho = " + testing.height.toString()),
                    content: testing,
                );
            }
        );*/
        }
      }
    }
  }

/*
  void croppie() async{
    File cropper = await ImageCropper.cropImage(
          sourcePath: pickedFile.path,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio7x5,
            CropAspectRatioPreset.ratio16x9
          ],
          compressQuality: 60,
          maxHeight: 500,
          maxWidth: 500,
          compressFormat: ImageCompressFormat.jpg,
          androidUiSettings: AndroidUiSettings(
              toolbarColor: Colors.blue,
              toolbarTitle: "Recorta la imagen",
              toolbarWidgetColor: Colors.white,
              backgroundColor: Colors.white));
setState(() {
        _selectedImage = cropper;
      })

  }
  */

}
