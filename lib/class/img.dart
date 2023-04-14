import 'dart:io';

import 'package:image_picker/image_picker.dart';

class Img {
  File? file;
  XFile? image;
  String name="";
  static final Img imagen = Img._internal();

  factory Img() {
   
    return imagen;

  }

Img._internal(){
//name=image!.name;

}
}