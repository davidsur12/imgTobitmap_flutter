import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:imgtobitmap/class/img.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as IMG;
import 'package:text_area/text_area.dart';
import 'package:flutter/services.dart';
import 'package:download/download.dart';

//import 'package:fast_image_resizer/fast_image_resizer.dart';

class tft extends StatefulWidget {
  const tft({super.key});

  @override
  State<tft> createState() => _tft();
}

class _tft extends State<tft> {
  double widthh = 128, heightt = 128;
   int contInvGrados = 0;
    bool cambio = false;
      String cadenaResult="";
  Img img = Img();
  Widget? imagen;
    TextEditingController Controller1 = TextEditingController(text: "128");
  TextEditingController Controller2 = TextEditingController(text: "160");
  TextEditingController Controller4 = TextEditingController(text: "");
  
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
            "ConverterImage",
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
              }
              ),
               Container(child: Align(child: confWidth())),
        //   Container(child: Align(child: im  )),
        Container(child: Align(child: confHeight())),
         Container(width: 300,  child: Align(child: btn())),
            SizedBox(height: 10.0,),
         Container(width: 300 , child: Align(child: invGrados())),
           SizedBox(height: 10.0,),
             Container(width: 300, child: Align(child: btnDescarga())),
        SizedBox(
          height: 10.0,
        ),
        Text("Codigo para Arduino" , style: Style(1),),
         SizedBox(height: 10.0,),
         Container( width: 800 , child: Align(child: bitmapText2())),
           SizedBox(height: 10.0,),

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
     var im =  img3;//IMG.copyRotate(img3!, (0));
      if (contInvGrados > 0) {
         im = IMG.copyRotate(img3!, (contInvGrados * 90));
        //print("grados $contInvGrados");

      }
      IMG.Image resized =
          IMG.copyResize(im!, width: widthh.toInt(), height: heightt.toInt());
      convertToBinary(im);
   //   print("ancho de imagen = " + resized.width.toString());
    //  print("largo de imagen = " + resized.height.toString());
      Uint8List resizedImg = Uint8List.fromList(IMG.encodePng(resized));
   //************************************
   //final convertedImage = IMG.decodeJpg(rawImage);
      
      final testing3 = Image.memory(Uint8List.view(resizedImg.buffer),
          width: widthh, height: heightt);

     // print(resizedImg.length);
      final m = testing3;

      yield imagen = testing3;
    }
  }
  
 Widget bitmapText2(){


    return TextArea(
                  borderRadius: 10,
                  borderColor: const Color(0xFFCFD6FF),
                  textEditingController: Controller4,
                  suffixIcon: Icons.attach_file_rounded,
                  onSuffixIconPressed: () => {
                   Clipboard.setData(ClipboardData(text:cadenaResult))
                  },
                  validation: true,
                  errorText: 'error',
                );
  }

    Widget btn() {
    cambio = true;

   
    setState(() {
     // threshold_value = int.parse(Controller3.text);
    });

    //print("valor tect " + Controller1.text.toString());

    widthh = double.parse(Controller1.text.toString());
    heightt = double.parse(Controller2.text.toString());
   // threshold_value = double.parse(Controller2.text.toString()).toInt();
    return (ElevatedButton(
        onPressed: () {
          widthh = double.parse(Controller1.text.toString());
          heightt = double.parse(Controller2.text.toString());
      //    threshold_value = double.parse(Controller2.text.toString()).toInt();
          setState(() {
            //imagen=Image.network("");
            print("cambio ");
            //threshold_value = int.parse(Controller3.text);
            // print(imagen. width.toString());
          });
        },
        child: Padding( padding:  EdgeInsets.only(right: 42 , left: 42), child:Text("Redimencionar " , style: Style(1)))));
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
              //color: Colors.cyanAccent,
              child: SizedBox(
                  width: 200,
                  child: TextField(
                    controller: Controller1,
                    keyboardType: TextInputType.number,
                    maxLength: 3,
                    decoration: InputDecoration(
                        hintText: 'Ingresa un valor',
                        border: OutlineInputBorder()),
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
              //color: Colors.cyanAccent,
              child: SizedBox(
                  width: 200,
                  child: TextField(
                    controller: Controller2,
                    keyboardType: TextInputType.number,
                    maxLength: 3,
                    decoration: InputDecoration(
                        hintText: 'Ingresa un valor',
                        border: OutlineInputBorder()),
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
  Widget invGrados() {
    return (//Row(mainAxisAlignment: MainAxisAlignment.center , mainAxisSize: MainAxisSize.max, children: [
   (   (  ElevatedButton(
        onPressed: () {
          setState(() {
            contInvGrados++;
            if (contInvGrados == 5) {
              contInvGrados = 1;
            }
          });
        },
        child: Padding(padding: EdgeInsets.only(left: 85.0 , right: 85.0) , child:  Text(
          "Girar",
          style: Style(1),
        ),) 
      )
      )
      )
    //])
    );
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
     // print("color " + color5652.toString());
        String pixel5652=color5652.toRadixString(16);
//print("ui " + pixel5652);


         }

        if(pixel565 == "0"){
          pixel565 = "0000";
        }
       cadena += "0x" + pixel565 +" , ";
        
      
      }
    
    }
    int length=(widthh * heightt).toInt();
    double size=widthh*heightt;
    cadena = "const unsigned short image[$size] PROGMEM = " + "{" + cadena +"};";
    cadenaResult=cadena;
    Controller4.text=cadena;
   // print(cadena);
  }
  Widget btnDescarga(){
//return ElevatedButton(child: Text("Descargar Archivo"), onPressed: (){createTxt(cadenaResult);},);
  return ElevatedButton( 
        onPressed: () {
         createTxt(cadenaResult);
        },
        child: Padding(
          padding: EdgeInsets.only(left: 29.0, right: 29.0),
          child: Text(
            "Descargar Archivo",
            style: Style(1),
          ),
        ));
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
