import 'package:coopbank_pesalink/coopbank_pesalink.dart';


/// [BankReponse] converts the http response body to a dart object [BankReponse]
class BankReponse {

  BankReponse.fromMap(Map<String, dynamic> map){
    messageReference = map['MessageReference'];
    messageDateTime = DateTime.parse(map['MessageDateTime']);
    messageCode = map['MessageCode'];
    messageDescription = map['MessageDescription'];

    // for full statement, mini statement, transction, account balance
    accountNumber = map['AccountNumber'];
    accountName = map['AccountName'];

    // for transactions
    noOfTransactions = map['NoOfTransactions'];
    totalCredits = map['TotalCredits'];
    totalDebits = map['TotalDebits'];

    // for exchange rate
    fromCurrencyCode = map['FromCurrencyCode'];
    toCurrencyCode = map['ToCurrencyCode'];
    rateType = map['RateType'];
    rate = map['Rate'];
    tolerance = map['Tolerance'];
    multiplyDivide = map['MultiplyDivide'];


    // for balance
    currency = map['Currency'];
    productName = map['ProductName'];
    clearedBalance = map['ClearedBalance']?.toDouble();
    bookedBalance = map['BookedBalance']?.toDouble();
    blockedBalance = map['BlockedBalance']?.toDouble();
    availableBalance = map['AvailableBalance']?.toDouble();
    arrearsAmount = map['ArrearsAmount']?.toDouble();
    branchName = map['BranchName'];
    branchSortCode = map['BranchSortCode'];
    averageBalance = map['AverageBalance']?.toDouble();
    unclearedBalance = map['UnclearedBalance']?.toDouble();
    oDLimit = map['ODLimit']?.toDouble();
    creditLimit = map['CreditLimit']?.toDouble();

    transactions = (map['Transactions'] as List<Map>?)?.map((Map t) => BankTransactionModel.fromMap(t)).toList();

    // for transaction status
    source = map['Source'] != null ? Source.fromMap(map['Source']) : null;
    destinations = (map['Destinations'] as List<Map>?)?.map((Map d) => Destination.fromMap(d)).toList();

    rawResponceBody = map;
    
  }

  Map<String, dynamic> rawResponceBody = {};
  String? messageReference;
  DateTime? messageDateTime;

  /// The status of the response where 0 is success.s
  String? messageCode;

  String? messageDescription;

  // for full statement, mini statement, transction, account balance
  String? accountNumber;
  String? accountName;

  // for transactions
  int? noOfTransactions;
  double? totalCredits;
  double? totalDebits;

  // for exchange rate
  String? fromCurrencyCode;
  String? toCurrencyCode;
  String? rateType;
  double? rate;
  double? tolerance;
  String? multiplyDivide;


  // for balance
  String? currency;
  String? productName;
  double? clearedBalance;
  double? bookedBalance;
  double? blockedBalance;
  double? availableBalance;
  double? arrearsAmount;
  String? branchName;
  String? branchSortCode;
  double? averageBalance;
  double? unclearedBalance;
  double? oDLimit;
  double? creditLimit;

  List<BankTransactionModel>? transactions;

  // for transaction status
  Source? source;
  List<Destination>? destinations;

  // from http reponse
  int? statusCode;
}
