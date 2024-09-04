import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:next_data/core/config/app_theme.dart';
import 'package:next_data/core/config/enums.dart';
import 'package:next_data/pages/home_screen/home_screen_view_model.dart';
import 'package:next_data/pages/posts_screen/posts_screen_view.dart';
import 'package:stacked/stacked.dart';

class HomeScreen extends StackedView<HomeScreenViewModel> {
  const HomeScreen({super.key});

  @override
  void onViewModelReady(HomeScreenViewModel viewModel) => viewModel.init();

  @override
  HomeScreenViewModel viewModelBuilder(BuildContext context) {
    return HomeScreenViewModel();
  }

  @override
  Widget builder(
      BuildContext context, HomeScreenViewModel viewModel, Widget? child) {
    return Scaffold(
        backgroundColor: whiteGreyColor,
        body: PageTransitionSwitcher(
          duration: const Duration(milliseconds: 300),
          reverse: false,
          transitionBuilder: (
            Widget child,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) {
            return SharedAxisTransition(
              child: child,
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.horizontal,
            );
          },
          child: getViewForIndex(viewModel.currentIndex),
        ),
        bottomNavigationBar: Container(
            padding: EdgeInsets.symmetric(horizontal: 37),
            height: 70.0,
            decoration: BoxDecoration(
              color: Colors.white, // Background color of the container
              boxShadow: [
                BoxShadow(
                  color: blackColor.withOpacity(0.2),
                  // Shadow color with 20% opacity
                  offset: Offset(0, 0),
                  // X and Y offsets (0, 0)
                  blurRadius: 5,
                  // Blur radius
                  spreadRadius: 0, // Spread radius
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                InkWell(
                    onTap: () => viewModel.setIndex(0),
                    child: NavigationBarItemWidget(
                      itemLabel: 'Home',
                      itemIcon: homeIcon,
                      selected: viewModel.currentIndex == HomeItems.Home.index,
                    )),
                InkWell(
                    onTap: () => viewModel.setIndex(1),
                    child: NavigationBarItemWidget(
                      itemLabel: 'Posts',
                      itemIcon: postsIcon,
                      selected: viewModel.currentIndex == HomeItems.Posts.index,

                    )),
                InkWell(
                    onTap: () => viewModel.setIndex(2),
                    child: NavigationBarItemWidget(
                      itemLabel: 'Explore',
                      itemIcon: exploreIcon,
                      selected: viewModel.currentIndex == HomeItems.Explore.index,

                    )),
                InkWell(
                    onTap: () => viewModel.setIndex(3),
                    child: NavigationBarItemWidget(
                      itemLabel: 'Account',
                      itemIcon: accountIcon,
                      selected: viewModel.currentIndex == HomeItems.Account.index,

                    )),
              ],
            ) // Your child widget here
            ));
  }
}

class NavigationBarItemWidget extends StatelessWidget {
  String itemLabel;
  String itemIcon;
  bool selected;

  NavigationBarItemWidget(
      {required this.itemLabel, required this.itemIcon,this.selected = false, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(itemIcon,color: selected ? blueColor : unselectedNaveBarItemColor,),
        SizedBox(
          height: 3.0,
        ),
        Text(
          itemLabel,
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: naveBarItemColor),
        )
      ],
    );
  }
}

Widget getViewForIndex(
  int index,
) {
  switch (index) {
    case 1:
      return PostsScreenView();
    case 0:
    case 2:
    case 3:
      return Container(
        height: double.infinity,
        width: double.infinity,
        child: Center(child: Text(HomeItems.fromInt(index).name)),
      );
    default:
      return Container(
        color: Colors.green[index * 100],
        child: Center(child: Text('$index')),
      );
  }
}
