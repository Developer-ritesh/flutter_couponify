// lib/controllers/coupon_verification_controller.dart
import 'package:get/get.dart';

import '../models/coupon.dart';

class CouponVerificationController extends GetxController {
  final _discount = 0.0.obs;
  final _message = ''.obs;
  Coupon? generatedCoupon;

  double get discount => _discount.value;
  String get message => _message.value;

  // Updated method to return generated coupon
  Coupon? generateCoupon({
    required String code,
    required double discountValue,
    required DiscountType discountType,
    required DateTime expiryDate,
    required double minPurchaseAmount,
    required int usageLimit,
  }) {
    generatedCoupon = Coupon(
      code: code,
      discountValue: discountValue,
      discountType: discountType,
      expiryDate: expiryDate,
      minPurchaseAmount: minPurchaseAmount,
      usageLimit: usageLimit,
      usageCount: 0,
    );
    _message.value = 'Coupon generated successfully!';
    return generatedCoupon; // Return the generated coupon
  }

  void verifyCoupon({
    required double orderAmount,
    required String serverCode,
    required String userCode,
  }) {
    if (userCode.isEmpty) {
      _message.value = 'Please enter a coupon code';
      return;
    }

    if (generatedCoupon == null || serverCode != userCode) {
      _message.value = 'Invalid coupon code';
      return;
    }

    if (generatedCoupon!.expiryDate.isBefore(DateTime.now())) {
      _message.value = 'Coupon expired';
      return;
    }

    if (orderAmount < generatedCoupon!.minPurchaseAmount) {
      _message.value = 'Minimum purchase amount not met';
      return;
    }

    if (generatedCoupon!.usageLimit > 0 &&
        generatedCoupon!.usageCount >= generatedCoupon!.usageLimit) {
      _message.value = 'Coupon usage limit exceeded';
      return;
    }

    double discount = 0;
    if (generatedCoupon!.discountType == DiscountType.percentage) {
      discount = orderAmount * (generatedCoupon!.discountValue / 100);
    } else if (generatedCoupon!.discountType == DiscountType.fixed) {
      discount = generatedCoupon!.discountValue;
    }

    // Increment usage count
    generatedCoupon = generatedCoupon!.copyWith(
      usageCount: generatedCoupon!.usageCount + 1,
    );

    _discount.value = discount;
    _message.value = 'Coupon applied successfully!';
  }
}
