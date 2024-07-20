import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_couponify/flutter_couponify.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final CouponVerificationController couponController =
      Get.put(CouponVerificationController());
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coupon Verifier'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: textController,
              decoration: InputDecoration(labelText: 'Enter coupon code'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                final coupon = couponController.generateCoupon(
                  code: textController.text,
                  discountValue: 10.0,
                  discountType: DiscountType.percentage,
                  expiryDate: DateTime.now().add(Duration(days: 30)),
                  minPurchaseAmount: 50.0,
                  usageLimit: 5,
                );
                Get.snackbar('Message', couponController.message);
                if (coupon != null) {
                  // Display generated coupon details
                  print('Coupon Code: ${coupon.code}');
                  print('Discount Value: ${coupon.discountValue}');
                  print('Discount Type: ${coupon.discountType}');
                  print('Expiry Date: ${coupon.expiryDate}');
                  print('Minimum Purchase Amount: ${coupon.minPurchaseAmount}');
                  print('Usage Limit: ${coupon.usageLimit}');
                  print('Usage Count: ${coupon.usageCount}');
                }
              },
              child: Text('Generate Coupon'),
            ),
            ElevatedButton(
              onPressed: () {
                couponController.verifyCoupon(orderAmount: 100.0, serverCode: 'ASDF', userCode: 'ASDF');
                Get.snackbar('Message', couponController.message);
              },
              child: Text('Verify Coupon'),
            ),
            Obx(() => Text('Discount: ${couponController.discount}')),
          ],
        ),
      ),
    );
  }
}
