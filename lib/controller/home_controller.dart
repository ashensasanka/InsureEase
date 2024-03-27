import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../post_details/postdetails.dart';

// Here we defined the class to access the database and handle the data query in documents
class HomeController extends GetxController{

  // defined the variables as FirebaseFirestore store data as key value and FirebaseStorage store data as files
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;
  //Defined the Collections variables of database
  late CollectionReference logdetailsCollection;
  late CollectionReference productCollection;
  late CollectionReference categoryCollection;
  late CollectionReference chatlogCollection;
  late CollectionReference postdetailsCollection;
  late CollectionReference messageCollection;
  late CollectionReference cartCollection;
  late CollectionReference videoAddCollection;
  // Text controllers from Add product page
  TextEditingController achivementNameCtrl = TextEditingController();
  TextEditingController productDescriptionCtrl = TextEditingController();
  TextEditingController productImgCtrl = TextEditingController();
  TextEditingController productPriceCtrl = TextEditingController();
  // Text controllers from Add logs page
  TextEditingController fishNameCtrl = TextEditingController();
  TextEditingController fishQuantityCtrl = TextEditingController();
  TextEditingController fishLocationCtrl = TextEditingController();
  TextEditingController fishingMethodCtrl = TextEditingController();
  TextEditingController fishCostCtrl = TextEditingController();
  TextEditingController sellPriceCtrl = TextEditingController();
  TextEditingController soldQuantityCtrl = TextEditingController();
  // Text controller from FB account create page
  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  // Text controller from Post Caption page
  TextEditingController challengeDescriptionCtrl = TextEditingController();
  TextEditingController challengeTitleCtrl = TextEditingController();
  TextEditingController challengeEmailCtrl = TextEditingController();
  // Text controller from message page
  TextEditingController messageController = TextEditingController();
  // Text controller from seller message page
  TextEditingController sellerMessageController = TextEditingController();
  //Define the type of value
  DateTime birthday = DateTime.now();
  DateTime? logday;
  String? lat,long;
  String category = 'Category';
  String brand = 'Fish Category';
  String from = 'From';
  bool offer = false;
  File? selectedImage;
  File? postImage;
  String gender = 'male';

  //List of Products Add and Show
  // List<Product> products = [];
  // List<Product> productShowInUi = [];
  //List of Products Cart and Show
  // List<Product> cart = [];
  // List<Product> cartShowInUi = [];
  //List of Products categories
  // List<ProductCategory> productCategories = [];
  //List of Loging details and Show
  // List<LogDetails> logdetails = [];
  // List<LogDetails> logShowUi = [];
  //List of Chat details and Show
  // List<ChatDetails> chatdetails = [];
  // List<ChatDetails> makePostUi = [];
  //List of Post create and Show
  List<PostDetails> postdetails = [];
  List<PostDetails> postShowUi = [];
  //List of Message send and Show
  // List<Message> message = [];
  // List<Message> messageUi = [];
  //List of Seller Message send and Show
  // List<SellerMessage> sellermessage = [];
  // List<SellerMessage> sellermessageUi = [];

  // Notify about loging details
  // void handleDateSelection(DateTime selectedDate) {
  //   logday = selectedDate;
  //   update(); // Notify listeners about the change
  // }

  // Initiate the database collections and Fetch the data
  @override
  void onInit() async {
    // TODO: implement onInit

    productCollection = firestore.collection('shop');
    categoryCollection = firestore.collection('category');
    // logdetailsCollection = firestore.collection('logdetails');
    // chatlogCollection = firestore.collection('chatlogdetails');
    postdetailsCollection = firestore.collection('postdetails'); //postShowUi
    // messageCollection = firestore.collection('message');
    cartCollection = firestore.collection('approved_post');
    videoAddCollection = firestore.collection('videos');
    // await fetchCategory();
    // await fetchProducts();
    // await fetchPostDetails();
    await fetchPostsList();
    // await fetchMessage();
    // await fetchLogDetails();
    // await fetchCartDetails();
    // await fetchSellerMessage();
    super.onInit();
  }

