library coopbank_pesalink;

import 'src/utils/pesalink_prosses_transaction.dart';

import 'src/utils/bank_response.dart';

export 'src/utils/bank_transactions_model.dart';

export 'src/utils/bank_source.dart';

export 'src/utils/bank_destination.dart';

export 'src/utils/bank_response.dart';

/// This package contains methods that make it easy to consume Co-op Bank Pesalink Api.
/// It requires [baseAccountNo], the account number that initiates the transactions.
/// - [currency], [branchCode],
/// - & [applicationMode], for determining whether to hit the test api or production api
///
///---
///
/// For all requests, the 400 http response is for
/// INVALID/MISSING PARAMETER  where the MessageCode is -2,
/// MESSAGE REFERENCE LONGER THAN ALLOWED LENGTH   where the MessageCode is -11
/// and looks like
/// ```dart
/// {
///   "MessageReference": "40ca18c6765086089a1",
///   "MessageDateTime": "2017-12-04T09:27:00",
///   "MessageCode": "-2",
///   "MessageDescription": "INVALID/MISSING PARAMETER"
/// }
/// ```
///
class CoopPesalink {
  CoopPesalink(
      {required this.baseAccountNo,
      this.currency = 'KES',
      this.branchCode,
      this.applicationMode = ApplicationMode.test});

  final String
      baseAccountNo; // coop bank account number that initiates the transactions
  final String? branchCode;
  final String currency;

  final ApplicationMode applicationMode;

  Map<String, dynamic> transactionSource(double amount, String naration) => {
        'AccountNumber': baseAccountNo,
        'Amount': amount,
        'TransactionCurrency': currency,
        'Narration': naration
      };

  /// Implements [Pesalink](https://developer.co-opbank.co.ke/devportal/apis/e22ac032-0da6-4ff6-9ac3-e4903b18356a/overview) end point, which enables transactions from the configured account [baseAccountNo] to any bank account participating in IPSL
  /// It has a return type of [BankReponse] & the raw response can be gotten by calling [BankReponse.rawResponceBody]
  /// Sample success response;
  /// ```dart
  /// {
  ///   'MessageReference': '40ca18c6765086089a1',
  ///   'MessageDateTime': '2017-12-04T09:27:00',
  ///   'MessageCode': '0',
  ///   'MessageDescription': 'REQUEST ACCEPTED SUCCESSFULLY'
  /// }
  /// ```
  Future<BankReponse> pesaLink({
    required String referenceNumber,
    required String accountNumber,
    required String bankCode,
    required double amount,
    required String callBackUrl,
    String transactionCurrency = 'KES',
    required String transactionDescription,
    required String accessToken,
  }) async {
    Map<String, String> _header = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };

    Map<String, dynamic> _payload = {
      'MessageReference': referenceNumber,
      'CallBackUrl': callBackUrl,
      'Source': transactionSource(amount, transactionDescription),
      'Destinations': [
        {
          'ReferenceNumber': '${referenceNumber}_1',
          'AccountNumber': accountNumber,
          'BankCode': bankCode,
          'Amount': amount,
          'TransactionCurrency': transactionCurrency,
          'Narration': transactionDescription
        }
      ]
    };

