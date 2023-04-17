import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:imgtobitmap/class/img.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as IMG;

//import 'package:fast_image_resizer/fast_image_resizer.dart';

class tft extends StatefulWidget {
  const tft({super.key});

  @override
  State<tft> createState() => _tft();
}

class _tft extends State<tft> {
  double widthh = 128, heightt = 128;
  Img img = Img();
  Widget? imagen;
  @override
  void initState() {
    imagen = Image.network(img.file!.path);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Align(
              child: Text(
            "ImgToBitmap",
          )),
        ),
        body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

          SizedBox(
            height: 20.0,
            
          ),

          Center(child: Text(""),),
          StreamBuilder(
              stream: imgToBitmap(widthh, heightt),
              builder: (BuildContext, AsyncSnapshot) {
                // imgPrincipal(widthh, heightt);
                return SizedBox(width: 200, height: 200, child: imagen!);
              })
        ])));
  }

  Stream imgToBitmap(double width, double height) async* {
// Carga la imagen desde el archivo
    //threshold_value = int.parse(Controller3.text);

    final ImagePicker _picker = ImagePicker();
    Img img = Img();
    XFile imagee = img.image!;

    if (imagee != null) {
      //si la imagen es diferente a null combiertela en un uint8list
      final rawImage = await imagee.readAsBytes();

      IMG.Image? img3 = IMG.decodeImage(rawImage);
//IMG.Image? img3 = IMG.decodeJpg(rawImage);
      IMG.Image resized =
          IMG.copyResize(img3!, width: widthh.toInt(), height: heightt.toInt());
      convertToBinary(img3);
      print("ancho de imagen = " + resized.width.toString());
      print("largo de imagen = " + resized.height.toString());
      Uint8List resizedImg = Uint8List.fromList(IMG.encodePng(resized));
   //************************************
   //final convertedImage = IMG.decodeJpg(rawImage);
      
      final testing3 = Image.memory(Uint8List.view(resizedImg.buffer),
          width: widthh, height: heightt);

      print(resizedImg.length);
      final m = testing3;

      yield imagen = testing3;
    }
  }

  void convertToBinary(IMG.Image image) {
 // IMG.writeJpg( image );
    String cadena = "";
  int cont2=0;
    int contBynario=0;
    int contSaltoLinea=0;
    String cadenaPixeles="";
   // crear una nueva imagen con las mismas dimensiones
    for (var y = 0; y < image.height; ++y) {
      for (var x = 0; x < image.width; ++x) {
        contBynario++;
        final pixel = image.getPixel(x, y);
        
       int r=ui.Color(pixel).red;
        int g=ui.Color(pixel).green;
         int b=ui.Color(pixel).blue;
       
        // int color565 = ((pixel & 0xf80000) >> 8) + ((pixel & 0xFC00) >>5) + ((pixel & 0xf8) >> 3);//combierto elpixel a 565
       
          int color565 = ((b & 0xF8) << 8) | ((g & 0xFC) << 3) | (r >> 3);
        String pixel565=color565.toRadixString(16);

          if(y==0 && x ==10){

        

        

      int color5652 = ((b & 0xF8) << 8) | ((g & 0xFC) << 3) | (r >> 3);
      print("color " + color5652.toString());
        String pixel5652=color5652.toRadixString(16);
print("ui " + pixel5652);


         }

        if(pixel565 == "0"){
          pixel565 = "0000";
        }
       cadena += "0x" + pixel565 +" , ";
        
      
      }
    
    }
    int length=(widthh * heightt).toInt();
    cadena = "[$length]" + "{" + cadena +"}"; 
    print(cadena);
  }
}
