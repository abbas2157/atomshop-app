class PaymentModel {
  final int id;
  final String installmentPrice;
  final String paymentDate;
  final String? paymentMethod;
  final String receipet;
  final String status;

  PaymentModel({
    required this.id,
    required this.installmentPrice,
    required this.paymentDate,
    this.paymentMethod,
    required this.receipet,
    required this.status,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      id: json['id'],
      installmentPrice: json['installment_price'],
      paymentDate: json['payment_date'],
      paymentMethod: json['payment_method'],
      receipet: json['receipet'],
      status: json['status'],
    );
  }
}
