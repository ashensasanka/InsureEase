import 'package:app/models/suppliers.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../screens/supplier_detail_page.dart';
import '../screens/widget/suppliers_widget.dart';

class SuppliersPage extends StatefulWidget {
  const SuppliersPage({super.key});

  @override
  State<SuppliersPage> createState() => _SuppliersPageState();
}

class _SuppliersPageState extends State<SuppliersPage> {
  List<Suppliers> suppliersList = [];
  @override
  void initState() {
    super.initState();
    fetchSuppliers(); // Call the method to fetch claims when the widget initializes
  }
  void fetchSuppliers() async {
    List<Suppliers> suppliers = await Suppliers.getSuppliersFromFirestore();
    setState(() {
      suppliersList = suppliers; // Update the state with retrieved claims
    });
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 16, bottom: 20, top: 20),
              child: const Text(
                'Recommended Suppliers',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              height: size.height * .5,
              child: ListView.builder(
                itemCount: suppliersList.length,
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          child: SupplierDetailPage(
                            supplierIndex: suppliersList[index].supplierIndex,
                          ),
                          type: PageTransitionType.leftToRight,
                        ),
                      );
                    },
                    child: SuppliersWidget(index: index, supplierList: suppliersList),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
