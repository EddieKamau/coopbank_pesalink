This package contains methods that make it easy to consume Co-op Bank Pesalink Api. It's multi-platform, and supports CLI, server, mobile, desktop, and the browser.

## Using

Create an instance of CoopPesalink, then use its methods to consume the Api

```dart
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
```

The API response has a message code that represent the status of the request;
[bankReponse.messageCode] or [messageCode.rawResponceBody['MessageCode']]

| Code   | Description         
| ------ | :-------------------
| 0      | Full Success             
| 1      | Partial Success             
| 2      | Full Failure             
| -1     | Dublicate message reference             
| -2     | Invalid/Missing parameter 
| -3     | The amount must be positive 
| -4     | Request timed out 
| -5     | Debit and Credit(s) amount not balancing 
| -6     | Amount Less/Greater than Minimum/Maximum limit allowed or Date format 
| -8     | Account authorization failure 
| -9     | Currency invalid/not allowed 
| -10    | Bank  code invalid/not pesalink memberbank 
| -11    | Message reference longer than allowed length 
| -12    | Dublicate/Identical reference 
| -13    | Message reference does not exist 
| -15    | Invalid account number 
| -16    | Daily limi exhausted 