  // Add chats into chatlogs
  // addChat(File? selectedImage) async {
  //   try {
  //     if (selectedImage == null) {
  //       Get.snackbar('Error', 'Please select an image', colorText: Colors.red);
  //       return;
  //     }
  //
  //     final imagePath = 'profpic/${DateTime.now().millisecondsSinceEpoch}.jpg';
  //     final Reference storageReference = storage.ref().child(imagePath);
  //
  //     // Specify content type as 'image/jpeg'
  //     final metadata = SettableMetadata(contentType: 'image/jpeg');
  //
  //     await storageReference.putFile(selectedImage, metadata);
  //     final String imageUrl = await storageReference.getDownloadURL();
  //
  //     final DocumentReference doc = chatlogCollection.doc();
  //     final ChatDetails chatdetails = ChatDetails(
  //       id: doc.id,
  //       fullName: '${fNameController.text} ${lNameController.text}',
  //       birthDay: birthday,
  //       gender: gender,
  //       image: imageUrl, // Add this field to your ChatDetails model
  //     );
  //
  //     final Map<String, dynamic> chatdetailsJson = chatdetails.toJson();
  //     await doc.set(chatdetailsJson);
  //
  //     Get.snackbar('Success', 'Log added successfully', colorText: Colors.green);
  //     setValuesDefault();
  //   } catch (e) {
  //     Get.snackbar('Error', e.toString(), colorText: Colors.red);
  //   }
  // }

