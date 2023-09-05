import 'dart:io';
import 'dart:ui' as ui;
import 'dart:html' as html;
import 'package:download/download.dart';

//import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imgtobitmap/class/img.dart';
//import 'package:image_cropper/image_cropper.dart';
import 'package:fast_image_resizer/fast_image_resizer.dart';
//import 'dart:typed_data';
import 'package:buffer_image/buffer_image.dart';
import 'package:image/image.dart' as IMG;
import 'package:imgtobitmap/class/conversor.dart';
import 'package:text_area/text_area.dart';
import 'package:flutter/services.dart';

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
  int contInvGrados = 0;
  bool rotar90 = false, rotar180 = false;
  String filecopper = "";
  Widget? imagen;
  bool cambio = false;
  double widthh = 100, heightt = 100;
  TextEditingController Controller1 = TextEditingController(text: "123");
  TextEditingController Controller2 = TextEditingController(text: "123");
  TextEditingController Controller3 = TextEditingController(text: "130");
  TextEditingController Controller4 = TextEditingController(text: "");
  BufferImage bimg = BufferImage(123, 123);
  Image? im;
  int threshold_value = 130;
  String cadenaResult = "";

  @override
  void initState() {
    // TODO: implement initState

   // RgbaImage imageee = RgbaImage.fromBufferImage(bimg, scale: 1);
    //imageee.bytes;
    //final testingg = Image.memory(imageee.bytes, width: 123, height: 123);
    //im = testingg;
    //-------------------------------------/
    imagen = Image.network(img.file!.path);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return 
    MaterialApp(
       theme: ThemeData(
        // Define el Brightness y Colores por defecto
        //brightness: Brightness.dark,
       // primaryColor: Colors.lightBlue[800],
         primarySwatch: Colors.blue,
      scaffoldBackgroundColor: Color.fromARGB(95, 242, 150, 92),
        //accentColor: Colors.cyan[600],
        ),
      home: 
    Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: true,
        leading: IconButton(icon:Icon(Icons.home),
          onPressed: () { Navigator.pop(context);},
        ),
        backgroundColor: Color.fromARGB(255, 32, 30, 131),
      
        title: Align(
            child: Text(
          "ConverterImage",
        )),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20.0,
            ),
            StreamBuilder(
                stream: imgToBitmap(widthh, heightt),
                builder: (BuildContext, AsyncSnapshot) {
                  // imgPrincipal(widthh, heightt);
                  return SizedBox(width: 200, height: 200, child: imagen!);
                }) /*imgPrincipal() */,
            SizedBox(
              height: 20.0,
            ),
            menuConfig()
          ],
        ),
      ),
    )
  );
  
  
  }

  Widget imgPrincipal(double width, double height) {
    imagen = Image.network(img.file!.path);
    return Align(child: SizedBox(width: width, height: height, child: imagen));
  }

  Widget menuConfig() {
    return Align(
        child: Column(
      children: [
        Container(child: Align(child: confWidth())),
        Container(child: Align(child: confHeight())),
        Container(child: Align(child: threshold())),
        Container(child: Align(child: invColores())),
        SizedBox(
          height: 10.0,
        ),
        Container(width: 300, child: Align(child: btn())),
        SizedBox(
          height: 10.0,
        ),
        Container(width: 300, child: Align(child: invGrados())),
        SizedBox(
          height: 10.0,
        ),
          Container(width: 300, child: Align(child: btnDescarga())),
        SizedBox(
          height: 10.0,
        ),
        Text(
          "Codigo para Arduino",
          style: Style(1),
        ),
        SizedBox(
          height: 10.0,
        ),
        Container(width: 800, child: Align(child: bitmapText2())),
        SizedBox(
          height: 10.0,
        ),
         

      ],
    ));
  }

