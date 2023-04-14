

class Coversor {
  
static String binarioToHexadecimal(String binario){ 

 
int decimal = int.parse(binario, radix: 2); // convierte el número binario a decimal
String hexadecimal = decimal.toRadixString(16); // convierte el decimal a hexadecimal
return hexadecimal;
}




}