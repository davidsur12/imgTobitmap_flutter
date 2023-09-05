import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imgtobitmap/class/img.dart';
import 'package:imgtobitmap/screen/oled.dart';
import 'package:imgtobitmap/screen/tft.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'ImgtoBitmap'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  File? file;
  StringBuffer? path;
  bool imgLoag = false;
  Img img = Img();
// final file2 = File('file.txt');

  @override
  void initState() {
    _counter = 0;
    super.initState();
  }

  Future selectImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc'],
    );
  }

  Widget imgg(File file) {
    if (file != null) {
      return Text(file.toString());
    } else {
      return Text("null");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      theme: ThemeData(
        // Define el Brightness y Colores por defecto
        //brightness: Brightness.dark,
       // primaryColor: Colors.lightBlue[800],
         primarySwatch: Colors.blue,
      scaffoldBackgroundColor: Color.fromARGB(95, 242, 150, 92),
        //accentColor: Colors.cyan[600],
        ),
        
      //color: Color.fromARGB(255, 32, 30, 131),
      title: "ConverterImage",
      home:Scaffold(
      appBar: AppBar(
        backgroundColor:  Color.fromARGB(255, 32, 30, 131),
        title: Align(child: Text('ConverterImage' ,)),
        elevation: 20,
      ),
      body: SingleChildScrollView(child:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height:5),
            Text(
              "ConverterImage",
              style: TextStyle(fontSize: 50 , color:  Color.fromARGB(255, 32, 30, 131)),
            ),
            SizedBox(
              height: 30.0,
            ),
            StreamBuilder(
                stream: confirmarImg(imgLoag, context),
                builder: (BuildContext, AsyncSnapshot) {
                  return
                 Container( 
                  width: 800,
                  child: Padding(padding: EdgeInsets.only(left: 15.0 , right: 15.0) , child:
                   Text( textAlign: TextAlign.center,
                   style:TextStyle(fontSize: 24.0, color: Color.fromARGB(255, 32, 30, 131)),
                   "ConverterImage es una herramienta sencilla que permite convertir imágenes en matrices de bytes para su uso en pantallas OLED y TFT con Arduino. ") ,)
            );
                }),
            SizedBox(
              width: 10,
              height: 30.0,
            ),
            btnImage(),
            SizedBox(
              width: 10,
              height: 20.0,
            ),
           
           Loadimage(),
           /* SizedBox(
              //cargo la imagen
              child: cargarImage(context),
              width: 500,
              height: 200,
            ),*/
             SizedBox(
              width: 10,
              height: 10.0,
            ),
            cargarImage2(context),
            SizedBox(
          width: 10,
        ),
            info(),
          
          ],
        ),
      ),)
    ));
  }

Widget info(){
  double widt=MediaQuery.of(context).size.width;
  print("Tamaño  $widt");
if(MediaQuery.of(context).size.width > 888){
return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [targeta(),targeta2()],
  );
}else{
return Column(  mainAxisAlignment: MainAxisAlignment.center , children: [targeta(),targeta2()],);
    
  }

return Text("");

}
Widget targeta(){
TextStyle style = TextStyle(fontSize: 20, color:Colors.white);
TextStyle styleTitle = TextStyle(fontSize: 30 , color:Colors.white);
  return Container(
    decoration: BoxDecoration(
      //shape: BoxShape.circle,
        borderRadius: BorderRadius.circular(20),
         color: Color.fromARGB(255, 32, 30, 131),
    
    ),
   
    padding: EdgeInsets.all(15),
    margin: EdgeInsets.all(15),
    width: 400,
    height: 400,
    child:Column(children:[
    
      Text("TFT" , style:styleTitle),
      Image.asset("assets/tft.png", width: 200,),
Text("Si estás buscando cómo mostrar una imagen en una pantalla TFT con Arduino, consulta el siguiente ejemplo" , 
textAlign: TextAlign.center,
style: style,

),

SizedBox(height:64),
ElevatedButton(
  style: ButtonStyle(  backgroundColor: MaterialStateProperty.all(Colors.white)),
  onPressed: (){

  //launchUrl(Uri(scheme: "https://github.com/davidsur12/EjemploOled.git"));
  _launchUrl("github.com/davidsur12/EjemploTFT.git");
}, child: 
Container(
 //Color.fromARGB(95, 242, 150, 92)
 //Color.fromARGB(255, 32, 30, 131)
 height:50,
  padding: EdgeInsets.only(left: 20, right: 20, top:10, bottom: 10),
  child:Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset("assets/githubBlack.png", width: 28,),
      SizedBox(width:10),
      Text("Codigo", style: TextStyle(color:Color.fromARGB(255, 111, 110, 172,),fontWeight: FontWeight.bold, ))],)
  )
  )

  ]
  )
  );
}


