import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../constants.dart';
import '../../models/claims.dart';
import '../../models/plants.dart';
import '../detail_page.dart';

class ClaimWidget extends StatelessWidget {
  const ClaimWidget({
    Key? key,
    required this.index,
    required this.claimList,
  }) : super(key: key);

  final int index;
  final List<Claims> claimList;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            PageTransition(
                child: DetailPage(
                  claimIndex: claimList[index].claimIndex,
                ),
                type: PageTransitionType.bottomToTop),);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Constants.primaryColor.withOpacity(.2),
          borderRadius: BorderRadius.circular(10),
        ),
        height: 65.0,
        padding: const EdgeInsets.only(left: 10, top: 10),
        margin: const EdgeInsets.only(bottom: 5, top: 5),
        width: size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 45.0,
                  height: 45.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(
                  height: 45.0,
                  child: Image.asset(
                    'assets/images/claimicon.png',
                    scale: 0.1,
                  ),
                ),
                Positioned(
                  bottom: 5,
                  left: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(claimList[index].claimId),
                      Text(
                        claimList[index].typeofAccident,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Constants.blackColor,
                        ),
                      ),
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