  // Add Post into postdetails collection
  // DateTime now = DateTime.now();
  addPost(File? selectedImage, String filetype) async {

    try {
      if (selectedImage == null) {
        Get.snackbar('Error', 'Please select an image', colorText: Colors.red);
        return;
      }

      final imagePath = 'post/ashenfdbd${DateTime.now().millisecondsSinceEpoch}';
      final Reference storageReference = storage.ref().child(imagePath);

      // Specify content type as 'image/jpeg'
      final metadata = SettableMetadata(contentType: filetype);

      await storageReference.putFile(selectedImage, metadata);
      final String imageUrl = await storageReference.getDownloadURL();

      final DocumentReference doc = postdetailsCollection.doc();
      final PostDetails postdetails = PostDetails(
        id: doc.id,
        achive_name: 'achivementNameCtrl.text',
        filetype: filetype,
        image: imageUrl // Add this field to your ChatDetails model
      );

      final Map<String, dynamic> postdetailsJson = postdetails.toJson();
      await doc.set(postdetailsJson);

      Get.snackbar('Success', 'Post added successfully', colorText: Colors.green);
      setValuesDefault();
    } catch (e) {
      Get.snackbar('Error', e.toString(), colorText: Colors.red);
    }
  }
  setValuesDefault(){
    achivementNameCtrl.clear();
    update();
  }
  // Add Seller messages into seller message collection
  // addSellerMessage(){
  //   try {
  //     int pressingTime = DateTime.now().toUtc().millisecondsSinceEpoch;
  //     DocumentReference doc = sellermessageCollection.doc('$pressingTime');
  //     SellerMessage message = SellerMessage(
  //         id:doc.id,
  //         message:sellerMessageController.text,
  //         pressingTime: DateTime.now().toUtc().millisecondsSinceEpoch,
  //     );
  //     final messageJson = message.toJson();
  //     doc.set(messageJson);
  //     // Get.snackbar('Success', 'Message added successfully', colorText: Colors.green);
  //     setValuesDefault();
  //   } catch (e) {
  //     Get.snackbar('Error', e.toString(), colorText: Colors.red);
  //   }
  // }
  //
  // // Add messages into message collection
  // addMessage(){
  //   try {
  //     int pressingTime = DateTime.now().toUtc().millisecondsSinceEpoch;
  //     DocumentReference doc = messageCollection.doc('$pressingTime');
  //     Message message = Message(
  //       id:doc.id,
  //       message:messageController.text,
  //       pressingTime: DateTime.now().toUtc().millisecondsSinceEpoch,
  //     );
  //     final messageJson = message.toJson();
  //     doc.set(messageJson);
  //     // Get.snackbar('Success', 'Message added successfully', colorText: Colors.green);
  //     setValuesDefault();
  //   } catch (e) {
  //     Get.snackbar('Error', e.toString(), colorText: Colors.red);
  //   }
  // }
  //
  // // Add log details into logdetails collection
  // addLogDetails(){
  //   try {
  //     DocumentReference doc = logdetailsCollection.doc();
  //     LogDetails logindetails = LogDetails(
  //       id:doc.id,
  //       name:fishNameCtrl.text,
  //       method: fishingMethodCtrl.text,
  //       lat: lat,
  //       long: long,
  //       quantity: fishQuantityCtrl.text,
  //       cost:double.tryParse(fishCostCtrl.text),
  //       sellprice: double.tryParse(sellPriceCtrl.text),
  //       soldquantity:double.tryParse(soldQuantityCtrl.text),
  //       date: logday
  //     );
  //     final logindetailsJson = logindetails.toJson();
  //     doc.set(logindetailsJson);
  //     Get.snackbar('Success', 'Log added successfully', colorText: Colors.green);
  //     setValuesDefault();
  //   } catch (e) {
  //     Get.snackbar('Error', e.toString(), colorText: Colors.red);
  //   }
  // }
  //
  // Add cart details into cart collection
  addCart(int index){
    try {
      DocumentReference doc = cartCollection.doc();
      PostDetails product = PostDetails(
        id:doc.id,
        image:postShowUi[index].image,
        achive_name: postShowUi[index].achive_name,
        filetype:postShowUi[index].filetype
      );
      final productJson = product.toJson();
      doc.set(productJson);
      Get.snackbar('Success', 'Approved Post added successfully', colorText: Colors.green);
      setValuesDefault();
    } catch (e) {
      Get.snackbar('Error', e.toString(), colorText: Colors.red);
    }
  }
  // addVideos(String by, String level, String name, String thumb, String url){
  //   try {
  //     DocumentReference doc = videoAddCollection.doc();
  //     AddVideo product = AddVideo(
  //         id:doc.id,
  //         by:by,
  //         level: level,
  //         name:name,
  //         thumb:thumb,
  //         timeStamp: DateTime.now(),
  //         url:url
  //     );
  //     final productJson = product.toJson();
  //     doc.set(productJson);
  //     Get.snackbar('Success', 'Approved Post added successfully', colorText: Colors.green);
  //     setValuesDefault();
  //   } catch (e) {
  //     Get.snackbar('Error', e.toString(), colorText: Colors.red);
  //   }
  // }

  // // Add product details into product collection
  // addProduct(){
  //   try {
  //     DocumentReference doc = productCollection.doc();
  //     Product product = Product(
  //           id:doc.id,
  //           name:productNameCtrl.text,
  //           category: category,
  //           description: productDescriptionCtrl.text,
  //           price: double.tryParse(productPriceCtrl.text),
  //           brand: brand,
  //           image: productImgCtrl.text,
  //           offer: offer,
  //         );
  //     final productJson = product.toJson();
  //     doc.set(productJson);
  //     Get.snackbar('Success', 'Product added successfully', colorText: Colors.green);
  //     setValuesDefault();
  //   } catch (e) {
  //     Get.snackbar('Error', e.toString(), colorText: Colors.red);
  //   }
  // }
  //
  // // Set the values to default values
  // setValuesDefault(){
  //   productNameCtrl.clear();
  //   productPriceCtrl.clear();
  //   productDescriptionCtrl.clear();
  //   productImgCtrl.clear();
  //   category = 'Category';
  //   brand = 'Fish Category';
  //   offer = false;
  //   update();
  // }

