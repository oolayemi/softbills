import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:encrypt/encrypt.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:local_auth/local_auth.dart';
import 'package:encrypt/encrypt.dart' as prefix0;
import 'package:no_name/app/locator.dart';
import 'package:no_name/core/models/currency_rates.dart';
import 'package:no_name/core/models/nok_response.dart';
import 'package:no_name/core/models/virtual_account_response.dart';
import 'package:no_name/core/models/wallet_response.dart';
import 'package:no_name/core/services/utility_storage_service.dart';
import 'package:observable_ish/value/value.dart';
import 'package:stacked/stacked.dart';
import 'package:crypto/crypto.dart';

import '../models/airtime_beneficiaries.dart';
import '../models/api_response.dart';
import '../models/data_beneficiaries.dart';
import '../models/profile_response.dart';
import '../models/transaction_history_data.dart';
import '../utils/tools.dart';

class AuthService with ReactiveServiceMixin {
  final StorageService _storageService = locator<StorageService>();

  final RxValue<ProfileData?> _profileResponse = RxValue<ProfileData?>(null);

  ProfileData? get profileResponse => _profileResponse.value;

  final RxValue<NokData?> _nokResponse = RxValue<NokData?>(null);

  NokData? get nokResponse => _nokResponse.value;

  final RxValue<WalletData?> _walletResponse = RxValue<WalletData?>(null);

  WalletData? get walletResponse => _walletResponse.value;

  final RxValue<List<Rates>?> _ratesList = RxValue<List<Rates>?>(null);

  List<Rates>? get ratesList => _ratesList.value;

  final RxValue<List<VirtualAccountData>?> _virtualAccountResponse =
      RxValue<List<VirtualAccountData>?>(null);

  List<VirtualAccountData>? get virtualAccountData =>
      _virtualAccountResponse.value;

  bool _isBiometricsAvailable = false;

  bool get isBiometricsAvailable => _isBiometricsAvailable;

  var localAuth = LocalAuthentication();

  final List<BiometricType> _biometricOptions = [];

  List<BiometricType> get biometricOptions => _biometricOptions;

  final RxValue<List<AirtimeBeneficiary>?> _airtimeBeneficiaries =
      RxValue<List<AirtimeBeneficiary>?>([]);

  List<AirtimeBeneficiary>? get airtimeBeneficiaries =>
      _airtimeBeneficiaries.value;

  final RxValue<List<DataBeneficiary>?> _dataBeneficiaries =
      RxValue<List<DataBeneficiary>?>([]);

  List<DataBeneficiary>? get dataBeneficiaries => _dataBeneficiaries.value;

  final RxValue<TransactionHistoryResponse?> _walletTransactionResponse =
      RxValue<TransactionHistoryResponse?>(null);

  TransactionHistoryResponse? get walletTransactionResponse =>
      _walletTransactionResponse.value;

  final RxValue<List<DataResponse>?> _walletTransactions =
      RxValue<List<DataResponse>?>([]);

  List<DataResponse>? get walletTransactions => _walletTransactions.value;

  // final dio = Dio();

  final iv = IV.fromLength(16);
  late FirebaseMessaging messaging;

  AuthService() {
    listenToReactiveValues([
      _profileResponse,
      profileResponse,
      _nokResponse,
      nokResponse,
      _walletResponse,
      walletResponse,
      _virtualAccountResponse,
      virtualAccountData,
      _walletTransactionResponse,
      walletTransactionResponse,
      _walletTransactions,
      walletTransactions
    ]);
  }

  static Encrypter crypt() {
    final appKey = env('APP_KEY')!;
    final key = prefix0.Key.fromBase64(appKey);
    return Encrypter(prefix0.AES(key));
  }

  dynamic encryptData(dynamic data) {
    return crypt().encrypt(data, iv: iv).base64;
  }

  dynamic decryptData(dynamic data) {
    return crypt().decrypt64(data, iv: iv);
  }

  void clearProfile() {
    _profileResponse.value = null;
  }

  Future<void> setBiometricStatus() async {
    var availableBiometrics = await localAuth.getAvailableBiometrics();

    _isBiometricsAvailable = await localAuth.canCheckBiometrics &&
        await localAuth.isDeviceSupported() &&
        availableBiometrics.isNotEmpty &&
        _storageService.getBool('biometric') == true;
    return;
  }

