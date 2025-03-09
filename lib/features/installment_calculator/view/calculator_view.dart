import 'package:flutter/material.dart';

class InstallmentCalculator extends StatefulWidget {
  final double totalProductPrice;
  final double minAdvanceAmount;
  final Function(double dealAmount, double advanceAmount, int months)
      onInstallmentChange; // New callback function

  const InstallmentCalculator({
    super.key,
    required this.totalProductPrice,
    required this.minAdvanceAmount,
    required this.onInstallmentChange, // Pass function from SingleProductDetails
  });

  @override
  State<InstallmentCalculator> createState() => _InstallmentCalculatorState();
}

class _InstallmentCalculatorState extends State<InstallmentCalculator> {
  late TextEditingController _advanceController;
  int _selectedMonths = 3;
  final int _minMonths = 3;
  final int _maxMonths = 12;
  final double _monthlyPercentage = 4.0;
  late double _totalDealAmount;
  late List<InstallmentPlan> _installmentPlans;
  String _warningMessage = "";

  @override
  void initState() {
    super.initState();
    _advanceController =
        TextEditingController(text: widget.minAdvanceAmount.toStringAsFixed(0));
    _calculateInstallmentPlan();
  }

  @override
  void dispose() {
    _advanceController.dispose();
    super.dispose();
  }

  void _calculateInstallmentPlan() {
    double advanceAmount =
        double.tryParse(_advanceController.text) ?? widget.minAdvanceAmount;

    if (advanceAmount < widget.minAdvanceAmount) {
      _warningMessage =
          "⚠ Minimum advance should be Rs. ${widget.minAdvanceAmount.toStringAsFixed(0)}";
    } else if (advanceAmount > widget.totalProductPrice) {
      _warningMessage = "⚠ Advance cannot exceed total price!";
    } else {
      _warningMessage = "";
    }

    double remainingAmount = widget.totalProductPrice - advanceAmount;
    double interestAmount =
        remainingAmount * (_monthlyPercentage / 100) * _selectedMonths;
    _totalDealAmount = advanceAmount + remainingAmount + interestAmount;

    _installmentPlans = List.generate(_selectedMonths, (index) {
      return InstallmentPlan(
        srNo: index + 1,
        month: _getMonthLabel(index + 1), // ✅ Now this will work
        amount: (remainingAmount / _selectedMonths) +
            (interestAmount / _selectedMonths),
      );
    });

    // 🔥 Notify SingleProductDetails page
    widget.onInstallmentChange(
        _totalDealAmount, advanceAmount, _selectedMonths);

    setState(() {});
  }

  String _getMonthLabel(int month) {
    if (month == 1) return "1st Month";
    if (month == 2) return "2nd Month";
    if (month == 3) return "3rd Month";
    return "$month" "th Month";
  }
Widget _buildInstallmentTable() {
  return Column(
    children: [
      Container(
        color: Colors.grey.shade200,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text("Month", style: TextStyle(fontWeight: FontWeight.bold)),
            Text("Installment (Rs.)",
                style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      Column(
        children: _installmentPlans.map((plan) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade300),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(plan.month),
                Text("Rs. ${plan.amount.toStringAsFixed(0)}"),
              ],
            ),
          );
        }).toList(),
      ),
    ],
  );
}

  void _changeMonths(bool increase) {
    if (increase && _selectedMonths < _maxMonths) {
      _selectedMonths++;
    } else if (!increase && _selectedMonths > _minMonths) {
      _selectedMonths--;
    }
    _calculateInstallmentPlan();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildAdvanceAmountInput(),
        const SizedBox(height: 12),
        _buildMonthSelector(),
        const SizedBox(height: 12),
        _buildTotalDealAmount(),
        const SizedBox(height: 12),
        _buildInterestRate(),
                const SizedBox(height: 12),

        _buildInstallmentTable(), // 👈 Ye function add kar lo

      ],
    );
  }

  Widget _buildAdvanceAmountInput() {
    return TextField(
      controller: _advanceController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: "Advance Amount (Rs.)",
        border: OutlineInputBorder(),
      ),
      onChanged: (value) {
        _calculateInstallmentPlan();
      },
    );
  }

  Widget _buildMonthSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Installment Months"),
        Row(
          children: [
            IconButton(
              onPressed: () => _changeMonths(false),
              icon: const Icon(Icons.remove),
            ),
            Text("$_selectedMonths"),
            IconButton(
              onPressed: () => _changeMonths(true),
              icon: const Icon(Icons.add),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTotalDealAmount() {
    return Text("Total Deal Amount: Rs. ${_totalDealAmount.toStringAsFixed(0)}",
        style: const TextStyle(fontWeight: FontWeight.bold));
  }

  Widget _buildInterestRate() {
    return const Text("Monthly Interest Rate: 4%",
        style: TextStyle(fontWeight: FontWeight.bold));
  }
}

class InstallmentPlan {
  final int srNo;
  final String month;
  final double amount;

  InstallmentPlan(
      {required this.srNo, required this.month, required this.amount});
}
