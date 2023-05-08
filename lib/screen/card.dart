import 'package:flutter/material.dart';
import 'package:imagen_cambio_formato/screen/listSelect.dart';
import 'package:image_downloader_web/image_downloader_web.dart';
import 'package:image/image.dart' as img;
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class CardImage extends StatefulWidget {
final String path;

   // const CardImage({super.key});
      //const CardImage({ Key? key, this.path }): super(key: key);
   CardImage(this.path);
 XFile? image;
 // CardImage(this.path);


  @override
  State <CardImage> createState() =>  CardImageState();
}

class  CardImageState extends State <CardImage> {
    TextStyle style=TextStyle(color:Colors.white , fontSize: 20);
     bool downloading = false;
     var selectlista=selectLista(0);
  @override
  Widget build(BuildContext context) {
   
    return Container(
      width: 200,
      color:Color.fromARGB(255, 73, 91, 255),
      child: Card(
        color: Color.fromARGB(255, 73, 91, 255),
        child: Column(
          children: [
            Image.network(
              widget.path,
              width: 200,
              height: 200,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                color: Color.fromARGB(255, 73, 91, 255),
                width: double.maxFinite,
                child: Column(
                  children: [
                    Text("Convertir A " , style:style),
                    SizedBox(
              height: 10,
            ),
                   Container(
                    width: 200,
                    child:  ElevatedButton(onPressed: () {}, child: selectlista,
                    )
                    ),
                        SizedBox(
              height: 10,
            ),
                    Container(
                    width: 200,
                    child:  ElevatedButton(onPressed: () {cambiarFormato();}, child:  Text("Descargar" , style: style,)))
                  ],
                ))
          ],
        ),
      ),
    );
  

  }

  Future<void> _downloadImage() async {
    setState(() {
      downloading = true;
    });
    String _url = widget.path;
    await WebImageDownloader.downloadImageFromWeb(
      _url,
      name: 'image01',
      imageType:idFormat()
    );
    setState(() {
      downloading = false;
    });
  }

 Future<void> cambiarFormato()async{
//await img.decodePngFile(widget.path);
//ByteData pngBytes = await rootBundle.load(widget.path);
var loadimage=widget.image;
 final rawImage = await loadimage!.readAsBytes();
//Uint8List pngList = Uint8List.view(pngBytes.buffer);
img.Image pngImage = img.decodeImage(rawImage)!;

// Convertir la imagen de PNG a JPEG
img.Image jpegImage = img.copyResize(pngImage, width: pngImage.width);
Uint8List jpegList = img.encodeJpg(pngImage );

// Guardar la imagen en formato JPEG en un archivo
// File('my_image.jpg').writeAsBytesSync(jpegList);
 await WebImageDownloader.downloadImageFromUInt8List(uInt8List: jpegList , name: "imagen" , 
 imageType: idFormat() );
  }

ImageType idFormat(){
  ImageType? result;
  print("se descargara en formato " + selectlista.getindex.toString());
switch(selectlista.getindex){
case 0:
result=ImageType.png;
break;
case 1:
result=ImageType.jpeg;
break;
case 2:
result=ImageType.webp;
break;
}
return result!;
}
}