  Future<ApiResponse> getProfile() async {
    ApiResponse response = ApiResponse(showMessage: false);

    try {
      await dio().get('/user/profile').then((value) async {
        print("GET PROFILE RESPONSE::::");

        int? statusCode = value.statusCode;
        Map<String, dynamic> responseData = value.data!;

        if (statusCode == 200) {
          if (responseData['status'] == 'success') {
            ProfileResponse temp = ProfileResponse.fromJson(responseData);
            _profileResponse.value = temp.data;
            StorageService()
                .addString('transactionPin', temp.data!.transactionPin);
            response = ApiResponse(showMessage: false, message: null);
            notifyListeners();
            return;
          } else {
            response = ApiResponse(
                showMessage: true, message: responseData['message']);
            return;
          }
        } else {
          response =
              ApiResponse(showMessage: true, message: responseData['message']);
        }
      });
    } on DioError catch (e) {
      print(e.response!.data);
      response =
          ApiResponse(showMessage: true, message: 'Error Processing Request');
    }
    return response;
  }

  Future<ApiResponse> getNextOfKin() async {
    ApiResponse response = ApiResponse(showMessage: false);

    try {
      await dio().get('/user/nok').then((value) async {
        print("GET NOK RESPONSE::::");

        int? statusCode = value.statusCode;
        Map<String, dynamic> responseData = value.data!;

        if (statusCode == 200) {
          if (responseData['status'] == 'success') {
            NokResponse temp = NokResponse.fromJson(responseData);
            _nokResponse.value = temp.data;
            response = ApiResponse(showMessage: false, message: null);
            notifyListeners();
            return;
          } else {
            response = ApiResponse(
                showMessage: true, message: responseData['message']);
            return;
          }
        } else {
          response =
              ApiResponse(showMessage: true, message: responseData['message']);
        }
      });
    } on DioError catch (e) {
      print(e.response!.data);
      response =
          ApiResponse(showMessage: true, message: 'Error Processing Request');
    }
    return response;
  }

  Future<ApiResponse> getCurrentRate() async {
    ApiResponse response = ApiResponse(showMessage: false);

    try {
      await dio().get('/rates/get').then((value) async {
        print("GET RATES RESPONSE::::");

        int? statusCode = value.statusCode;
        Map<String, dynamic> responseData = value.data!;

        if (statusCode == 200) {
          if (responseData['status'] == 'success') {
            RatesResponse temp = RatesResponse.fromJson(responseData);
            _ratesList.value = temp.rates;
            response = ApiResponse(showMessage: false, message: null);
            notifyListeners();
            return;
          } else {
            response = ApiResponse(
                showMessage: true, message: responseData['message']);
            return;
          }
        } else {
          response =
              ApiResponse(showMessage: true, message: responseData['message']);
        }
      });
    } on DioError catch (e) {
      print(e.response!.data);
      response =
          ApiResponse(showMessage: true, message: 'Error Processing Request');
    }
    return response;
  }

  Future<ApiResponse> getWalletDetails() async {
    ApiResponse response = ApiResponse(showMessage: false);

    try {
      await dio().get('/user/wallet').then((value) async {
        print("GET WALLET RESPONSE::::");

        int? statusCode = value.statusCode;
        Map<String, dynamic> responseData = value.data!;

        if (statusCode == 200) {
          if (responseData['status'] == 'success') {
            WalletResponse temp = WalletResponse.fromJson(responseData);
            _walletResponse.value = temp.data;
            response = ApiResponse(showMessage: false, message: null);
            notifyListeners();
            return;
          } else {
            response = ApiResponse(
                showMessage: true, message: responseData['message']);
            return;
          }
        } else {
          response =
              ApiResponse(showMessage: true, message: responseData['message']);
        }
      });
    } on DioError catch (e) {
      print(e.response!.data);
      response =
          ApiResponse(showMessage: true, message: 'Error Processing Request');
    }
    return response;
  }

