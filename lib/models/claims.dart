import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
class Claim {
  final int plantId;
  final String size;
  final double rating;
  final int humidity;
  final String temperature;
  final String category;
  final String plantName;
  final String imageURL;
  bool isAdd;
  bool isFavorated;
  final String decription;
  bool isSelected;

  Claim(
      {required this.plantId,
        required this.isAdd,
        required this.category,
        required this.plantName,
        required this.size,
        required this.rating,
        required this.humidity,
        required this.temperature,
        required this.imageURL,
        required this.isFavorated,
        required this.decription,
        required this.isSelected});

  //List of Plants data
  static List<Claim> claimList = [
    Claim(
        plantId: 0,
        category: 'Toyota',
        plantName: 'Yaris',
        size: 'Small',
        rating: 4.5,
        humidity: 34,
        temperature: '23 - 34',
        imageURL: 'assets/images/claimicon.png',
        isFavorated: true,
        isAdd: false,
        decription:
        'This plant is one of the best plant. It grows in most of the regions in the world and can survive'
            'even the harshest weather condition.',
        isSelected: false),
    Claim(
        plantId: 1,
        category: 'Benz',
        plantName: 'CL250',
        size: 'Medium',
        rating: 4.8,
        humidity: 56,
        temperature: '19 - 22',
        imageURL: 'assets/images/claimicon.png',
        isFavorated: false,
        decription:
        'This plant is one of the best plant. It grows in most of the regions in the world and can survive'
            'even the harshest weather condition.',
        isSelected: false,
        isAdd: false),
    Claim(
        plantId: 2,
        category: '',
        plantName: '',
        size: 'Large',
        rating: 4.7,
        humidity: 34,
        temperature: '22 - 25',
        imageURL: 'assets/images/claimicon.png',
        isFavorated: false,
        decription: '',
        isSelected: false,
        isAdd: true),
  ];
}



class Claims {
  final int claimIndex;
  final String year;
  final double registrationNumber;
  final String expiryDate;
  final String claimId;
  final String typeofAccident;
  final String imageURL;
  final String insuraceType;
  final String model;
  final String typeofIncident;
  final String vehicle;
  bool isSelected;

  Claims({
    required this.claimIndex,
    required this.claimId,
    required this.typeofAccident,
    required this.year,
    required this.registrationNumber,
    required this.expiryDate,
    required this.imageURL,
    required this.isSelected,
    required this.insuraceType,
    required this.model,
    required this.typeofIncident,
    required this.vehicle
  });

  static Future<List<Claims>> getClaimsFromFirestore() async {
    List<Claims> claimsList = [];
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('claimdata${user?.uid}')
          .get();

      querySnapshot.docs.forEach((doc) {
        claimsList.add(Claims(
          claimIndex: doc['claimIndex'].toInt(),
          claimId: doc['claimId'], //ok
          typeofAccident: doc['typeofAccident'], //ok
          year: doc['year'], //ok
          registrationNumber: doc['registrationNumber'].toDouble(), //ok
          expiryDate: doc['expiryDate'], //ok
          imageURL: doc['imageUrl'], //ok
          isSelected: doc['isSelected'],
          insuraceType:doc['insuranceType'], //ok
          model:doc['model'], //ok
          typeofIncident:doc['typeofIncident'], //ok
          vehicle: doc['vehicle'] //ok
        ));
      });

      print('Claims retrieved successfully: $claimsList'); // Add a debug print statement
      return claimsList;
    } catch (error) {
      print('Error retrieving claims: $error'); // Log the error
      return []; // Return an empty list if there's an error
    }
  }
}


