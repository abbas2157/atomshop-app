import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';

class InstallmentCalculator extends StatefulWidget {
  final double totalProductPrice;
  final double minAdvanceAmount;

  const InstallmentCalculator({
    super.key,
    required this.totalProductPrice,
    required this.minAdvanceAmount,
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
    _advanceController = TextEditingController(text: widget.minAdvanceAmount.toStringAsFixed(0));
    _calculateInstallmentPlan();
  }

  @override
  void dispose() {
    _advanceController.dispose();
    super.dispose();
  }

  void _calculateInstallmentPlan() {
    double advanceAmount = double.tryParse(_advanceController.text) ?? widget.minAdvanceAmount;

    // Handle warnings but allow any input
    if (advanceAmount < widget.minAdvanceAmount) {
      _warningMessage = "⚠ Minimum advance should be Rs. ${widget.minAdvanceAmount.toStringAsFixed(0)}";
    } else if (advanceAmount > widget.totalProductPrice) {
      _warningMessage = "⚠ Advance cannot exceed total price!";
    } else {
      _warningMessage = "";
    }

    double remainingAmount = widget.totalProductPrice - advanceAmount;
    double interestAmount = remainingAmount * (_monthlyPercentage / 100) * _selectedMonths;
    _totalDealAmount = advanceAmount + remainingAmount + interestAmount;
    double monthlyInstallmentWithInterest = (remainingAmount / _selectedMonths) + (interestAmount / _selectedMonths);

    _installmentPlans = List.generate(_selectedMonths, (index) {
      return InstallmentPlan(
        srNo: index + 1,
        month: _getMonthLabel(index + 1),
        amount: monthlyInstallmentWithInterest,
      );
    });

    setState(() {});
  }

  String _getMonthLabel(int month) {
    if (month == 1) return "1st Month";
    if (month == 2) return "2nd Month";
    if (month == 3) return "3rd Month";
    return "$month" "th Month";
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
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 600;

    return Container(
      padding: EdgeInsets.all(isMobile ? 12 : 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Payment Calculator",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
          const SizedBox(height: 16),

          // Responsive Layout
          LayoutBuilder(builder: (context, constraints) {
            return isMobile
                ? Column(
                    children: [
                      _buildAdvanceAmountInput(),
                      const SizedBox(height: 12),
                      _buildMonthSelector(),
                      const SizedBox(height: 12),
                      _buildInstallmentButton(),
                    ],
                  )
                : Row(
                    children: [
                      Expanded(child: _buildAdvanceAmountInput()),
                      const SizedBox(width: 8),
                      Expanded(child: _buildMonthSelector()),
                      const SizedBox(width: 8),
                      Expanded(child: Center(child: Text("$_monthlyPercentage% Interest", style: TextStyle(fontWeight: FontWeight.w500)))),
                      const SizedBox(width: 8),
                      Expanded(child: Center(child: Text("Rs. ${_totalDealAmount.toStringAsFixed(0)}", style: TextStyle(fontWeight: FontWeight.w500)))),
                      const SizedBox(width: 8),
                      Expanded(child: _buildInstallmentButton()),
                    ],
                  );
          }),

          const SizedBox(height: 16),

          // Installment Schedule
          _buildInstallmentHeader(),
          ..._installmentPlans.map((plan) => _buildInstallmentRow(plan.srNo, plan.month, plan.amount)),
        ],
      ),
    );
  }

  Widget _buildAdvanceAmountInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Advance Amount (Rs.)", style: TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 4),
        TextField(
          controller: _advanceController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
            isDense: true,
          ),
          onChanged: (value) {
            _calculateInstallmentPlan();
          },
        ),
        if (_warningMessage.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(_warningMessage, style: const TextStyle(color: Colors.red, fontSize: 12)),
          ),
      ],
    );
  }

  Widget _buildMonthSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Installment Months", style: TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 4),
        Row(
          children: [
            _buildMonthButton(Icons.remove, false),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text("$_selectedMonths", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
            _buildMonthButton(Icons.add, true),
          ],
        ),
      ],
    );
  }

  Widget _buildMonthButton(IconData icon, bool increase) {
    return InkWell(
      onTap: () => _changeMonths(increase),
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(color: Color(0xFFF6AD37), borderRadius: BorderRadius.circular(4)),
        child: Icon(icon, color: Colors.white),
      ),
    );
  }

  Widget _buildInstallmentButton() {
    return ElevatedButton(
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Installment plan created successfully!")),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 10),
      ),
      child: Text("Make Installments", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
    );
  }

  Widget _buildInstallmentHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text("Installment Plan", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
    );
  }

  Widget _buildInstallmentRow(int srNo, String month, double amount) {
    return ListTile(
      leading: Text("$srNo.", style: TextStyle(fontWeight: FontWeight.w500)),
      title: Text(month),
      trailing: Text("Rs. ${amount.toStringAsFixed(0)}"),
    );
  }
}

class InstallmentPlan {
  final int srNo;
  final String month;
  final double amount;

  InstallmentPlan({required this.srNo, required this.month, required this.amount});
}