  Future<ApiResponse> getVirtualAccounts() async {
    ApiResponse response = ApiResponse(showMessage: false);

    try {
      await dio().get('/user/virtual-accounts').then((value) async {
        print("GET VIRTUAL ACCOUNTS RESPONSE::::");

        int? statusCode = value.statusCode;
        Map<String, dynamic> responseData = value.data!;

        if (statusCode == 200) {
          if (responseData['status'] == 'success') {
            VirtualAccountResponse temp =
                VirtualAccountResponse.fromJson(responseData);
            _virtualAccountResponse.value = temp.data;
            response = ApiResponse(showMessage: false, message: null);
            notifyListeners();
            return;
          } else {
            response = ApiResponse(
                showMessage: true, message: responseData['message']);
            return;
          }
        } else {
          response =
              ApiResponse(showMessage: true, message: responseData['message']);
        }
      });
    } on DioError catch (e) {
      print(e.response!.data);
      response =
          ApiResponse(showMessage: true, message: 'Error Processing Request');
    }
    return response;
  }

  Future<ApiResponse> getAirtimeBeneficiaries() async {
    ApiResponse apiResponse = ApiResponse(showMessage: false);

    try {
      final response = await dio().get('/airtime/beneficiaries');
      print("GET AIRTIME BENEFICIARY RESPONSE::::");

      int? statusCode = response.statusCode;
      print('statusCode: $statusCode');

      String? success = jsonDecode(response.toString())['status'];
      Map<String, dynamic> json = jsonDecode(response.toString());

      if (statusCode == 200) {
        if (success == 'success') {
          AirtimeBeneficiaryResponse temp =
              AirtimeBeneficiaryResponse.fromJson(json);
          _airtimeBeneficiaries.value = temp.data;
          apiResponse = ApiResponse(showMessage: false, message: null);
          return apiResponse;
        } else {
          apiResponse =
              ApiResponse(showMessage: true, message: json['message']);
          return apiResponse;
        }
      } else {
        apiResponse = ApiResponse(showMessage: true, message: json['message']);
        return apiResponse;
      }
    } on DioError catch (e) {
      print(e.response!.data);
      apiResponse =
          ApiResponse(showMessage: true, message: 'Error Processing Request');
    }
    return apiResponse;
  }

  Future<ApiResponse> getDataBeneficiaries() async {
    ApiResponse apiResponse = ApiResponse(showMessage: false);

    try {
      final response = await dio().get('/data/beneficiaries');
      print("GET DATA BENEFICIARY RESPONSE::::");

      int? statusCode = response.statusCode;
      print('statusCode: $statusCode');

      String? success = jsonDecode(response.toString())['status'];
      Map<String, dynamic> json = jsonDecode(response.toString());

      if (statusCode == 200) {
        if (success == 'success') {
          DataBeneficiaryResponse temp = DataBeneficiaryResponse.fromJson(json);
          _dataBeneficiaries.value = temp.data;
          apiResponse = ApiResponse(showMessage: false, message: null);
          return apiResponse;
        } else {
          apiResponse =
              ApiResponse(showMessage: true, message: json['message']);
          return apiResponse;
        }
      } else {
        apiResponse = ApiResponse(showMessage: true, message: json['message']);
        return apiResponse;
      }
    } on DioError catch (e) {
      print(e.response!.data);
      apiResponse =
          ApiResponse(showMessage: true, message: 'Error Processing Request');
    }
    return apiResponse;
  }

  Future<ApiResponse> getWalletTransactions({int? page}) async {
    ApiResponse response = ApiResponse(showMessage: false);

    try {
      final response2 = await dio().get('/user/wallet-transactions?page=$page');


      Map<String, dynamic> json = jsonDecode(response2.toString());

      TransactionHistoryResponse temp =
          TransactionHistoryResponse.fromJson(json);
      _walletTransactionResponse.value = temp;
      _walletTransactions.value = page == 1
          ? temp.data!.data
          : [
              ..._walletTransactions.value!,
              ...temp.data!.data!
            ];
      notifyListeners();

      response =
          ApiResponse(showMessage: false, message: 'Wallet Trans gotten');

      print('Auth user transactions gotten::: ');
    } on DioError catch (e) {
      print('Request error: ${e.response}');
      response = ApiResponse(
          showMessage: true, message: 'Error Processing Request, Try Again');
    }

    return response;
  }
}

Future<bool> checkPin(String pin) async {
  bool isPinCorrect;
  String? userPin = StorageService().getString('hashedPin');
  String hashedPin = sha1.convert(utf8.encode(pin)).toString();

  if (userPin == null || hashedPin != userPin) {
    isPinCorrect = false;
  } else {
    isPinCorrect = true;
  }

  await Future.delayed(const Duration(milliseconds: 500));
  return isPinCorrect;
}
