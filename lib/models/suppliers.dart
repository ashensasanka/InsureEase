import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
class Suppliers {
  final int supplierIndex;
  final String supplierName;
  final String supplierId;

  Suppliers({
    required this.supplierIndex,
    required this.supplierName,
    required this.supplierId
  });

  static Future<List<Suppliers>> getSuppliersFromFirestore() async {
    List<Suppliers> suppliersList = [];

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('suppliers')
          .get();

      querySnapshot.docs.forEach((doc) {
        suppliersList.add(Suppliers(
          supplierIndex: doc['supplierIndex'],
          supplierName: doc['supplierName'],//ok
          supplierId: doc['supplierId']
        ));
      });

      print('Suppliers retrieved successfully: $suppliersList'); // Add a debug print statement
      return suppliersList;
    } catch (error) {
      print('Error retrieving claims: $error'); // Log the error
      return []; // Return an empty list if there's an error
    }
  }
}


