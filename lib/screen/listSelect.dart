import 'package:flutter/material.dart';

List<String> list = <String>['PNG', 'JPG', 'WEBP'  ];

class selectLista extends StatefulWidget {
  int index;
  int get getindex {
    return index;
  }

  selectLista(this.index);
  //const selectLista({super.key});

  @override
  State<selectLista> createState() => selectListaState();
}

class selectListaState extends State<selectLista> {
  String formato = list.first;
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: formato,
      isExpanded: true,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          value = value!;
          formato = value!;
          widget.index=list.indexOf(formato);
          print("index  " + widget.index.toString());
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