  // Fetch the cart details from cart details collection
  // fetchCartDetails() async {
  //   try {
  //     QuerySnapshot cartdetailsSnapshot = await cartCollection.get();
  //     final List<Product> retrievedLog = cartdetailsSnapshot.docs.map((doc) => Product.fromJson(doc.data() as Map<String, dynamic>)).toList();
  //     cart.clear();
  //     cart.assignAll(retrievedLog);
  //     cartShowInUi.assignAll(cart);
  //     Get.snackbar('Success', 'CartDetails fetch successfully', colorText: Colors.green);
  //   } catch (e) {
  //     Get.snackbar('Error', e.toString(), colorText: Colors.red);
  //   } finally{
  //     update();
  //   }
  // }
  //
  // // Fetch the log details from log details collection
  // fetchLogDetails() async {
  //   try {
  //     QuerySnapshot logdetailsSnapshot = await logdetailsCollection.get();
  //     final List<LogDetails> retrievedLog = logdetailsSnapshot.docs.map((doc) => LogDetails.fromJson(doc.data() as Map<String, dynamic>)).toList();
  //     logdetails.clear();
  //     logdetails.assignAll(retrievedLog);
  //     logShowUi.assignAll(logdetails);
  //     Get.snackbar('Success', 'LogDetails fetch successfully', colorText: Colors.green);
  //   } catch (e) {
  //     Get.snackbar('Error', e.toString(), colorText: Colors.red);
  //   } finally{
  //     update();
  //   }
  // }
  //
  // // Fetch the seller messages from seller messages collection
  // fetchSellerMessage() async {
  //   try {
  //     QuerySnapshot messageSnapshot = await sellermessageCollection.get();
  //     final List<SellerMessage> retrievedMessage = messageSnapshot.docs.map((doc) => SellerMessage.fromJson(doc.data() as Map<String, dynamic>)).toList();
  //     sellermessage.clear();
  //     sellermessage.assignAll(retrievedMessage);
  //     sellermessageUi.assignAll(sellermessage);
  //     // Get.snackbar('Success', 'Message fetch successfully', colorText: Colors.green);
  //   } catch (e) {
  //     Get.snackbar('Error', e.toString(), colorText: Colors.red);
  //   } finally{
  //     update();
  //   }
  // }
  //
  // // Fetch the messages from message collection
  // fetchMessage() async {
  //   try {
  //     QuerySnapshot messageSnapshot = await messageCollection.get();
  //     final List<Message> retrievedMessage = messageSnapshot.docs.map((doc) => Message.fromJson(doc.data() as Map<String, dynamic>)).toList();
  //     message.clear();
  //     message.assignAll(retrievedMessage);
  //     messageUi.assignAll(message);
  //     // Get.snackbar('Success', 'Message fetch successfully', colorText: Colors.green);
  //   } catch (e) {
  //     Get.snackbar('Error', e.toString(), colorText: Colors.red);
  //   } finally{
  //     update();
  //   }
  // }
  //
  // // Fetch the post details from post details collection
  // fetchPostDetails() async {
  //   try {
  //     QuerySnapshot chatSnapshot = await chatlogCollection.get();
  //     final List<ChatDetails> retrievedChats = chatSnapshot.docs.map((doc) => ChatDetails.fromJson(doc.data() as Map<String, dynamic>)).toList();
  //     chatdetails.clear();
  //     chatdetails.assignAll(retrievedChats);
  //     makePostUi.assignAll(chatdetails);
  //     Get.snackbar('Success', 'Post details fetch successfully', colorText: Colors.green);
  //   } catch (e) {
  //     Get.snackbar('Error', e.toString(), colorText: Colors.red);
  //   } finally{
  //     update();
  //   }
  // }
  //
  // // Fetch the products details from the product details collection
  // fetchProducts() async {
  //   try {
  //     QuerySnapshot productSnapshot = await productCollection.get();
  //     final List<Product> retrievedProducts = productSnapshot.docs.map((doc) => Product.fromJson(doc.data() as Map<String, dynamic>)).toList();
  //     products.clear();
  //     products.assignAll(retrievedProducts);
  //     productShowInUi.assignAll(products);
  //     Get.snackbar('Success', 'Product fetch successfully', colorText: Colors.green);
  //   } catch (e) {
  //     Get.snackbar('Error', e.toString(), colorText: Colors.red);
  //   } finally{
  //     update();
  //   }
  // }
  //
  // Fetch the post details from the post details collection
  fetchPostsList() async{
    try {
      QuerySnapshot postSnapshot = await postdetailsCollection.get();
      final List<PostDetails> retrievedPost = postSnapshot.docs.map((doc) => PostDetails.fromJson(doc.data() as Map<String, dynamic>)).toList();
      postdetails.clear();
      postdetails.assignAll(retrievedPost);
      postShowUi.assignAll(postdetails);
      Get.snackbar('Success', 'Post fetch successfully', colorText: Colors.green);
    } catch (e) {
      Get.snackbar('Error', e.toString(), colorText: Colors.red);
    } finally{
      update();
    }
  }

