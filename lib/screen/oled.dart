import 'dart:io';
import 'dart:ui' as ui;


import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imgtobitmap/class/img.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:fast_image_resizer/fast_image_resizer.dart';
import 'dart:typed_data';
import 'package:buffer_image/buffer_image.dart';
import 'package:image/image.dart' as IMG;


//https://pub.dev/packages/image_cropper
//https://pub.dev/packages/easy_image_editor
//buffer_image: ^0.3.12 para editar imagenes de pixeles
//https://www.fluttercampus.com/guide/358/resize-image-flutter/
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
  TextEditingController Controller1 = TextEditingController(text: "123");
   TextEditingController Controller2 = TextEditingController(text: "123");
   BufferImage bimg=BufferImage(123, 123);
   Image? im;

  //var imagen2 = Image.memory();
  @override
  void initState() {
    // TODO: implement initState

    //myController.addListener(_printLatestValue);
    for (int i = 0; i < 123; i++) {
    for (int j = 0; j < 123; j++) {
    bimg.setColor(
        i, j, Colors.primaries[(i * 100 + j) % Colors.primaries.length]);
    }
}
//im=Image.network(img.file!.path);
RgbaImage imageee = RgbaImage.fromBufferImage(bimg, scale: 1);
imageee.bytes;
 final testingg = Image.memory(imageee.bytes,
              width: 123, height: 123);
im=testingg;
 //-------------------------------------/
    imagen = Image.network(img.file!.path);
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
                stream: imgToBitmap(widthh ,  heightt),
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
      //   Container(child: Align(child: im  )),
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

    print("valor tect " + Controller1.text.toString());

    widthh = double.parse(Controller1.text.toString());
    heightt = double.parse(Controller2.text.toString());

    return ElevatedButton(
        onPressed: () {
          widthh = double.parse(Controller1.text.toString());
          heightt = double.parse(Controller2.text.toString());
          setState(() {
            //imagen=Image.network("");
            print("cambio la imagen");
            // print(imagen. width.toString());
          });
        },
        child: Text("Cargar"));
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
                    controller: Controller1,
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
                    controller: Controller2,
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
      ], 
    );

    print("ruta = " + filecopper);
    setState(() {
      filecopper = (cropper != null) ? cropper.path : "";
      print("ruta = " + filecopper);
    });
  }
//--------------------------------------------------------------------
  Stream cambiopropiedades() async* {
    if (imagen != null) {
      yield* imageResized(90, 90);
    }
  }





Stream imgToBitmap(double width, double height)async*{

// Carga la imagen desde el archivo
   final ImagePicker _picker = ImagePicker();
  Img img=Img();
    XFile imagee = img.image!;
    if (imagee != null){
      final rawImage = await imagee.readAsBytes();
      /*
        final bytedata = await resizeImage(Uint8List.view(rawImage.buffer),
            width: widthh.toInt(), height: heightt.toInt());

            final testing = Image.memory(Uint8List.view(bytedata!.buffer),
              width: widthh, height: heightt);

 
  final pngBytes = bytedata.buffer.asUint8List();//es un bitmap
 final bitmapData = Uint8List.fromList(pngBytes);*/


   

//Uint8List bytes3 = (await NetworkAssetBundle(Uri.parse(imgurl)).load(imgurl)).buffer.asUint8List();
IMG.Image? img3 = IMG.decodeImage(rawImage);
IMG.Image resized = IMG.copyResize(img3!, width: widthh.toInt(), height: heightt.toInt());
IMG.grayscale(resized );
resized= convertToBinary(resized, 120);
print("ancho de imagen = " + resized.width.toString());
print("largo de imagen = " + resized.height.toString());

 //IMG.gaussianBlur(resized, 128);
Uint8List resizedImg = Uint8List.fromList(IMG.encodePng(resized));
 

final testing2 = Image.memory(Uint8List.view(resizedImg.buffer),
              width: widthh, height: heightt);
 
  
  // Imprime el resultado (bitmap binario)
  //print("width " + resizedImg.toString());

//--------------binarizar imagen--------------


  // Convierte la imagen a escala de grises

  /*
  IMG _image= img.copyResize(
    sneaker_image, 
    width: 28, 
    height: 28, 
    interpolation: interpolation);


*/

//-------------------------------------------
  print(resizedImg.length);

yield imagen=testing2;
    }

}


IMG.Image convertToBinary(IMG.Image image, int threshold) {
  final output = IMG.Image(image.width, image.height); // crear una nueva imagen con las mismas dimensiones
  for (var y = 0; y < image.height; ++y) {
    for (var x = 0; x < image.width; ++x) {
      final pixel = image.getPixel(x, y);
      final gray = IMG.getLuminance(pixel);
      if (gray > threshold) {
        output.setPixel(x, y, IMG.getColor(255, 255, 255)); // pixel blanco
      } else {
        output.setPixel(x, y, IMG.getColor(0, 0, 0)); // pixel negro
      }
    }
  }
  return output;
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

          BufferImage bimg=BufferImage(width, height);
        //  im=RgbaImage(rawImage, width: widthh.toInt(), height: height.toInt());
          


          final testing = Image.memory(Uint8List.view(bytes.buffer),
              width: width, height: height);
       // BufferImage imgg=BufferImage();

          cambio = false;
          yield imagen = testing;
          //yield imagen! = imm;
          print("algo esta camband");

   
        }
      }
    }
  }

}
