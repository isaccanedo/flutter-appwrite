import 'package:appwrite/appwrite.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_appwrite_demo/core/res/app_constants.dart';
import 'package:flutter_appwrite_demo/features/transactions/data/model/transaction.dart';

class TransactionState extends ChangeNotifier {
  final String collectionId = "612f79ae4cf5b";
  Client client = Client();
  Database db;
  String _error;
  List<Transaction> _transactions;
  String get error => _error;
  List<Transaction> get transactions => _transactions;

  TransactionState() {
    _init();
  }

  _init() {
    client
        .setEndpoint(AppConstants.endpoint)
        .setProject(AppConstants.projectId);
    db = Database(client);
    _transactions = [];
    _getTransactions();
  }


  Future<void> _getTransactions() async {
    try {
      Response res = await db.listDocuments(
        collectionId: collectionId,
        orderField: 'transaction_date',
        //orderType: OrderType.desc,
      );
      if (res.statusCode == 200) {
        _transactions = List<Transaction>.from(
            res.data["documents"].map((tr) => Transaction.fromJson(tr)));
        notifyListeners();
      }
    } catch (e) {
      print(e.message);
    }
  }

  Future addTransaction(Transaction transaction) async {
    try {
      Response res = await db.createDocument(
          collectionId: collectionId,
          data: transaction.toJson(),
          read: ["user:${transaction.userId}"],
          write: ["user:${transaction.userId}"]);
      transactions.add(Transaction.fromJson(res.data));
      notifyListeners();
      print(res.data);
    } catch (e) {
      print(e.message);
    }
  }

  //
  // Future deleteTransaction(Transaction transaction) async {
  //   try {
  //     await db.deleteDocument(
  //       collectionId: collectionId,
  //       documentId: transaction.id,
  //     );
  //     _transactions = List<Transaction>.from(
  //         _transactions.where((tran) => tran.id != transaction.id));
  //     notifyListeners();
  //   } catch (e) {
  //     print(e.message);
  //   }
  // }
}
