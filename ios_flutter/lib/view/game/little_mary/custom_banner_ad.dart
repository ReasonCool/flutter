import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/material.dart';

class CustomBannerAd extends StatefulWidget {
  final double width;
  final double height;

  const CustomBannerAd({
    required this.width,
    required this.height,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomBannerAd> createState() => _CustomBannerAdState();
}

class _CustomBannerAdState extends State<CustomBannerAd> {
  BannerAd? _bannerAd;

  @override
  void initState() {
    super.initState();
    _loadBanner();
  }

  void _loadBanner() {
    _bannerAd = BannerAd(
      size: AdSize(
        width: widget.width.toInt(),
        height: widget.height.toInt(),
      ),
      adUnitId: 'ca-app-pub-3940256099942544/6300978111', // 測試ID
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) => print('廣告加載成功'),
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          print('廣告加載失敗: $error');
        },
      ),
    )..load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: _bannerAd != null 
          ? AdWidget(ad: _bannerAd!) 
          : Container(),
    );
  }
}