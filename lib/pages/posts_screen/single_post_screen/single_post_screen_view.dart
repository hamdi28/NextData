import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:next_data/core/config/app_theme.dart';
import 'package:next_data/core/models/post_model.dart';
import 'package:next_data/core/models/user_model.dart';
import 'package:next_data/pages/posts_screen/single_post_screen/widgets/horizenatl_divider.dart';

class SinglePostView extends StatelessWidget {
  Post post;
  User user;
   SinglePostView({required this.post, required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: Text("Post details",style: TextStyle(
          color: titleColor,
          fontWeight: FontWeight.w600,
          fontSize: 16.0,
        ),),

      ),
      body: Container(
        padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
        decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12.0,bottom: 13.0),
              child: Row(
                children: [
                  SvgPicture.asset(userIcon),
                  SizedBox(
                    width: 8.0,
                  ),
                  Text(
                    user.name,
                    style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                        color: lightBlueColor),
                  )
                ],
              ),
            ),
            const Text(
              "Title :",
              style: TextStyle(
                  color: textColor, fontSize: 14, fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 4.0,
            ),
            Text(
              post.title,
              style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w400,
                  color: textColor),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0,bottom: 8.0),
              child: HorizentaleDivider(),
            ),
            const Text(
              "body :",
              style: TextStyle(
                  color: textColor, fontSize: 14, fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 4.0,
            ),
            Text(
              post.body,
              style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w400,
                  color: textColor),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: HorizentaleDivider(),
            ),
            Row(
              children: [
                SvgPicture.asset(
                  postsIcon,
                  height: 11.0,
                  width: 9.0,
                  color: unselectedNaveBarItemColor,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0,bottom: 8.0,left: 2.0),
                  child: Text(
                    "Post ID : ${post.id}",
                    style: TextStyle(
                        color: unselectedNaveBarItemColor,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Icon(Icons.person,size: 11,color:unselectedNaveBarItemColor ,),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0,bottom: 8.0,left: 2.0),
                  child: Text(
                    "User ID : ${user.id}",
                    style: TextStyle(
                        color: unselectedNaveBarItemColor,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
