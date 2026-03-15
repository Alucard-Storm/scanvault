import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdService {
  static final AdService _instance = AdService._internal();

  factory AdService() {
    return _instance;
  }

  AdService._internal();

  final Completer<void> _initCompleter = Completer<void>();
  Future<void> get ready => _initCompleter.future;

  Future<void> initialize() async {
    if (_initCompleter.isCompleted) return;
    await MobileAds.instance.initialize();
    _initCompleter.complete();
  }

  String get nativeAdUnitId {
    if (Platform.isAndroid) {
      if (kDebugMode) {
        return 'ca-app-pub-3940256099942544/2247696110'; // Test ID
      } else {
        return 'ca-app-pub-2538803092410782/7829243615'; // Real ID
      }
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  NativeAd loadNativeAd({
    required Function(Ad ad) onAdLoaded,
    required Function(Ad ad, LoadAdError error) onAdFailedToLoad,
  }) {
    return NativeAd(
      adUnitId: nativeAdUnitId,
      factoryId: 'listTile', // Ensure this matches the factory ID in native platform code if custom, or use default template
      request: const AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: onAdLoaded,
        onAdFailedToLoad: onAdFailedToLoad,
      ),
      nativeTemplateStyle: NativeTemplateStyle(
        templateType: TemplateType.small,
        mainBackgroundColor: Colors.white,
        cornerRadius: 10.0,
        callToActionTextStyle: NativeTemplateTextStyle(
            textColor: Colors.white,
            backgroundColor: Colors.blueAccent,
            style: NativeTemplateFontStyle.bold,
            size: 16.0),
        primaryTextStyle: NativeTemplateTextStyle(
            textColor: Colors.black,
            backgroundColor: Colors.transparent,
            style: NativeTemplateFontStyle.bold,
            size: 16.0),
        secondaryTextStyle: NativeTemplateTextStyle(
            textColor: Colors.black,
            backgroundColor: Colors.transparent,
            style: NativeTemplateFontStyle.bold,
            size: 14.0),
        tertiaryTextStyle: NativeTemplateTextStyle(
            textColor: Colors.blue,
            backgroundColor: Colors.transparent,
            style: NativeTemplateFontStyle.normal,
            size: 14.0),
      ),
    );
  }
}
