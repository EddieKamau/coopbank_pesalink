class BankTransactionModel {
  BankTransactionModel(
      {required this.transactionID,
      required this.creditAmount,
      required this.debitAmount,
      required this.debitLimit,
      required this.limitExpiryDate,
      required this.narration,
      required this.runningBookBalance,
      required this.runningClearedBalance,
      required this.servicePoint,
      required this.transactionDate,
      required this.transactionReference,
      required this.transactionType,
      required this.valueDate});

  BankTransactionModel.fromMap(Map map) {
    transactionID = map['TransactionID'] ?? '';
    transactionDate = map['TransactionDate'] != null
        ? DateTime.parse(map['TransactionDate'])
        : DateTime.now();
    valueDate = map['ValueDate'] ?? '';
    narration = map['Narration'] ?? '';
    transactionType = map['TransactionType'] ?? '';
    servicePoint = map['ServicePoint'] ?? '';
    transactionReference = map['TransactionReference'] ?? '';
    creditAmount = (map['CreditAmount'] ?? 0).toDouble();
    debitAmount = (map['DebitAmount'] ?? 0).toDouble();
    runningClearedBalance = (map['RunningClearedBalance'] ?? 0).toDouble();
    runningBookBalance = (map['RunningBookBalance'] ?? 0).toDouble();
    debitLimit = (map['DebitLimit'] ?? 0).toDouble();
    limitExpiryDate = map['TransactionDate'] != null
        ? DateTime.parse(map['LimitExpiryDate'])
        : DateTime.now();
  }

  late String transactionID;
  late DateTime transactionDate;
  late String valueDate;
  late String narration;
  late String transactionType;
  late String servicePoint;
  late String transactionReference;
  late double creditAmount;
  late double debitAmount;
  late double runningClearedBalance;
  late double runningBookBalance;
  late double debitLimit;
  late DateTime limitExpiryDate;

  Map<String, dynamic> get asMap => {
        'transactionID': transactionID,
        'transactionDate': transactionDate,
        'valueDate': valueDate,
        'narration': narration,
        'transactionType': transactionType,
        'servicePoint': servicePoint,
        'transactionReference': transactionReference,
        'creditAmount': creditAmount,
        'debitAmount': debitAmount,
        'runningClearedBalance': runningClearedBalance,
        'runningBookBalance': runningBookBalance,
        'debitLimit': debitLimit,
        'limitExpiryDate': limitExpiryDate
      };
}
