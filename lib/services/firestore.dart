import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class FireStoreService {
  File? selectedImage;
  // Collection reference for 'notes' collection
  final CollectionReference supplier = FirebaseFirestore.instance.collection('suppliers');
  final CollectionReference videos = FirebaseFirestore.instance.collection('videos');
  final CollectionReference cart = FirebaseFirestore.instance.collection('cart');
  final CollectionReference user = FirebaseFirestore.instance.collection('login_users');
  final CollectionReference community = FirebaseFirestore.instance.collection('community');
  final FirebaseStorage storage = FirebaseStorage.instance;

  Stream<QuerySnapshot> getSupplierStream() {
    // Stream of snapshots from 'notes' collection ordered by timestamp in descending order
    final supplierStream = supplier.orderBy('timestamp', descending: true).snapshots();
    return supplierStream;
  }
  Stream<QuerySnapshot> getVideosStream() {
    // Stream of snapshots from 'notes' collection ordered by timestamp in descending order
    final videosStream = videos.orderBy('timeStamp', descending: true).snapshots();
    return videosStream;
  }
  Stream<QuerySnapshot> getCompanyStream() {
    // Stream of snapshots from 'notes' collection ordered by timestamp in descending order
    final supplierStream = supplier.orderBy('timestamp', descending: true).snapshots();
    return supplierStream;
  }
  // Method to retrieve notes from Firestore as a stream
  Stream<QuerySnapshot> getCartsStream() {
    // Stream of snapshots from 'notes' collection ordered by timestamp in descending order
    final notesStream = cart.orderBy('timetamp', descending: true).snapshots();
    return notesStream;
  }

  Future<void> updateAdminNote(String docID, String newName, String newAddress, String newCountry, String newContact) {
    // Update the document with specified docID in 'notes' collection with new note content, subtext, and updated timestamp
    double contacts = double.parse(newContact);
    return supplier.doc(docID).update({
      'supplierName': newName,
      'supplierAddress': newAddress, // Update subtext field
      'supplierCountry':newCountry,
      'contactNo':contacts,
      'timestamp': Timestamp.now(),
    });
  }
  Future<void> updateUser(String docID, String newName, String newEmail) {
    // Update the document with specified docID in 'notes' collection with new note content, subtext, and updated timestamp
    return user.doc(docID).update({
      'name': newName,
      'email': newEmail,
    });
  }
  Future<void> updateUserStatus(String docID, String newStatus) {
    // Update the document with specified docID in 'notes' collection with new note content, subtext, and updated timestamp
    return user.doc(docID).update({
      'approval': newStatus,
    });
  }

  Future<void> updateAdminVideo(String docID, String newName) {

    return videos.doc(docID).update({
      'name': newName,
      'timestamp': Timestamp.now(),
    });
  }
  Future<void> updateCompany(
      String docID,
      String newName,
      String newAddress,
      String newContact,
      String newCountry,
      String newID) {
    double contacts = double.parse(newContact);
    return supplier.doc(docID).update({
      'contactNo':contacts,
      'supplierAddress': newAddress,
      'supplierCountry': newCountry,
      'supplierId': newID,
      'supplierName': newName,
      'timestamp': Timestamp.now(),
    });
  }
  // Method to update an existing note in Firestore
  Future<void> updateStatus(String docID, String newStatus) {
    // Update the document with specified docID in 'notes' collection with new note content, subtext, and updated timestamp
    return cart.doc(docID).update({
      'status': newStatus,
      'timestamp': Timestamp.now(),
    });
  }

  Future<void> deleteNote(String docID) {
    // Delete the document with specified docID from 'notes' collection
    return community.doc(docID).delete();
  }

  // Method to delete a note from Firestore
  Future<void> deleteCart(String docID) {
    // Delete the document with specified docID from 'notes' collection
    return cart.doc(docID).delete();
  }
  Future<void> deleteCompany(String docID) {
    // Delete the document with specified docID from 'notes' collection
    return supplier.doc(docID).delete();
  }
  Future<void> deleteUser(String docID) {
    // Delete the document with specified docID from 'notes' collection
    return user.doc(docID).delete();
  }

  Future<void> deleteVideo(String docID) {
    // Delete the document with specified docID from 'notes' collection
    return videos.doc(docID).delete();
  }

  // Method to toggle the favorite status of a note
  Future<void> toggleFavorite(String docID, bool isFavorite) {
    // Update the document with specified docID in 'notes' collection with new favorite status
    return cart.doc(docID).update({
      'favorite': isFavorite,
    });
  }

  // Method to retrieve favorite notes from Firestore as a stream
  Stream<QuerySnapshot> getFavoriteNotesStream() {
    // Stream of snapshots from 'notes' collection where 'favorite' field is true
    final favoriteNotesStream = cart.where('favorite', isEqualTo: true).snapshots();
    return favoriteNotesStream;
  }

  addCart(String name, String image, double prices) async {
    return cart.add({
      'name': name,
      'price':prices,
      'timestamp': Timestamp.now(),
      'imageUrl':image,
      'status':'Pending'
    });
  }
  addSupplier(String suppName, String suppAddress, String country, String contact, int length, File? selectedImage, String filetype) async {

    final imagePath = 'supplier/item${DateTime.now().millisecondsSinceEpoch}';
    final Reference storageReference = storage.ref().child(imagePath);
    double contacts = double.parse(contact);



    // Specify content type as 'image/jpeg'
    final metadata = SettableMetadata(contentType: filetype);

    await storageReference.putFile(selectedImage!, metadata);
    final String imageUrl = await storageReference.getDownloadURL();

    return supplier.add({
      'supplierId':'LA${DateTime.now().millisecondsSinceEpoch}',
      'supplierIndex':length,
      'supplierName': suppName,
      'supplierCountry':country,
      'contactNo':contacts,
      'timestamp': Timestamp.now(),
      'supplierAddress': suppAddress, // Initialize subtext field with an empty string
      'supplierimageUrl':imageUrl
    });
  }
  Future<QuerySnapshot<Object?>> getUsers() async {
    // Retrieve the data from the 'login_users' collection
    QuerySnapshot<Object?> querySnapshot = await user.get();
    return querySnapshot;
  }
}
