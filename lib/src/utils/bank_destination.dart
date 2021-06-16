class Destination {

  Destination({
    this.accountNumber, this.amount, this.bankCode, this.mobileNumber, this.narration, this.phoneNumber,
    this.referenceNumber, this.responseCode, this.responseDescription, this.transactionCurrency, this.transactionID
  });

  Destination.fromMap(Map map){
    referenceNumber = map['ReferenceNumber'] ?? '';
    accountNumber = map['AccountNumber'] ?? '';
    mobileNumber = map['MobileNumber'] ?? '';
    phoneNumber = map['PhoneNumber'] ?? '';
    bankCode = map['BankCode'] ?? '';
    amount = map['Amount']?.toDouble();
    transactionCurrency = map['TransactionCurrency'] ?? '';
    narration = map['Narration'] ?? '';
    transactionID = map['TransactionID'] ?? '';
    responseCode = map['ResponseCode'] ?? '';
    responseDescription = map['ResponseDescription'] ?? '';
  }

  String? referenceNumber;
  String? accountNumber;
  String? mobileNumber;
  String? phoneNumber;
  String? bankCode;
  double? amount;
  String? transactionCurrency;
  String? narration;
  String? transactionID;
  String? responseCode;
  String? responseDescription;

  Map<String, dynamic> get asMap =>{
    'referenceNumber': referenceNumber,
    'accountNumber': accountNumber,
    'mobileNumber': mobileNumber,
    'phoneNumber': phoneNumber,
    'bankCode': bankCode,
    'amount': amount,
    'transactionCurrency': transactionCurrency,
    'narration': narration,
    'transactionID': transactionID,
    'responseCode': responseCode,
    'responseDescription': responseDescription
  };
}
