import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'formulario.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Home());
}

final db = FirebaseFirestore.instance;

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Lembretes"),
          centerTitle: true,
        ),
        bottomNavigationBar: FloatingActionButton(
          onPressed: () {
            _mostrarFormulario(context);
          },
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("NOVO LEMBRETE"),
              Icon(Icons.add),
            ],
          ),
        ),
        body: StreamBuilder(
            stream: db.collection('lembretes').snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, int index) {
                    DocumentSnapshot documentSnapshot =
                        snapshot.data.docs[index];
                    return ListTile(
                        title: Text(documentSnapshot['lembrete']),
                        onTap: () {},
                        trailing: IconButton(
                            icon: const Icon(
                              Icons.delete_outline,
                            ),
                            onPressed: () {
                              db
                                  .collection('lembretes')
                                  .doc(documentSnapshot.id)
                                  .delete();
                            }));
                  });
            }));
  }
}

void _mostrarFormulario(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) =>
          FormularioDialog(db: FirebaseFirestore.instance));
}
