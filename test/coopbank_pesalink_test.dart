import 'package:coopbank_pesalink/coopbank_pesalink.dart';
import 'package:test/test.dart';

void main() {
  group('Pesalink conversion to BankReponse tests', () {

    Map<String, dynamic> pesaLinkSuccessResponse = {
      'MessageReference': '40ca18c6765086089a1',
      'MessageDateTime': '2017-12-04T09:27:00',
      'MessageCode': '0',
      'MessageDescription': 'REQUEST ACCEPTED SUCCESSFULLY'
    };

    Map<String, dynamic> pesaLinkFailedResponse = { 
      'MessageReference': '40ca18c6765086089a1',
      'MessageDateTime': '2017-12-04T09:27:00',
      'MessageCode': '-2',
      'MessageDescription': 'INVALID/MISSING PARAMETER'
    };

    Map<String, dynamic> pesaLinkListOfTransactionsResponse = {
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

    final coopPesalink = BankReponse.fromMap(pesaLinkSuccessResponse);
    final coopPesalinkFailed = BankReponse.fromMap(pesaLinkFailedResponse);
    final coopPesalinkListOfTransactions = BankReponse.fromMap(pesaLinkListOfTransactionsResponse);
    final coopPesalinkAccountBalance = BankReponse.fromMap(accountBalanceResponse);
    final coopPesalinkTransactionStatus = BankReponse.fromMap(transactionStatusResponse);

    setUp(() {
      // Additional setup goes here.
    });

    test('pesalink success response data to BankResponse test', () {
      expect(coopPesalink.messageCode, '0');
    });

    test('pesalink failed response data to BankResponse test', () {
      expect(coopPesalinkFailed.messageCode, '-2');
    });

    test('pesalink list of Transactions to BankResponse test', () {
      expect(coopPesalinkListOfTransactions.transactions?.length, 1);
    });

    test('pesalink values of type double to BankResponse test', () {
      expect(coopPesalinkAccountBalance.clearedBalance, 2195.5);
    });

    test('pesalink converting Source to BankResponse test', () {
      expect(coopPesalinkTransactionStatus.source?.amount, 777);
    });
    
    test('pesalink converting Destination to BankResponse test', () {
      expect(coopPesalinkTransactionStatus.destinations?.length, 1);
    });

    test('pesalink converting Destination to BankResponse test', () {
      expect(coopPesalinkTransactionStatus.destinations?[0].amount, 777);
    });

    
  });
}