    try {
      return await pesalinkProcessTransaction(
          pesaLinkUrl, _header, _payload, applicationMode);
    } catch (e) {
      rethrow;
    }
  }

  /// Implements [InterFundsTransfer(IFT)](https://developer.co-opbank.co.ke/devportal/apis/9baf4085-aac7-484c-8376-449d593cc610/overview) end point, which enables transactions from the configured account [baseAccountNo] to s co-op bank account
  /// It has a return type of [BankReponse] & the raw response can be gotten by calling [BankReponse.rawResponceBody]
  /// Sample success response;
  /// ```dart
  /// {
  ///   'MessageReference': '40ca18c6765086089a1',
  ///   'MessageDateTime': '2017-12-04T09:27:00',
  ///   'MessageCode': '0',
  ///   'MessageDescription': 'REQUEST ACCEPTED SUCCESSFULLY'
  /// }
  /// ```
  Future<BankReponse> ift({
    required String referenceNumber,
    required String accountNumber,
    required double amount,
    required String callBackUrl,
    String transactionCurrency = 'KES',
    required String transactionDescription,
    required String accessToken,
  }) async {
    Map<String, String> _header = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };

    Map<String, dynamic> _payload = {
      'MessageReference': referenceNumber,
      'CallBackUrl': callBackUrl,
      'Source': transactionSource(amount, transactionDescription),
      'Destinations': [
        {
          'ReferenceNumber': '${referenceNumber}_1',
          'AccountNumber': accountNumber,
          'Amount': amount,
          'TransactionCurrency': transactionCurrency,
          'Narration': transactionDescription
        }
      ]
    };

    try {
      return await pesalinkProcessTransaction(
          iftUrl, _header, _payload, applicationMode);
    } catch (e) {
      rethrow;
    }
  }

  /// Implements [send to Mpesa](https://developer.co-opbank.co.ke/devportal/apis/d79f70da-ce45-47d6-823b-eb99cac6b33d/overview) end point, which enables transactions from the configured account [baseAccountNo] to mpesa user(phone number)[mobileNumber]
  /// It has a return type of [BankReponse] & the raw response can be gotten by calling [BankReponse.rawResponceBody]
  /// Sample success response;
  /// ```dart
  /// {
  ///   'MessageReference': '40ca18c6765086089a1',
  ///   'MessageDateTime': '2017-12-04T09:27:00',
  ///   'MessageCode': '0',
  ///   'MessageDescription': 'REQUEST ACCEPTED SUCCESSFULLY'
  /// }
  /// ```
  Future<BankReponse> toMpesa({
    required String referenceNumber,
    required String mobileNumber,
    required double amount,
    required String callBackUrl,
    String transactionCurrency = 'KES',
    required String transactionDescription,
    required String accessToken,
  }) async {
    Map<String, String> _header = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };

    Map<String, dynamic> _payload = {
      'MessageReference': referenceNumber,
      'CallBackUrl': callBackUrl,
      'Source': transactionSource(amount, transactionDescription),
      'Destinations': [
        {
          'ReferenceNumber': '${referenceNumber}_1',
          'MobileNumber': mobileNumber,
          'Amount': amount,
          'Narration': transactionDescription
        }
      ]
    };

    try {
      return await pesalinkProcessTransaction(
          toMpesaUrl, _header, _payload, applicationMode);
    } catch (e) {
      rethrow;
    }
  }

  /// Implements [Send to Pesalink Account](https://developer.co-opbank.co.ke/devportal/apis/0e2d97e2-48f5-4e57-bd2d-e2cf4ea0e155/overview) end point, which enables transactions from the configured account [baseAccountNo] to bank account number with pesalink enabled
  /// It has a return type of [BankReponse] & the raw response can be gotten by calling [BankReponse.rawResponceBody]
  /// Sample success response;
  /// ```dart
  /// {
  ///   'MessageReference': '40ca18c6765086089a1',
  ///   'MessageDateTime': '2017-12-04T09:27:00',
  ///   'MessageCode': '0',
  ///   'MessageDescription': 'REQUEST ACCEPTED SUCCESSFULLY'
  /// }
  /// ```
  Future<BankReponse> toPesalinkAccount({
    required String referenceNumber,
    required String accountNumber,
    required String bankCode,
    required double amount,
    required String callBackUrl,
    String transactionCurrency = 'KES',
    required String transactionDescription,
    required String accessToken,
  }) async {
    Map<String, String> _header = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };

    Map<String, dynamic> _payload = {
      'MessageReference': referenceNumber,
      'CallBackUrl': callBackUrl,
      'Source': transactionSource(amount, transactionDescription),
      'Destinations': [
        {
          'ReferenceNumber': '${referenceNumber}_1',
          'AccountNumber': accountNumber,
          'BankCode': bankCode,
          'Amount': amount,
          'TransactionCurrency': transactionCurrency,
          'Narration': transactionDescription
        }
      ]
    };

    try {
      return await pesalinkProcessTransaction(
          toPesaLinkAccountUrl, _header, _payload, applicationMode);
    } catch (e) {
      rethrow;
    }
  }

  /// Implements [Send to Pesalink PhoneNo](https://developer.co-opbank.co.ke/devportal/apis/45bc8c10-1414-497a-a02e-07525743b941/overview)  end point, which enables transactions from the configured account [baseAccountNo] to user whom has connected their [phoneNumber] to bank account using pesalink
  /// It has a return type of [BankReponse] & the raw response can be gotten by calling [BankReponse.rawResponceBody]
  /// Sample success response;
  /// ```dart
  /// {
  ///   'MessageReference': '40ca18c6765086089a1',
  ///   'MessageDateTime': '2017-12-04T09:27:00',
  ///   'MessageCode': '0',
  ///   'MessageDescription': 'REQUEST ACCEPTED SUCCESSFULLY'
  /// }
  /// ```
  Future<BankReponse> toPesalinkPhoneNo({
    required String referenceNumber,
    required String phoneNumber,
    required double amount,
    required String callBackUrl,
    String transactionCurrency = 'KES',
    required String transactionDescription,
    required String accessToken,
  }) async {
    Map<String, String> _header = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };

    Map<String, dynamic> _payload = {
      'MessageReference': referenceNumber,
      'CallBackUrl': callBackUrl,
      'Source': transactionSource(amount, transactionDescription),
      'Destinations': [
        {
          'ReferenceNumber': '${referenceNumber}_1',
          'PhoneNumber': phoneNumber,
          'Amount': amount,
          'TransactionCurrency': transactionCurrency,
          'Narration': transactionDescription
        }
      ]
    };

    try {
      return await pesalinkProcessTransaction(
          toPesaLinkPhoneUrl, _header, _payload, applicationMode);
    } catch (e) {
      rethrow;
    }
  }

  // mini statement
  /// [miniStatement](https://developer.co-opbank.co.ke/devportal/apis/e9f0e561-6e54-48df-a0bd-4aa443d3bd00/overview) Fetches the [baseAccountNo] recent transactions
  /// It has a return type of [BankReponse] & the raw response can be gotten by calling [BankReponse.rawResponceBody]
  /// The list of transactions as List of [BankTransactionModel] can be gotten by calling [BankReponse.transactions]
  Future<BankReponse> miniStatement({
    required String referenceNumber,
    required String accessToken,
  }) async {
    Map<String, String> _header = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };

    Map<String, dynamic> _payload = {
      'MessageReference': referenceNumber,
      'AccountNumber': baseAccountNo,
    };

    try {
      return await pesalinkProcessTransaction(
          miniStatementUrl, _header, _payload, applicationMode);
    } catch (e) {
      rethrow;
    }
  }

  // full statement
  /// [fullStatement](https://developer.co-opbank.co.ke/devportal/apis/876fccc8-e189-47d6-b923-0174ee4c0f5a/overview) Fetches the [baseAccountNo] full statement that is between the dates passed [startDate], & [endDate]
  /// It has a return type of [BankReponse] & the raw response can be gotten by calling [BankReponse.rawResponceBody]
  /// The list of transactions as List of [BankTransactionModel] can be gotten by calling [BankReponse.transactions]
  Future<BankReponse> fullStatement({
    required String referenceNumber,
    required DateTime startDate,
    required DateTime endDate,
    required String accessToken,
  }) async {
    String _dateFormat(DateTime _date) {
      // format to yyy-mm-dd
      return '${_date.year}-${_date.month}-${_date.day}';
    }

    Map<String, String> _header = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };

    Map<String, dynamic> _payload = {
      'MessageReference': referenceNumber,
      'AccountNumber': baseAccountNo,
      'StartDate': _dateFormat(startDate),
      'EndDate': _dateFormat(endDate)
    };

    try {
      return await pesalinkProcessTransaction(
          fullStatementUrl, _header, _payload, applicationMode);
    } catch (e) {
      rethrow;
    }
  }

  // transactions
  /// [trancations](https://developer.co-opbank.co.ke/devportal/apis/6098fabb-14f6-4c4e-a669-3bc4f44d30c0/overview) Fetches the [baseAccountNo] last n transctions, where n is the number of transactions [noOfTransactions]
  /// It has a return type of [BankReponse] & the raw response can be gotten by calling [BankReponse.rawResponceBody]
  /// The list of transactions as List of [BankTransactionModel] can be gotten by calling [BankReponse.transactions]
  Future<BankReponse> trancations({
    required String referenceNumber,
    required int noOfTransactions,
    required String accessToken,
  }) async {
    Map<String, String> _header = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };

    Map<String, dynamic> _payload = {
      'MessageReference': referenceNumber,
      'AccountNumber': baseAccountNo,
      'NoOfTransactions': noOfTransactions,
    };

    try {
      return await pesalinkProcessTransaction(
          transactionsUrl, _header, _payload, applicationMode);
    } catch (e) {
      rethrow;
    }
  }

  // transaction status
  /// [transactionStatus](https://developer.co-opbank.co.ke/devportal/apis/ef1f71d1-5f2a-4f59-8ecd-e5aa85220ee7/overview) checks the status of a previous transaction with this [referenceNumber]
  Future<BankReponse> transactionStatus({
    required String referenceNumber,
    required String accessToken,
  }) async {
    Map<String, String> _header = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };

    Map<String, dynamic> _payload = {'MessageReference': referenceNumber};

    try {
      return await pesalinkProcessTransaction(
          transactionStatusUrl, _header, _payload, applicationMode);
    } catch (e) {
      rethrow;
    }
  }

  // account balance
  /// [accountBalance](https://developer.co-opbank.co.ke/devportal/apis/4b6d8953-6c52-4f54-9d5f-d1f5db6eb98c/overview) gets all balances of the [baseAccountNo]
  Future<BankReponse> accountBalance({
    required String referenceNumber,
    required String accessToken,
  }) async {
    Map<String, String> _header = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };

    Map<String, dynamic> _payload = {
      'MessageReference': referenceNumber,
      'AccountNumber': baseAccountNo,
    };

    try {
      return await pesalinkProcessTransaction(
          accountBalanceUrl, _header, _payload, applicationMode);
    } catch (e) {
      rethrow;
    }
  }

  // account validation
  /// [accountValidation](https://developer.co-opbank.co.ke/devportal/apis/11ba0662-656b-403a-a7db-00d731dba4fa/overview) validates if the given account [accountNumber] is valid
  Future<BankReponse> accountValidation({
    required String referenceNumber,
    required String accountNumber,
    required String accessToken,
  }) async {
    Map<String, String> _header = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };

    Map<String, dynamic> _payload = {
      'MessageReference': referenceNumber,
      'AccountNumber': accountNumber,
    };

    try {
      return await pesalinkProcessTransaction(
          accountValidationUrl, _header, _payload, applicationMode);
    } catch (e) {
      rethrow;
    }
  }

  // exchage rate
  /// [exchagerate](https://developer.co-opbank.co.ke/devportal/apis/b49b9cab-7fba-4eb7-93f0-968dbdce4214/overview) gets the exchange rate from one currency [fromCurrencyCode] to the other [toCurrencyCode]
  /// Sample success response
  /// ```dart
  /// {
  ///      "MessageReference": "40ca18c6765086089a1",
  ///      "MessageDateTime": "2021-06-15T15:07:35.098Z",
  ///      "MessageCode": "0",
  ///      "MessageDescription": "Success",
  ///      "FromCurrencyCode": "KES",
  ///      "ToCurrencyCode": "USD",
  ///      "RateType": "SPOT",
  ///      "Rate": 103.5,
  ///      "Tolerance": 15,
  ///      "MultiplyDivide": "D"
  /// }
  /// ```
  Future<BankReponse> exchangerate({
    required String referenceNumber,
    required String fromCurrencyCode,
    required String toCurrencyCode,
    required String accessToken,
  }) async {
    Map<String, String> _header = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };

    Map<String, dynamic> _payload = {
      'MessageReference': referenceNumber,
      'FromCurrencyCode': fromCurrencyCode,
      'ToCurrencyCode': toCurrencyCode
    };

    try {
      return await pesalinkProcessTransaction(
          exchangeRateUrl, _header, _payload, applicationMode);
    } catch (e) {
      rethrow;
    }
  }

  // urls
  String pesaLinkUrl = '/FundsTransfer/External/PesaLink/1.0.0';

  String exchangeRateUrl = '/Enquiry/ExchangeRate/1.0.0';

  String iftUrl = '/FundsTransfer/Internal/A2A/2.0.0';

  String miniStatementUrl = '/Enquiry/MiniStatement/Account/1.0.0';

  String accountBalanceUrl = '/Enquiry/AccountBalance/1.0.0';

  String fullStatementUrl = '/Enquiry/FullStatement/Account/1.0.0';

  String accountValidationUrl = '/Enquiry/Validation/Account/1.0.0';

  String transactionsUrl = '/Enquiry/AccountTransactions/1.0.0';

  String transactionStatusUrl = '/Enquiry/TransactionStatus/2.0.0';

  String toMpesaUrl = '/FundsTransfer/External/A2M/Mpesa/1.0.0';

  String toPesaLinkAccountUrl = '/FundsTransfer/External/A2A/PesaLink/1.0.0';

  String toPesaLinkPhoneUrl = '/FundsTransfer/External/A2M/PesaLink/1.0.0';
}

enum ApplicationMode { test, production }