Widget targeta2(){
TextStyle style = TextStyle(fontSize: 20, color:Colors.white);
TextStyle styleTitle = TextStyle(fontSize: 30 , color:Colors.white);
  return Container(
    decoration: BoxDecoration(
      //shape: BoxShape.circle,
        borderRadius: BorderRadius.circular(20),
         color: Color.fromARGB(255, 32, 30, 131),
    
    ),
   
    padding: EdgeInsets.all(15),
    margin: EdgeInsets.all(15),
    width: 400,
    child:Column(children:[
      Text("OLED" , style:styleTitle),
      Image.asset("assets/oled.png", width: 200,),
Text("Si estás buscando la manera de covertir una imagen en formato PNG en un mapa de bits para poder mostrarla en una pantalla OLED con Arduino, consulta el siguiente ejemplo" , 
textAlign: TextAlign.center,
style: style,

),

SizedBox(height:20),
ElevatedButton(
    style: ButtonStyle(  backgroundColor: MaterialStateProperty.all(Colors.white)),
  onPressed: (){

  //launchUrl(Uri(scheme: "https://github.com/davidsur12/EjemploOled.git"));
  _launchUrl("github.com/davidsur12/EjemploOled.git");
}, child: 
Container(
 //Color.fromARGB(95, 242, 150, 92)
 //Color.fromARGB(255, 32, 30, 131)
 height:50,
  padding: EdgeInsets.only(left: 20, right: 20, top:10, bottom: 10),
  child:Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset("assets/githubBlack.png", width: 28,),
      SizedBox(width:10),
      Text("Codigo", style: TextStyle(color:Color.fromARGB(255, 111, 110, 172,),fontWeight: FontWeight.bold, ))],)
  )
  )

  ]
  )
  );
}

Future<void> _launchUrl(String url) async {
  var httpsUri = Uri(
    scheme: 'https',
    //host: 'dart.dev',
    path: url,
    fragment: 'numbers');

  if (!await launchUrl(httpsUri)) {
    throw Exception('Could not launch $url');
  }
}
Widget Loadimage(){
if (file != null) {
      img.file = file!;


      return SizedBox(
              //cargo la imagen
              child: cargarImage(context),
              width: 500,
              height: 200,
            );
    }
   

      return SizedBox(height: 50,);
  
 

}

  Widget cargarImage(BuildContext context) {
    if (file != null) {
      Img img = Img();
      img.file = file!;

      imgLoag = true;
      return Image.network(file!.path);
    } else {
      imgLoag = false;
      return Text("");
    }
  }

  Widget cargarImage2(BuildContext context) {
    if (file != null) {
      img.file = file!;


      return Visibility(child: btnOpciones(), visible: true);

    

    } else {
      return SizedBox(height: 5,);//Visibility(child: btnOpciones(), visible: false);
    }
  }

  Widget btnOpciones() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        
        ElevatedButton(
           style: ButtonStyle(  backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 32, 30, 131)
           )
           ),
            onPressed: () {
              pushScren(context, 1);
            },
            child: Padding(
              padding: EdgeInsets.only(left: 20.0, right: 20.0, top:7, bottom: 7),
              child: Text("TFT", style: TextStyle(fontSize: 22),),
            )),
        SizedBox(
          width: 20,
        ),
        ElevatedButton(
           style: ButtonStyle(  backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 32, 30, 131))),
            onPressed: () {
              pushScren(context, 0);
            },
            child: Padding(
              padding: EdgeInsets.only(left: 20.0, right: 20.0, top:7, bottom: 7),
              child: Text("OLED", style: TextStyle(fontSize: 22)),
            ))
      ],
    );
  }

  Widget btnImage() {
    return ElevatedButton(
      style: ButtonStyle(
         backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 32, 30, 131)),
        ),
        onPressed: () async {
          ImagePicker picker = ImagePicker();
          XFile? image = await picker.pickImage(source: ImageSource.gallery);
      
         // print("presione el boton");
          if (image != null) {
          //  print("deberia obtener la image");
            setState(() {
              print(image.path.toString());
              file = File(image.path);
              img.image = image;
            });
          }
        },
        child: Padding(padding: EdgeInsets.only(top: 20.0 , bottom: 20.0 , left: 50.0 , right: 50.0),child:Text("Seleccionar  Imagen" , style: TextStyle(fontSize: 20.0, backgroundColor: Color.fromARGB(255, 32, 30, 131)),)));
  }

  pushScren(BuildContext context, int id) {
    if (id == 0) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => oled()));
    }
    if (id == 1) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => tft()));
    }
  }

  Stream confirmarImg(bool imgLoad, BuildContext context) async* {
    if (imgLoag == true) {
     // yield* pushScren(context, 0);
      imgLoag = false;
    }
    ;
  }

}

 
