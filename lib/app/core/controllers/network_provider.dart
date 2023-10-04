import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

import 'auth/auth_store.dart';

enum StatusNetwork { Uninitialized, TRUE, FALSE, LOADING }

class NetworkProvider {
  StreamSubscription<dynamic>? _subscription;

  StreamSubscription<dynamic>? get subscription => _subscription;
  final Dio dio = Dio();
  final AuthStore authStore;
  CancelToken? cancelToken;
  ConnectivityResult? r;

  NetworkProvider(this.authStore) {
    _invokeNetworkStatusListen();
  }

  void _invokeNetworkStatusListen() async {
    _subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      initCheck();
    });
  }

  void disposeStreams() {
    _subscription?.cancel();
  }

  startLoading() {
    authStore.setStatusNetwork(StatusNetwork.LOADING);
  }

  Future<bool> checkConnection() async {
    try {
      dio.options = BaseOptions(
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      );
      cancelToken = CancelToken();
      await dio.get("https://google.com.br", cancelToken: cancelToken);
      if (authStore.statusNetwork != StatusNetwork.TRUE) {
        authStore.setStatusNetwork(StatusNetwork.TRUE);
      }
    } on DioError catch (e) {
      if (e.response != null) {
        if (authStore.statusNetwork != StatusNetwork.TRUE) {
          authStore.setStatusNetwork(StatusNetwork.TRUE);
        }
      } else {
        if (authStore.statusNetwork != StatusNetwork.FALSE) {
          authStore.setStatusNetwork(StatusNetwork.FALSE);
        }
      }
    } catch (e) {
      authStore.setStatusNetwork(StatusNetwork.FALSE);
    }

    return true;
  }

  Future runTimeout() async {
    return checkConnection();
  }

  initCheck() async {
    try {
      if (authStore.statusNetwork == StatusNetwork.LOADING) return;
      startLoading();
      var result = await Connectivity()
          .checkConnectivity()
          .timeout(const Duration(seconds: 15));
      r = result;
      if (result != ConnectivityResult.none) {
        await runTimeout();
      } else {
        Future.delayed(const Duration(seconds: 1), () async {
          authStore.setStatusNetwork(StatusNetwork.FALSE);
        });
      }
    } catch (e) {
      print(e.toString());
      Future.delayed(const Duration(seconds: 1), () async {
        authStore.setStatusNetwork(StatusNetwork.FALSE);
      });
    }
  }

  dispose() {
    authStore.setStatusNetwork(StatusNetwork.FALSE);
    cancelToken?.cancel();
  }
}
