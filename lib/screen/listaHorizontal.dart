import 'package:flutter/material.dart';
import 'package:horizontal_list/horizontal_list.dart';
 class listaHorizontal extends StatefulWidget {

   final List<Widget> lista;
   const listaHorizontal(this.lista);
   //const listaHorizontal({super.key});
 
   @override
   State<listaHorizontal> createState() => _listaHorizontalState();
 }
 
 class _listaHorizontalState extends State<listaHorizontal> {
   @override
   Widget build(BuildContext context) {
     return listHorizontal();
   }

   
  Widget listHorizontal() {
    if (widget.lista == null || widget.lista.length == 0) {
      return Text(" ");
    }

   return  HorizontalListView(
      // width: double.maxFinite, //Width of widget
      width: 1000,
      height: 370, //Height of widget
      list:
          widget.lista, //[Image.asset("1.png") , Text(" "), Image.asset("2.png") , Image.asset("3.png") , Image.asset("4.png") , Image.asset("5.png")], //List of widget
      iconNext: Icon(Icons.arrow_forward_ios), // Icon for button next
      iconPrevious: Icon(Icons.arrow_back_ios), // Icon for button previous
      curveAnimation: Curves.decelerate, //Curve for animation
      durationAnimation: Duration(milliseconds: 300), //Duration of animation
      enableManualScroll: true, //Enable manual scroll
      onNextPressed: () {
        //On button next pressed
        print('On next pressed');
        print("size de lista " + widget.lista.length.toString());
      },
      onPreviousPressed: () {
        //On button next pressed
        print('On previous pressed');
      },
    );
 
  }
 }