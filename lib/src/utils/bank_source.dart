class Source {
  Source({
    required this.accountNumber, required this.amount, required this.narration,
    required this.responseCode, required this.responseDescription, required this.transactionCurrency
  });

  Source.fromMap(Map<String, dynamic> map){
    accountNumber = map['AccountNumber'] ?? '';
    amount = (map['Amount'] ?? 0).toDouble();
    transactionCurrency = map['TransactionCurrency'] ?? '';
    narration = map['Narration'] ?? '';
    responseCode = map['ResponseCode'] ?? '';
    responseDescription = map['ResponseDescription'] ?? '';
  }

  late String accountNumber;
  late double amount;
  late String transactionCurrency;
  late String narration;
  late String responseCode;
  late String responseDescription;

  Map<String, dynamic> get asMap =>{
    'accountNumber': accountNumber,
    'amount': amount,
    'transactionCurrency': transactionCurrency,
    'narration': narration,
    'responseCode': responseCode,
    'responseDescription': responseDescription
  };
}