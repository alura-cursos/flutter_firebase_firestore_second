import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_firebase_firestore_second/firestore_produtos/helpers/enum_order.dart';

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

  Future<List<Produto>> lerProdutos({
    required String listinId,
    required OrdemProduto ordem,
    required bool isDecrescente,
    QuerySnapshot<Map<String, dynamic>>? snapshot,
  }) async {
    List<Produto> temp = [];

    snapshot ??= await firestore
        .collection("listins")
        .doc(listinId)
        .collection("produtos")
        // .where("isComprado", isEqualTo: isComprado)
        .orderBy(ordem.name, descending: isDecrescente)
        .get();

    for (var doc in snapshot.docs) {
      Produto produto = Produto.fromMap(doc.data());
      temp.add(produto);
    }

    return temp;
  }
}
