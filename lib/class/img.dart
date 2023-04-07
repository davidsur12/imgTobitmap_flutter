import 'dart:io';

class Img {
  File? file;
  static final Img imagen = Img._internal();

  factory Img() {
    return imagen;
  }

Img._internal(){


}
}