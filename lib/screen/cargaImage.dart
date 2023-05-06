import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:scaled_list/scaled_list.dart';
import 'package:horizontal_list/horizontal_list.dart';

class cargarImagen extends StatefulWidget {
  const cargarImagen({super.key});

  @override
  State<cargarImagen> createState() => _cargarImagen();
}

class _cargarImagen extends State<cargarImagen> {
  File? file;
  List<Widget> lista = [ ];
  List<XFile>? image;
  HorizontalListView? horizontalListView;
    final List<Color> kMixedColors = [
    Color(0xff71A5D7),
    Color(0xff72CCD4),
    Color(0xffFBAB57),
    Color(0xffF8B993),
    Color(0xff962D17),
    Color(0xffc657fb),
    Color(0xfffb8457),
  ];

  final List<Category> categories = [
    Category(image: "assets/1.png", name: "Beef"),
    Category(image: "assets/2.png", name: "Chicken"),
    Category(image: "assets/3.png", name: "Dessert"),
    Category(image: "assets/4.png", name: "Lamb"),
    Category(image: "assets/5.png", name: "Pasta"),
  ];




  @override
  Widget build(BuildContext context) {
    return Center( child:SingleChildScrollView(child:
     (Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            btnImage(),
           imagenes_cargadas2(),
           //imagenes(), lista horizontal para android
           listHorizontal(),
        Container(
          width: 200,
          color: Colors.grey,
          child: Card(color: Colors.grey, child: Column(children: [Image.asset("1.png" , width: 200,),
          SizedBox(height: 10,),
           Text("Comvertir A" ,style: TextStyle()) ,
          Container(child: Text("PNG" , textAlign: TextAlign.center,), color: Colors.brown , width: double.maxFinite,)
          ],),),),
          ]
        )
        )
 
    )
    );
    
   
  }
 imagenes_cargadas2() {
    if ( image==null) {
   
     return Text("NO SELECIONASTE NINGUNA IMAGEN");
    } else {
      for (int i = 0; i < image!.length ; i++) {
        String path = image![i].path;
        //lista.add(Text(path));
        lista.add(Image.network(path , width: 200,));
        print("archivos cargados" + lista[i].toString() );
      }

      return Text("");
/*
     return Column(
        children: lista,
      );*/
      
    }
  }
  Stream<Widget> imagenes_cargadas()async* {
    if (image!.length == 0) {
      //lista.add(Text("fds"));
     yield Text("NO SELECIONASTE NINGUNA IMAGEN");
    } else {
      for (int i = 0; i < image!.length - 1; i++) {
        String path = image![i].path;
        lista.add(Text(i.toString()));
        print(lista[i]);
      }

      yield Row(
        children: lista,
      );
    }
  }

  Widget btnImage() {
    return ElevatedButton(
        onPressed: () async {
          ImagePicker picker = ImagePicker();
          // XFile? image = await picker.pickImage(source: ImageSource.gallery);
          image = await picker.pickMultiImage();
          if (image!.isNotEmpty) {
            //   image[0].
            // print(" total archivos" + image.length.toString());
            //imagenes_cargadas();
            print(image!.length.toString());
            image=image;
          } else {
            print("esta vacio");
          }
          // print("presione el boton");
          if (image != null) {
            //  print("deberia obtener la image");
            setState(() {
              // print(image.path.toString());
              //    File  file = File(image.path);
              // img.image = image;
            });
          }
        },
        child: Text("Cargar imagen"));
  }


Widget listHorizontal(){
if(lista == null || lista.length == 0){
  return Text("vacio");
}


  horizontalListView= HorizontalListView(
   // width: double.maxFinite, //Width of widget
    width: 1000, 
    height: 200, //Height of widget
    list: lista,//[Image.asset("1.png") , Text(" "), Image.asset("2.png") , Image.asset("3.png") , Image.asset("4.png") , Image.asset("5.png")], //List of widget
    iconNext: Icon(Icons.arrow_forward_ios), // Icon for button next
    iconPrevious: Icon(Icons.arrow_back_ios), // Icon for button previous
    curveAnimation: Curves.decelerate, //Curve for animation
    durationAnimation: Duration(milliseconds: 300), //Duration of animation
    enableManualScroll: true, //Enable manual scroll
    onNextPressed: () { //On button next pressed
      print('On next pressed');
      print("size de lista " + lista.length.toString());
    },
    onPreviousPressed: () { //On button next pressed
      print('On previous pressed');
    },
);
return horizontalListView!;
}
  Widget imagenes(){

    
 return Center(
            child: ScaledList(
                itemCount: categories.length,
                itemColor: (index) {
                  return kMixedColors[index % kMixedColors.length];
                },
                itemBuilder: (index, selectedIndex) {
                  final category = categories[index];
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: selectedIndex == index ? 100 : 80,
                        child: Image.asset(category.image),
                      ),
                      SizedBox(height: 5),
                      Text(
                        category.name,
                        style: TextStyle(
            color: Colors.white,
            fontSize: selectedIndex == index ? 25 : 20),
                      )
                    ],
                  );
                },
              ),
          
        );
  }

}
class Category {
  final String image;
  final String name;

  Category({required this.image, required this.name});
}
