class InstallmentModel {
  final int id;
  final String month;
  final String installmentPrice;
  final String paymentDate;
  final String? paymentMethod;
  final String receipet;
  final String status;

  InstallmentModel({
    required this.id,
    required this.month,
    required this.installmentPrice,
    required this.paymentDate,
    this.paymentMethod,
    required this.receipet,
    required this.status,
  });

  factory InstallmentModel.fromJson(Map<String, dynamic> json) {
    return InstallmentModel(
      id: json['id'],
      month: json['month'],
      installmentPrice: json['installment_price'],
      paymentDate: json['payment_date'],
      paymentMethod: json['payment_method'],
      receipet: json['receipet'],
      status: json['status'],
    );
  }
}
