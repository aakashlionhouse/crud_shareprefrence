import 'dart:ffi';

import 'package:flutter/material.dart';

import 'contact.dart';

class Crud extends StatefulWidget {
  const Crud({super.key});

  @override
  State<Crud> createState() => _CrudState();
}

class _CrudState extends State<Crud> {
  TextEditingController nameController=TextEditingController();
  TextEditingController contactController=TextEditingController();
  List<Contact> contacts=List.empty(growable: true);

  int selectedIndex = -1;

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Add",
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "  Data",
              style: TextStyle(
                  color: Colors.orange,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    body: Container(
    padding: EdgeInsets.all(16.0),
    child: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
    TextField(
      controller: nameController,
    keyboardType: TextInputType.text,

    decoration: InputDecoration(
    hintText: 'Enter Name...',
    focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(11),
    borderSide: BorderSide(color: Colors.orange, width: 2),
    ),
    enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(11),
    borderSide: BorderSide(color: Colors.blueAccent, width: 2),
    ),
    ),

    ),
      SizedBox(
        height: 20,
      ),
      TextField(
        controller: contactController,
        keyboardType: TextInputType.number,

        decoration: InputDecoration(
          hintText: 'Enter Number...',

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(11),
            borderSide: BorderSide(color: Colors.orange, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(11),
            borderSide: BorderSide(color: Colors.blueAccent, width: 2),
          ),
        ),

      ),
      SizedBox(
        height: 10,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(onPressed: (){
            String name=nameController.text.trim();
            String contact=contactController.text.trim();
            if(name.isNotEmpty && contact.isNotEmpty){
             setState(() {
               nameController.text='';
               contactController.text='';
               contacts.add(Contact(name: name, contact: contact));
             });
            }

          }, child: Text("ADD")),
          ElevatedButton(onPressed: (){
    String name=nameController.text.trim();
    String contact=contactController.text.trim();
    if(name.isNotEmpty && contact.isNotEmpty) {
      setState(() {
        nameController.text = '';
        contactController.text = '';
        contacts[selectedIndex].name=name;
        contacts[selectedIndex].contact=contact;
        selectedIndex=-1;
      });
    }
          }, child: Text("Update")),
        ],
      ),
      Expanded(
        child: ListView.builder(itemCount: contacts.length,
          itemBuilder: (context,index)=> getRow(index),),
      )
      ]
    )
    )
    );
  }

 Widget getRow(int index) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          child: Text(contacts[index].name[0]),
        ),
        title:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(contacts[index].name),
            Text(contacts[index].contact),
          ],
        ),
        trailing: SizedBox(
          width: 70,
          child: Row(
            children: [
              InkWell(
                onTap: (){
              nameController.text=contacts[index].name;
               contactController.text=contacts[index].contact;
               setState(() {
                 selectedIndex = index;
               });
                },
                  child: Icon(Icons.edit)),
              SizedBox(
                width: 8,
              ),
              InkWell(
                onTap: ((){
                 setState(() {
                   contacts.removeAt(index);
                 });
                }),
                  child: Icon(Icons.delete))
            ],
          ),
        ),
      ),
    );
 }
}
