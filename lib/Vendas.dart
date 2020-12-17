import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
class Vendas extends StatefulWidget {
  @override
  _VendasState createState() => _VendasState();
}

class _VendasState extends State<Vendas> {
  double valor;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Griffe Life: The App"),
      ),
      body: PageView(
        children: [
          Vendas_Ala(),
        ],
      ),
    );
  }
  Widget Vendas_Ala(){
    return Container(
      child: StreamBuilder(
          stream: Firestore.instance.collection('vendas').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData)
              return Center(
                child: CircularProgressIndicator(),
              );
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (BuildContext context, int index){
                    return Column(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(padding: EdgeInsets.all(10),
                              child: Container(
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white70,
                                        border: Border.all(
                                          width: 3,
                                        ),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(15),
                                        ),
                                        boxShadow: [
                                          new BoxShadow(
                                            color: Colors.black,
                                            offset: new Offset(10, 10),
                                            blurRadius: 5,
                                          ),
                                        ],
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.only(top: 8, bottom: 8, left: 8),
                                        child: Column(
                                          children: [
                                            Padding(padding: EdgeInsets.only(right: 8),
                                              child: Text("${snapshot.data.documents.elementAt(index)['data']}", style: TextStyle(fontSize: 20),),),
                                             Row(
                                      children: [
                                        Text("Vendedor: ${snapshot.data.documents.elementAt(index)['Vendedor']}"),
                                        Padding(padding: EdgeInsets.all(5)),
                                        Text("Produto: ${snapshot.data.documents.elementAt(index)['Produto']}"),
                                        Padding(padding: EdgeInsets.all(5)),
                                        Text("Preço final: ${snapshot.data.documents.elementAt(index)['Valor'] - snapshot.data.documents.elementAt(index)['Desconto']}"),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("Quantidade: ${snapshot.data.documents.elementAt(index)['Quantidade']}"),

                                    Row(
                                      children: [
                                        Text("Preço: ${snapshot.data.documents.elementAt(index)['Valor']}"),
                                        Padding(padding: EdgeInsets.all(5)),
                                        Text("Desconto: ${snapshot.data.documents.elementAt(index)['Desconto']}"),
                                      ],
                                    ),
                          ]),
                                          ],
                                        ),
                                      ),
                                    ),

                                  ],),
                              ))]);
                  }
              );
            }
          }
      ),
    );
  }
}
