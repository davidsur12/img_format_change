import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:scaled_list/scaled_list.dart';
import 'package:horizontal_list/horizontal_list.dart';
import 'package:imagen_cambio_formato/screen/listSelect.dart';
import 'package:imagen_cambio_formato/screen/card.dart';
import 'package:imagen_cambio_formato/screen/listaHorizontal.dart';

List<String> list = <String>['PNG', 'JPG'];

class cargarImagen extends StatefulWidget {
  const cargarImagen({super.key});

  @override
  State<cargarImagen> createState() => _cargarImagen();
}

class _cargarImagen extends State<cargarImagen> {
  File? file;
  List<Widget> lista = [];
  List<XFile>? image;

  String formato = list.first;
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
    return Center(
        child: SingleChildScrollView(
            child:
                (Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      btnImage(),
      imagenes_cargadas2(),
      //imagenes(), lista horizontal para android
      // listHorizontal(),
      listaHorizontal(lista),
      //https://pub.dev/packages/image_downloader_web
      //https://pub.dev/packages/image/example

      
    ]))));
  }

  imagenes_cargadas2() {
    if (image == null) {
      return Text("NO SELECIONASTE NINGUNA IMAGEN");
    } else {
      for (int i = 0; i < image!.length; i++) {
        String path = image![i].path;
        CardImage car=CardImage(path);
        car.image=image![i];
        lista.add(car);
        print("archivos cargados" + lista[i].toString());
      }

      return Text("");
/*
     return Column(
        children: lista,
      );*/
    }
  }

  Stream<Widget> imagenes_cargadas() async* {
    if (image!.length == 0) {
      //lista.add(Text("fds"));
      yield Text("NO SELECIONASTE NINGUNA IMAGEN");
    } else {
      for (int i = 0; i < image!.length - 1; i++) {
        String path = image![i].path;
        //lista.add(Text(i.toString()));
        //lista.add(card(path));
        lista.add(CardImage(path));
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
            image = image;
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

  Widget imagenes() {
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
