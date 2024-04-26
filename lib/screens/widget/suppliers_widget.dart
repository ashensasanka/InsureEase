import 'package:app/models/suppliers.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../constants.dart';
import '../detail_page.dart';
import '../supplier_detail_page.dart';

class SuppliersWidget extends StatelessWidget {
  const SuppliersWidget({
    Key? key,
    required this.index,
    required this.supplierList,
  }) : super(key: key);

  final int index;
  final List<Suppliers> supplierList;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            PageTransition(
                child: SupplierDetailPage(
                  supplierIndex: supplierList[index].supplierIndex,
                ),
                type: PageTransitionType.bottomToTop));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Constants.primaryColor.withOpacity(.1),
          borderRadius: BorderRadius.circular(10),
        ),
        height: 80.0,
        padding: const EdgeInsets.only(left: 10, top: 10),
        margin: const EdgeInsets.only(bottom: 10, top: 10),
        width: size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: SizedBox(
                    height: 60.0,
                    child: Image.asset('assets/images/claimicon.png',scale: 0.1,),
                  ),
                ),
                Positioned(
                  bottom: 5,
                  left: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        supplierList[index].supplierName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Constants.blackColor,
                        ),
                      ),
                      Text(supplierList[index].supplierId),

                    ],
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.only(right: 10),
              child: Icon(
                Icons.chevron_right,
                size: 35,
              ),
            )
          ],
        ),
      ),
    );
  }
}
