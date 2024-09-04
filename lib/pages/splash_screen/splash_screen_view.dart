import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:next_data/core/config/app_theme.dart';
import 'package:next_data/pages/splash_screen/splash_screen_view_model.dart';
import 'package:stacked/stacked.dart';

class SplashScreen extends  StackedView<SplashScreenViewModel> {

  @override
  void onViewModelReady(SplashScreenViewModel viewModel) {
    super.onViewModelReady(viewModel);
    viewModel.init();
  }

  @override
  SplashScreenViewModel viewModelBuilder(BuildContext context) {
    return SplashScreenViewModel();
  }

  @override
  Widget builder(BuildContext context, SplashScreenViewModel viewModel, Widget? child) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  lightBlueColor, // #1864D3
                  blueColor, // #0C4AA6
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 1000),
            curve: Curves.easeInOut,
            top: viewModel.startAnimation ? MediaQuery.of(context).size.height / 2 - 150 : MediaQuery.of(context).size.height / 2,
            child: TweenAnimationBuilder(
              tween: Tween<double>(begin: 1.0, end: viewModel.startAnimation ? 0.8 : 1.0),
              duration: Duration(milliseconds: 1000),
              curve: Curves.easeInOut,
              builder: (context, double scale, child) {
                return Transform.scale(
                  scale: scale,
                  child: child,
                );
              },
              child: SvgPicture.asset(
                appIconLight,
                width: 96.0,
                height: 96.0,
              ),
            ),
          ),
          AnimatedOpacity(
            opacity: viewModel.startAnimation ? 1.0 : 0.0,
            duration: Duration(milliseconds: 2000),
            curve: Curves.easeInOut,
            child: Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                color: Colors.white,
                backgroundColor: Colors.white.withOpacity(0.5),
              ),
            ),
          ),
        ],
      ),
    );  }




}