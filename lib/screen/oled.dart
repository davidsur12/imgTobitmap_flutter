import 'package:flutter/material.dart';
import 'package:imgtobitmap/class/img.dart';

class oled extends StatefulWidget {
  const oled({super.key});

  @override
  State<oled> createState() => _oledState();
}

class _oledState extends State<oled> {
  Img img = Img();
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
    return Align( child:Column(
      //mainAxisAlignment: MainAxisAlignment.center,
      children: [
Container ( color:Colors.amberAccent,   child:Align(child:confWidth()))
     , Text("cente"),
    ],
    ));
  }

  Widget confWidth() {
    TextEditingController controlador = TextEditingController();
    return ( Row( mainAxisAlignment: MainAxisAlignment.center,children: [
      Text("Ancho"),
      SizedBox(width: 50),
Container(color: Colors.cyanAccent, child: SizedBox(width:200, child: TextField(decoration: InputDecoration(  
    
    hintText: 'Enter Your Name'  ))))
      
    ]));
  }
}
