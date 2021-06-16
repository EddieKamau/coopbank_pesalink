import 'package:coopbank_pesalink/coopbank_pesalink.dart';

void main() async {
  String accessToken() {
    return 'your token';
  } 

  var coopPesalink = CoopPesalink(baseAccountNo: '36001873000'); 

  // pesalink
  BankReponse bankReponse = await coopPesalink.pesaLink(
    referenceNumber: 'bcsjsgcjscjbsdjbvdvjrdfi', 
    accountNumber: '{accountNumber}', 
    bankCode: '{bankCode}', 
    amount: 50, 
    callBackUrl: '{callBackUrl}', 
    transactionDescription: '{transactionDescription}', 
    accessToken: accessToken()
  );

  print(bankReponse.rawResponceBody);

  // fetch latest 10 transactions
  BankReponse bankReponseTransactions = await coopPesalink.trancations(
    referenceNumber: 'bcsjsgcjscjbsdjbvdvjrdfi', 
    noOfTransactions: 10, 
    accessToken: accessToken()
  );

  print(bankReponseTransactions.rawResponceBody); // print the whole response body
  print(bankReponseTransactions.transactions); // print the the lis of transactions [List<BankTransactionModel>]
}
