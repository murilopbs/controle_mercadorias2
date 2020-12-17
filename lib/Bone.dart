import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
class Bones extends StatefulWidget {
  @override
  _BonesState createState() => _BonesState();
}

class _BonesState extends State<Bones> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Griffe Life: The App"),
        ),
        body: PageView(
          children: [
            VerDados(),
            AdicionaBone(),
          ],
        )
    );
  }
  Widget VerDados() {
    final controla_preco = TextEditingController();
    final controla_preco_pago = TextEditingController();
    final controla_quantidade = TextEditingController();
    final controla_vendedor = TextEditingController();
    final controla_desconto = TextEditingController();
    bool dataFoiEscolhida = false;
    DateTime data_venda;
    return StreamBuilder(
        stream: Firestore.instance.collection('bone').snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData)
                return Center(
                  child: CircularProgressIndicator(),
                );
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
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
                                      child: Text("${snapshot.data.documents[index].documentID}", style: TextStyle(fontSize: 20),),),
                                    Row(
                                      children: [
                                        Text("Preço: ${snapshot.data.documents.elementAt(index)['Preço']}"),
                                        Padding(padding: EdgeInsets.all(5)),
                                        Text("Preço Pago: ${snapshot.data.documents.elementAt(index)['Preço pago']}"),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("Quantidade: ${snapshot.data.documents.elementAt(index)['Quantidade']}"),
                                        Padding(padding: EdgeInsets.all(5)),
                                        Text("Valor ganho: ${snapshot.data.documents.elementAt(index)['Preço'] - snapshot.data.documents.elementAt(index)['Preço pago']}"),
                                        Row(
                                          children: [
                                            Padding(padding: EdgeInsets.only(left: 15),
                                              child: IconButton(icon: Icon(Icons.edit), onPressed: (){
                                                showDialog(context: context,
                                                  builder: (context) =>AlertDialog(
                                                    title: Text("Editar ${snapshot.data.documents[index].documentID}"),
                                                    content: Column(
                                                      children: [
                                                        Text("Tem que preencher tudo pq o pai não teve habilidade suficiente pra deixar filé"),
                                                        TextField(
                                                          controller: controla_preco,
                                                          keyboardType: TextInputType.number,
                                                          decoration: InputDecoration(
                                                            labelText: "Preço",
                                                            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)),),
                                                          ),
                                                        ),
                                                        TextField(
                                                          controller: controla_preco_pago,
                                                          keyboardType: TextInputType.number,
                                                          decoration: InputDecoration(
                                                            labelText: "Preço pago",
                                                            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)),),
                                                          ),
                                                        ),
                                                        TextField(
                                                          controller: controla_quantidade,
                                                          keyboardType: TextInputType.number,
                                                          decoration: InputDecoration(
                                                            labelText: "Quantidade",
                                                            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)),),
                                                          ),
                                                        ),
                                                      ],
                                                    ),

                                                    actions: [
                                                      RaisedButton(child: Text("Cancelar"),
                                                        onPressed: (){
                                                          Navigator.pop(context);
                                                        },
                                                      ),
                                                      RaisedButton(child: Text("Atualizar"),
                                                        onPressed: () async{
                                                          await Firestore.instance.collection('bone').document('${snapshot.data.documents[index].documentID}').updateData({
                                                            'Preço': int.parse(controla_preco.text),
                                                            'Preço pago': int.parse(controla_preco_pago.text),
                                                            'Quantidade': int.parse(controla_quantidade.text),
                                                          });
                                                          Navigator.pop(context);
                                                        },)
                                                    ],
                                                  ),
                                                );
                                              }),),
                                            IconButton(icon: Icon(Icons.assignment_turned_in, color: Colors.black,),
                                                onPressed: (){
                                                  showDialog(context: context,
                                                    builder: (context) =>AlertDialog(
                                                      title: Text("Vendeu o ${snapshot.data.documents[index].documentID}"),
                                                      content: Column(
                                                        children: [
                                                          TextField(
                                                            controller: controla_vendedor,
                                                            decoration: InputDecoration(
                                                              labelText: "Vendedor",
                                                              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)),),
                                                            ),
                                                          ),
                                                          TextField(
                                                            controller: controla_quantidade,
                                                            keyboardType: TextInputType.number,
                                                            decoration: InputDecoration(
                                                              labelText: "Quantidade",
                                                              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)),),
                                                            ),
                                                          ),
                                                          TextField(
                                                            controller: controla_desconto,
                                                            keyboardType: TextInputType.number,
                                                            decoration: InputDecoration(
                                                              labelText: "Desconto",
                                                              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)),),
                                                            ),
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text("Escolha a data da venda"),
                                                              IconButton(icon: Icon(Icons.date_range), onPressed: (){
                                                                showDatePicker(context: context,
                                                                    initialDate: DateTime.now(),
                                                                    firstDate: DateTime(2020),
                                                                    lastDate: DateTime(2099)).then((date) {
                                                                      data_venda = date;


                                                                });
                                                                Fluttertoast.showToast(
                                                                    msg: "${data_venda}",
                                                                    toastLength: Toast.LENGTH_SHORT,
                                                                    gravity: ToastGravity.CENTER,
                                                                    timeInSecForIosWeb: 1,
                                                                    backgroundColor: Colors.red,
                                                                    textColor: Colors.white,
                                                                    fontSize: 16.0
                                                                );
                                                              })
                                                            ],
                                                          ),
                                                        ],
                                                      ),

                                                      actions: [
                                                        RaisedButton(child: Text("Cancelar"),
                                                          onPressed: (){
                                                            Navigator.pop(context);
                                                            print(data_venda);
                                                          },
                                                        ),
                                                        RaisedButton(child: Text("Atualizar"),
                                                          onPressed: () async{
                                                            await Firestore.instance.collection('vendas').document().setData({
                                                              'Desconto': int.parse(controla_desconto.text),
                                                              'Produto': "${snapshot.data.documents[index].documentID}",
                                                              'Quantidade': int.parse(controla_quantidade.text),
                                                              'Vendedor': "${controla_vendedor.text}",
                                                              'Valor': snapshot.data.documents.elementAt(index)['Preço'],
                                                              'data': "${data_venda.day}/${data_venda.month}/${data_venda.year}",
                                                            });
                                                            await Firestore.instance.collection('bone').document('${snapshot.data.documents[index].documentID}').updateData({
                                                              'Quantidade': snapshot.data.documents.elementAt(index)['Quantidade'] - int.parse(controla_quantidade.text),
                                                            });

                                                            Navigator.pop(context);
                                                          },)
                                                      ],
                                                    ),
                                                  );
                                                })
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            /*Text("${snapshot.data.documents[index].documentID}"),
                           Text("Preço: ${snapshot.data.documents.elementAt(index)['Preço']}"),
                           Text("Preço Pago: ${snapshot.data.documents.elementAt(index)['Preço pago']}"),
                           Text("Quantidade: ${snapshot.data.documents.elementAt(index)['Quantidade']}"),*/

                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },

            );
          }
        }
    );
  }

  Widget AdicionaBone(){
    final controla_nome = TextEditingController();
    final controla_preco = TextEditingController();
    final controla_preco_pago = TextEditingController();
    final controla_quantidade = TextEditingController();
    return ListView(
      children: [
        Center(
          child: Padding(padding: EdgeInsets.only(top: 10, bottom: 10),
            child: Text("Adicionar Boné"),),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: TextField(
            controller: controla_nome,
            decoration: InputDecoration(
              labelText: "Nome do Produto",
              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)),),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: TextField(
            controller: controla_preco,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "Preço",
              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)),),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: TextField(
            controller: controla_preco_pago,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "Preço Pago",
              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)),),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: TextField(
            controller: controla_quantidade,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "Quantidade",
              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)),),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: RaisedButton(
            child: Text("Adicionar o produto"),
            onPressed: (){
              Firestore.instance.collection('bone').document('${controla_nome.text}').setData({
                'Preço' : int.parse(controla_preco.text),
                'Preço pago': int.parse(controla_preco_pago.text),
                'Quantidade': int.parse(controla_quantidade.text),
              });
              print("ok");
            },
          ),
        ),
      ],
    );
  }
}
