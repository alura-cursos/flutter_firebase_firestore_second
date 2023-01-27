import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import '../model/produto.dart';

class ProdutoService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  adicionarProduto({required String listinId, required Produto produto}) {
    firestore
        .collection("listins")
        .doc(listinId)
        .collection("produtos")
        .doc(produto.id)
        .set(produto.toMap());
  }
}
