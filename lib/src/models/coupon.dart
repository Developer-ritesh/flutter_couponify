enum DiscountType {
  percentage,
  fixed,
}

class Coupon {
  final String code;
  final double discountValue;
  final DiscountType discountType;
  final DateTime expiryDate;
  final double minPurchaseAmount;
  final int usageLimit;
  final int usageCount;

  Coupon({
    required this.code,
    required this.discountValue,
    required this.discountType,
    required this.expiryDate,
    required this.minPurchaseAmount,
    required this.usageLimit,
    required this.usageCount,
  });

  // Adding a copyWith method for immutability
  Coupon copyWith({
    String? code,
    double? discountValue,
    DiscountType? discountType,
    DateTime? expiryDate,
    double? minPurchaseAmount,
    int? usageLimit,
    int? usageCount,
  }) {
    return Coupon(
      code: code ?? this.code,
      discountValue: discountValue ?? this.discountValue,
      discountType: discountType ?? this.discountType,
      expiryDate: expiryDate ?? this.expiryDate,
      minPurchaseAmount: minPurchaseAmount ?? this.minPurchaseAmount,
      usageLimit: usageLimit ?? this.usageLimit,
      usageCount: usageCount ?? this.usageCount,
    );
  }
}
