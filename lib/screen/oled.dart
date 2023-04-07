import 'package:flutter/material.dart';
import 'package:imgtobitmap/class/img.dart';




//https://pub.dev/packages/image_cropper
class oled extends StatefulWidget {
  const oled({super.key});

  @override
  State<oled> createState() => _oledState();
}

class _oledState extends State<oled> {
  Img img = Img();
  bool EstadoInvertirColores=false;
  //Image.network(img.file!.path)
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
          children: [imgPrincipal(), menuConfig()],
        ),
      ),
    );
  }

  Widget imgPrincipal() {
    return Align(
        child: SizedBox(
            width: 200, height: 200, child: Image.network(img.file!.path)));
  }

  Widget menuConfig() {
    return Align(
        child: Column(
      //mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //color: Colors.amberAccent,
        Container(child: Align(child: confWidth())),
        Container(child: Align(child: confHeight())),
        Container(child: Align(child: invColores())),
        Container(child: Align(child: invGrados())),
        Container(child: Align(child: VoltearImagen())),
      ],
    ));
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
                  
                      setState((){
                       EstadoInvertirColores=newvalue!;
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
                  
                      setState((){
                       EstadoInvertirColores=newvalue!;
                      })
                    },
                  )
                  )
                  )
                  ),
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
                  
                      setState((){
                       EstadoInvertirColores=newvalue!;
                      })
                    },
                  )
                  )
                  )
                  )
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
                  
                      setState((){
                       EstadoInvertirColores=newvalue!;
                      })
                    },
                  )
                  )
                  )
                  ),
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
                  
                      setState((){
                       EstadoInvertirColores=newvalue!;
                      })
                    },
                  )
                  )
                  )
                  )
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
/*
  void croppie(){
    File cropper = await ImageCropp.cropImage(
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
