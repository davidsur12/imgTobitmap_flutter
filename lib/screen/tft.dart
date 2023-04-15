
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
  double widthh = 100, heightt = 100;
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

      IMG.Image resized =
          IMG.copyResize(img3!, width: widthh.toInt(), height: heightt.toInt());

      print("ancho de imagen = " + resized.width.toString());
      print("largo de imagen = " + resized.height.toString());
      Uint8List resizedImg = Uint8List.fromList(IMG.encodePng(resized));

      final testing3 = Image.memory(Uint8List.view(resizedImg.buffer),
          width: widthh, height: heightt);

      print(resizedImg.length);
      final m = testing3;

      yield imagen = testing3;
    }
  }
}
