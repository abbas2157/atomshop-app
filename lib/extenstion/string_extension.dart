extension StringExtension on String {
  bool isSelectedFilePDF() {
    if (this.isEmpty) return false;
    final lowercasePath = this.toLowerCase();
    return lowercasePath.endsWith('.pdf');
  }

   // Check if the string is a valid UK phone number
  bool isUKPhoneNumber() {
    if (this.isEmpty) return false;
    final RegExp ukPhoneRegExp = RegExp(
      r"^(\+44\s?7\d{3}|\(?07\d{3}\)?)\s?\d{3}\s?\d{3}$"
    );
    return ukPhoneRegExp.hasMatch(this);
  }
}