  // Fetch item categories
  // fetchCategory() async {
  //   try {
  //     QuerySnapshot categorySnapshot = await categoryCollection.get();
  //     final List<ProductCategory> retrievedCategories = categorySnapshot.docs.map((doc) =>
  //         ProductCategory.fromJson(doc.data() as Map<String, dynamic>)).toList();
  //     productCategories.clear();
  //     productCategories.assignAll(retrievedCategories);
  //     Get.snackbar('Success', 'Category fetch successfully', colorText: Colors.green);
  //   } catch (e) {
  //     Get.snackbar('Error', e.toString(), colorText: Colors.red);
  //   } finally{
  //     update();
  //   }
  // }
  // fetchProducts() async {
  //   try {
  //     QuerySnapshot productSnapshot = await productCollection.get();
  //     final List<Product> retrievedProducts = productSnapshot.docs.map((doc) => Product.fromJson(doc.data() as Map<String, dynamic>)).toList();
  //     products.clear();
  //     products.assignAll(retrievedProducts);
  //     productShowInUi.assignAll(products);
  //     Get.snackbar('Success', 'Product fetch successfully', colorText: Colors.green);
  //   } catch (e) {
  //     Get.snackbar('Error', e.toString(), colorText: Colors.red);
  //   } finally{
  //     update();
  //   }
  // }

  // Category filters
  // filterByCategory(String category){
  //   productShowInUi.clear();
  //   productShowInUi = products.where((product) => product.category == category).toList();
  //   update();
  // }

  // Sort by price
  // sortByPrice({required bool ascending}){
  //   List<Product> sortedProducts = List<Product>.from(productShowInUi);
  //   sortedProducts.sort((a,b) => ascending ? a.price!.compareTo(b.price!) : b.price!.compareTo(a.price!));
  //   productShowInUi = sortedProducts;
  //   update();
  // }
  // Brand category
  // filterByBrand(List<String> brands) {
  //   if (brands.isEmpty) {
  //     productShowInUi = products.toList(); // Convert the iterable to a list
  //   } else {
  //     List<String> lowerCaseBrands = brands.map((brand) => brand.toLowerCase()).toList();
  //     productShowInUi = products.where((product) => lowerCaseBrands.contains(product.level?.toLowerCase() ?? '')).toList();
  //   }
  //   update();
  // }

  // Delete the products from database
  deleteProduct(String id) async {
    try {
      await postdetailsCollection.doc(id).delete();
      fetchPostsList();
    } catch (e) {
      Get.snackbar('Error', e.toString(), colorText: Colors.red);
    }
  }

  testMethod(){
  }
}