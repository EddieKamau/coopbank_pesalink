Map<String, dynamic> transactionSuccessResponse = {
  'MessageReference': '40ca18c6765086089a1',
  'MessageDateTime': '2017-12-04T09:27:00',
  'MessageCode': '0',
  'MessageDescription': 'REQUEST ACCEPTED SUCCESSFULLY'
};

Map<String, dynamic> transactionFailedResponse = {
  'MessageReference': '40ca18c6765086089a1',
  'MessageDateTime': '2017-12-04T09:27:00',
  'MessageCode': '-2',
  'MessageDescription': 'INVALID/MISSING PARAMETER'
};

Map<String, dynamic> listOfTransactionsResponse = {
  'MessageReference': '40ca18c6765086089a1',
  'MessageDateTime': '2021-06-15T11:12:26.305Z',
  'MessageCode': '0',
  'MessageDescription': 'Success',
  'AccountNumber': '36001873000',
  'AccountName': 'Your Account Name',
  'Transactions': [
    {
      'TransactionId': '116bdbebcca41aXF',
      'TransactionDate': '2019-04-29T10:05:41.178+03:00',
      'ValueDate': '2019-04-29T10:05:40.751+03:00',
      'Narration': 'Electricity Payment',
      'TransactionType': 'C',
      'ServicePoint': 'ATM',
      'TransactionReference': '911909902484902484',
      'CreditAmount': 200,
      'DebitAmount': 0,
      'RunningClearedBalance': 1215.7,
      'RunningBookBalance': 1215.7,
      'DebitLimit': 0,
      'LimitExpiryDate': '2019-04-29T10:05:41.178+03:00'
    }
  ]
};

Map<String, dynamic> accountBalanceResponse = {
  'MessageReference': '40ca18c6765086089a1',
  'MessageDateTime': '2021-06-15T11:16:50.431Z',
  'MessageCode': '0',
  'MessageDescription': 'Success',
  'AccountNumber': '36001873000',
  'AccountName': 'Your Account Name',
  'Currency': 'KES',
  'ProductName': 'Savings Account',
  'ClearedBalance': 2195.5,
  'BookedBalance': 0,
  'BlockedBalance': 1760,
  'AvailableBalance': 0,
  'ArrearsAmount': 0,
  'BranchName': 'UKULIMA BRANCH',
  'BranchSortCode': '00011011',
  'AverageBalance': 75.83,
  'UnclearedBalance': -2195.5,
  'ODLimit': 0,
  'CreditLimit': 1000
};

Map<String, dynamic> transactionStatusResponse = {
  'MessageReference': '40ca18c6765086089a1',
  'MessageDateTime': '2021-06-15T11:21:20.210Z',
  'MessageCode': '0',
  'MessageDescription': 'FULL SUCCESS',
  'Source': {
    'AccountNumber': '12345678912345',
    'Amount': 777,
    'TransactionCurrency': 'KES',
    'Narration': 'Supplier Payment',
    'ResponseCode': '0',
    'ResponseDescription': 'Success'
  },
  'Destinations': [
    {
      'ReferenceNumber': '40ca18c6765086089a1_1',
      'AccountNumber': '12345678912345',
      'MobileNumber': '2547xxxxxxxx',
      'PhoneNumber': '2547xxxxxxxx',
      'BankCode': '011',
      'Amount': 777,
      'TransactionCurrency': 'KES',
      'Narration': 'Supplier Payment',
      'TransactionID': '1169716b65891lI6',
      'ResponseCode': '0',
      'ResponseDescription': 'Success'
    }
  ]
};
