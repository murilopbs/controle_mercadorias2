import 'package:controle_mercadorias/Bone.dart';
import 'package:controle_mercadorias/Vendas.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Casarao extends StatefulWidget {

  @override
  _CasaraoState createState() => _CasaraoState();
}

class _CasaraoState extends State<Casarao> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Griffe Life: The App"),

        ),
        body: ListView(
          children: [
            RaisedButton(
              child: Text("Bonés"),
              onPressed: (){
                Navigator.push(context,
                MaterialPageRoute(
                    builder: (BuildContext context) => Bones()));
              },
            ),
            RaisedButton(
              child: Text("Histórico"),
              onPressed: (){
                Navigator.push(context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => Vendas()));
              },
            ),
          ],
        )
    );
  }


}

/*
Text(
                      snapshot.data.documents.elementAt(index)['Cor'],
                      style: TextStyle(fontSize: 30.0),
                    ),
 */