Widget btnDescarga(){
//return ElevatedButton(child: Text("Descargar Archivo"), onPressed: (){createTxt(cadenaResult);},);
  return ElevatedButton( 
    style: ButtonStyle(  backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 32, 30, 131))),
        onPressed: () {
         createTxt(cadenaResult);
        },
        child: Padding(
          padding: EdgeInsets.only(left: 29.0, right: 29.0),
          child: Text(
            "Descargar Archivo",
            style: Style(3),
          ),
        ));
  }

  Widget bitmapText() {
    return TextField(
      decoration:
          InputDecoration(labelText: "Resultado", border: OutlineInputBorder()),
      controller: Controller4,
      minLines: 6,
      maxLines: null,
    );
  }

  Widget bitmapText2() {
    return TextArea(
      borderRadius: 10,
      borderColor: const Color(0xFFCFD6FF),
      textEditingController: Controller4,
      suffixIcon: Icons.attach_file_rounded,
      onSuffixIconPressed: () =>
          {Clipboard.setData(ClipboardData(text: cadenaResult))},
      validation: true,
      errorText: 'error',
    );
  }

  Widget btn() {
    cambio = true;

    threshold_value = int.parse(Controller3.text);
    setState(() {
      threshold_value = int.parse(Controller3.text);
    });

    widthh = double.parse(Controller1.text.toString());
    heightt = double.parse(Controller2.text.toString());
    threshold_value = double.parse(Controller2.text.toString()).toInt();
    return (ElevatedButton(
      style: ButtonStyle(  backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 32, 30, 131))),
        onPressed: () {
          widthh = double.parse(Controller1.text.toString());
          heightt = double.parse(Controller2.text.toString());
          threshold_value = double.parse(Controller2.text.toString()).toInt();
          setState(() {
            // print("cambio la imagen");
            threshold_value = int.parse(Controller3.text);
          });
        },
        child: Padding(
            padding: EdgeInsets.only(right: 42, left: 42),
            child: Text("Redimencionar ", style: Style(3)))));
  }

  Widget threshold() {
    return (Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        "Threshold :",
        style: Style(1),
      ),
      SizedBox(width: 50),
      Padding(
          padding: EdgeInsets.only(left: 7, top: 10, right: 7, bottom: 10),
          child: Container(
              child: SizedBox(
                  width: 200,
                  child: TextField(

                    controller: Controller3,
                    keyboardType: TextInputType.number,
                    maxLength: 3,
                    decoration: InputDecoration(
                    
                        hintText: 'Ingresa un valor',
                        border: OutlineInputBorder(),
                          filled:true,
                      fillColor:Colors.white,),
                  ))))
    ]));
  }

  Widget confWidth() {
    return (Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        "Width (px) :",
        style: Style(1),
      ),
      SizedBox(width: 50),
      Padding(
          padding: EdgeInsets.only(left: 7, top: 10, right: 7, bottom: 10),
          child: Container(
              child: SizedBox(
                  width: 200,
                  child: TextField(
                    controller: Controller1,
                    keyboardType: TextInputType.number,
                    maxLength: 3,
                    decoration: InputDecoration(
                        hintText: 'Ingresa un valor',
                        border: OutlineInputBorder(),
                          filled:true,
                      fillColor:Colors.white,),
                  ))))
    ]));
  }

  Widget confHeight() {
    return (Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        "Height (px) :",
        style: Style(1),
      ),
      SizedBox(width: 50),
      Padding(
          padding: EdgeInsets.only(left: 7, top: 10, right: 7, bottom: 10),
          child: Container(
              child: SizedBox(
                  width: 200,
                  child: TextField(
                    controller: Controller2,
                    keyboardType: TextInputType.number,
                    maxLength: 3,
                    decoration: InputDecoration(
                        hintText: 'Ingresa un valor',
                        border: OutlineInputBorder(),
                          filled:true,
                      fillColor:Colors.white,),
                  ))))
    ]));
  }

  Widget invColores() {
    return (Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        "Invertir Colores  ",
        style: Style(1),
      ),
      SizedBox(width: 50),
      (Container(
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

  Widget fila() {
    return Expanded(
        child: ElevatedButton(
          style: ButtonStyle(  backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 32, 30, 131))),
      onPressed: () {
        setState(() {
          contInvGrados++;
          if (contInvGrados == 5) {
            contInvGrados = 1;
          }
        });
      },
      child: Text(
        "Invertir  ",
        style: Style(3),
      ),
    ));
  }

  Widget invGrados() {
    return (((ElevatedButton(
      style: ButtonStyle(  backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 32, 30, 131))),
        onPressed: () {
          setState(() {
            contInvGrados++;
            if (contInvGrados == 5) {
              contInvGrados = 1;
            }
          });
        },
        child: Padding(
          padding: EdgeInsets.only(left: 85.0, right: 85.0),
          child: Text(
            "Girar",
            style: Style(3),
          ),
        )))));
  }
/*
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
  */

  TextStyle Style(int id) {
    if (id == 1) {
      return const TextStyle(
        color: Color.fromARGB(255, 32, 30, 131),
        fontSize: 20,
        fontWeight: FontWeight.bold,
        
      );
    }  if (id == 3) {
      return const TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      );
    }else {
      return TextStyle(
        fontSize: 70,
      );
    }
  }
/*
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
  */

