import 'package:coopbank_pesalink/coopbank_pesalink.dart';
import 'package:test/test.dart';

import 'responses.dart';

void main() {
  group('Pesalink conversion to BankReponse tests', () {
    final coopPesalink = BankReponse.fromMap(transactionSuccessResponse);
    final coopPesalinkFailed = BankReponse.fromMap(transactionFailedResponse);
    final coopPesalinkListOfTransactions =
        BankReponse.fromMap(listOfTransactionsResponse);
    final coopPesalinkAccountBalance =
        BankReponse.fromMap(accountBalanceResponse);
    final coopPesalinkTransactionStatus =
        BankReponse.fromMap(transactionStatusResponse);

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
