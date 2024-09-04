import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:next_data/core/config/app_theme.dart';
import 'package:next_data/core/models/generic_model.dart';
import 'package:next_data/pages/posts_screen/post_screen_view_model.dart';
import 'package:next_data/pages/posts_screen/widgets/empty_posts_widget.dart';
import 'package:next_data/pages/posts_screen/widgets/search_container_widget.dart';
import 'package:skeleton_animation/skeleton_animation.dart';
import 'package:stacked/stacked.dart';

class PostsScreenView extends StackedView<PostsScreenViewModel> {
  const PostsScreenView({super.key});

  @override
  PostsScreenViewModel viewModelBuilder(BuildContext context) =>
      PostsScreenViewModel();

  @override
  void onViewModelReady(PostsScreenViewModel viewModel) => viewModel.init();

  @override
  Widget builder(
      BuildContext context, PostsScreenViewModel viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: viewModel.displayErrorScreen ? whiteColor : whiteGreyColor,
      body: CustomScrollView(
        shrinkWrap: true,
        slivers: [
          _buildAppBar(viewModel),
          _buildPostList(viewModel),
        ],
      ),
    );
  }

  SliverAppBar _buildAppBar(PostsScreenViewModel viewModel) {
    return SliverAppBar(
      backgroundColor: whiteColor,
      expandedHeight: 100,
      floating: true,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 18),
          child: SearchContainer(
            onValueChanges: viewModel.onSearchValueChanges,
            searchController: viewModel.searchEditingController,
          ),
        ),
      ),
      title: const Text(
        "Browse posts",
        style: TextStyle(
          color: titleColor,
          fontWeight: FontWeight.w600,
          fontSize: 16.0,
        ),
      ),
      leadingWidth: 32.0,
      leading: Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: SvgPicture.asset(leadingIcon),
      ),
    );
  }

  SliverList _buildPostList(PostsScreenViewModel viewModel) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: viewModel.isBusy
                ? _buildSkeleton()
                : viewModel.displayErrorScreen
                ? const EmptyPostsWidget()
                : SinglePostWidget(
              post: viewModel.genericData.isEmpty
                  ? viewModel.castDataToGenericModel(
                  viewModel.isUserSearching
                      ? viewModel.searchResults[index]
                      : viewModel.posts[index])
                  : viewModel.genericData[index],
              onTapDetails: () => viewModel.onTapDetails(index),
            ),
          );
        },
        childCount: viewModel.isBusy
            ? viewModel.randomNumber
            : viewModel.displayErrorScreen
            ? 1
            : viewModel.isUserSearching
            ? viewModel.searchResults.length
            : viewModel.posts.length,
      ),
    );
  }
}

class SinglePostWidget extends StatelessWidget {
  final GenericModel post;
  final VoidCallback onTapDetails;

  const SinglePostWidget({
    required this.post,
    required this.onTapDetails,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          Text(
            post.postTitle,
            style: const TextStyle(
              fontSize: 10.0,
              fontWeight: FontWeight.w500,
              color: postTitleColor,
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            post.postBody,
            style: const TextStyle(
              fontSize: 10.0,
              fontWeight: FontWeight.w400,
              color: postBodyColor,
            ),
          ),
          const SizedBox(height: 4.0),
          _buildPostInfo(),
          DetailsButtonWidget(onPressed: onTapDetails),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, bottom: 2.0),
      child: Row(
        children: [
          SvgPicture.asset(userIcon),
          const SizedBox(width: 8.0),
          Text(
            post.userName,
            style: const TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w600,
              color: lightBlueColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPostInfo() {
    return Row(
      children: [
        SvgPicture.asset(
          postsIcon,
          height: 11.0,
          width: 9.0,
          color: unselectedNaveBarItemColor,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 2.0),
          child: Text(
            "Post ID : ${post.postId}",
            style: const TextStyle(
              color: unselectedNaveBarItemColor,
              fontSize: 10.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

class DetailsButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;

  const DetailsButtonWidget({
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: detailButtonColor.withOpacity(0.1),
          border: Border.all(color: detailButtonColor.withOpacity(0.1)),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: const Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0),
            child: Text(
              'Detail',
              style: TextStyle(
                color: detailButtonTitleColor,
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildSkeleton() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 12.0, bottom: 2.0),
          child: Row(
            children: [
              Skeleton(
                width: 24.0,
                height: 24.0,
                borderRadius: BorderRadius.circular(12.0),
              ),
              const SizedBox(width: 8.0),
              Skeleton(
                width: 100.0,
                height: 14.0,
                borderRadius: BorderRadius.circular(8.0),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4.0),
        Skeleton(
          width: double.infinity,
          height: 10.0,
          borderRadius: BorderRadius.circular(8.0),
        ),
        const SizedBox(height: 4.0),
        Skeleton(
          width: double.infinity,
          height: 10.0,
          borderRadius: BorderRadius.circular(8.0),
        ),
        const SizedBox(height: 8.0),
        Row(
          children: [
            Skeleton(
              width: 11.0,
              height: 11.0,
              borderRadius: BorderRadius.circular(2.0),
            ),
            const SizedBox(width: 8.0),
            Skeleton(
              width: 100.0,
              height: 10.0,
              borderRadius: BorderRadius.circular(8.0),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Skeleton(
          width: 80.0,
          height: 30.0,
          borderRadius: BorderRadius.circular(8.0),
        ),
      ],
    ),
  );
}