//--------------------------------------------------------------------

  Stream imgToBitmap(double width, double height) async* {
// Carga la imagen desde el archivo
    threshold_value = int.parse(Controller3.text);

    final ImagePicker _picker = ImagePicker();
    Img img = Img();
    XFile imagee = img.image!;

    if (imagee != null) {
      final rawImage = await imagee.readAsBytes();

      IMG.Image? img3 = IMG.decodeImage(rawImage);

      var im = img3; //IMG.copyRotate(img3!, (0));
      if (contInvGrados > 0) {
        im = IMG.copyRotate(img3!, (contInvGrados * 90));
      }

      IMG.Image resized =
          IMG.copyResize(im!, width: widthh.toInt(), height: heightt.toInt());
      IMG.grayscale(resized);

      resized = convertToBinary(resized, 0);

      //print("ancho de imagen = " + resized.width.toString());
      //print("largo de imagen = " + resized.height.toString());
      // print("valot threshold $threshold_value");
      //IMG.gaussianBlur(resized, 128);
      Uint8List resizedImg = Uint8List.fromList(IMG.encodePng(resized));

      final testing2 = Image.memory(Uint8List.view(resizedImg.buffer),
          width: widthh, height: heightt);

      final testing3 = Image.memory(Uint8List.view(resizedImg.buffer),
          width: widthh, height: heightt);

      print(resizedImg.length);

      yield imagen = testing2;
    }
  }

  IMG.Image convertToBinary(IMG.Image image, int threshold) {
    String cadena = "";
    cadenaResult = "";
    int contBynario = 0;
    int contSaltoLinea = 0;
    String cadenaBynaria = "";
    final output = IMG.Image(image.width,
        image.height); // crear una nueva imagen con las mismas dimensiones
    for (var y = 0; y < image.height; ++y) {
      for (var x = 0; x < image.width; ++x) {
        contBynario++;
        final pixel = image.getPixel(x, y);
        if (EstadoInvertirColores) {
          if (ui.Color(pixel).red >= threshold_value) {
            output.setPixel(x, y, IMG.getColor(255, 255, 255)); // pixel blanco
            cadena += ".";
            cadenaBynaria += "1";
          } else {
            output.setPixel(x, y, IMG.getColor(0, 0, 0)); // pixel negro
            cadena += " ";
            cadenaBynaria += "0";
          }
        }

        if (!EstadoInvertirColores) {
          if (ui.Color(pixel).red >= threshold_value) {
            output.setPixel(x, y, IMG.getColor(0, 0, 0)); // pixel negro
            cadena += " ";
            cadenaBynaria += "0";
          } else {
            output.setPixel(x, y, IMG.getColor(255, 255, 255)); // pixel blanco
            cadena += ".";
            cadenaBynaria += "1";
          }
        }

        if (contBynario == 8) {
          contSaltoLinea++;
          contBynario = 0;
          cadenaResult +=
              "0x" + Coversor.binarioToHexadecimal(cadenaBynaria) + ", ";

          cadenaBynaria = "";
          if (contSaltoLinea == 12) {
            contSaltoLinea = 0;
            cadenaResult += "\n";
          }
        }
      }
      cadena += "\n";
    }
    //print(cadena);

    /*
    // 'WhatsApp Image 2023-04-11 at 6', 720x1155px
const unsigned char epd_bitmap_WhatsApp_Image_2023_04_11_at_6 [] PROGMEM = { */
    String name = img.image!.name;
    cadenaResult =
        "//$name , $widthh x $heightt \n   #define Width $widthh  \n  #define Height $heightt \n const unsigned char Bitmap [] PROGMEM = {" +
            cadenaResult +
            "};";
    Controller4.text = cadenaResult;

//print(cadenaResult);
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
          // print(bytes.toString());
          // print(bytes.buffer);
          // print(bytes.lengthInBytes);
          // print(bytes.elementSizeInBytes);

          BufferImage bimg = BufferImage(width, height);
          //  im=RgbaImage(rawImage, width: widthh.toInt(), height: height.toInt());

          final testing = Image.memory(Uint8List.view(bytes.buffer),
              width: width, height: height);
          // BufferImage imgg=BufferImage();

          cambio = false;
          yield imagen = testing;
          //yield imagen! = imm;
          print("cambio");
        }
      }
    }
  }
void createTxt(String txt){
String name=img.image!.name.toString();
int index=name.indexOf(".");
name=name.substring(0 , index);
//print("nombre del archivo " + name + " con inde "  +index.toString());
  final stream = Stream.fromIterable(txt.codeUnits);
download(stream, '$name.h');
}
  
}
