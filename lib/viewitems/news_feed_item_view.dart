import 'package:flutter/material.dart';
import 'package:social_media_app/data/vos/news_feed_vo.dart';
import 'package:social_media_app/resources/dimens.dart';
import 'package:social_media_app/resources/images.dart';

class NewsFeedItemView extends StatelessWidget {
  final NewsFeedVO newsfeed;
  const NewsFeedItemView({Key? key, required this.newsfeed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            ProfileImageView(
              userProfile: newsfeed.profilePicture,
            ),
            const SizedBox(
              width: MARGIN_MEDIUM_2,
            ),
            NameLocationAndTimeAgoView(
              userName: newsfeed.userName,
            ),
            const Spacer(),
            MoreButtonView(),
          ],
        ),
        const SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        PostImageView(
          postImage: newsfeed.postImage,
        ),
        const SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        PostDescriptionView(
          postDescription: newsfeed.description,
        ),
        const SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        Row(
          children: const [
            Text(
              "See Comments",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            Spacer(),
            Icon(
              Icons.mode_comment_outlined,
              color: Colors.grey,
            ),
            SizedBox(
              width: MARGIN_MEDIUM,
            ),
            Icon(
              Icons.favorite_border,
              color: Colors.grey,
            )
          ],
        )
      ],
    );
  }
}

class PostDescriptionView extends StatelessWidget {
  final String? postDescription;
  const PostDescriptionView({Key? key, required this.postDescription})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      postDescription ?? "",
      // "You're bound to find the perfect beach caption to complement the stunning landscapes, golden hour selfies, and silly group photos filling your camera roll. Joke lovers will scream \"shell yeah!\"",
      style: const TextStyle(
        fontSize: TEXT_REGULAR,
        color: Colors.black,
      ),
    );
  }
}

class PostImageView extends StatelessWidget {
  final String? postImage;
  const PostImageView({Key? key, required this.postImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(MARGIN_CARD_MEDIUM_2),
      child: FadeInImage(
        height: 200,
        width: double.infinity,
        placeholder: const NetworkImage(
          NETWORK_IMAGE_POST_PLACEHOLDER,
        ),
        image: NetworkImage(
          postImage != null
              ? postImage!
              : "https://images.unsplash.com/photo-1591266360949-c54e3296de4c?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8c2VhJTIwdmlld3xlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&w=1000&q=80",
        ),
        fit: BoxFit.fill,
      ),
    );
  }
}

class MoreButtonView extends StatelessWidget {
  const MoreButtonView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: const Icon(
        Icons.more_vert,
        color: Colors.grey,
      ),
    );
  }
}

class ProfileImageView extends StatelessWidget {
  final String? userProfile;
  const ProfileImageView({Key? key, required this.userProfile})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage: NetworkImage(
        userProfile != null
            ? userProfile!
            : "https://www.whatsappprofiledpimages.com/wp-content/uploads/2021/08/Profile-Photo-Wallpaper.jpg",
      ),
      radius: MARGIN_LARGE,
    );
  }
}

class NameLocationAndTimeAgoView extends StatelessWidget {
  final String? userName;
  const NameLocationAndTimeAgoView({Key? key, required this.userName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              userName ?? "",
              style: const TextStyle(
                fontSize: TEXT_REGULAR_2X,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              width: MARGIN_SMALL,
            ),
            Text(
              "- 2 hours ago",
              style: TextStyle(
                fontSize: TEXT_SMALL,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: MARGIN_MEDIUM,
        ),
        const Text(
          "Paris",
          style: TextStyle(
            fontSize: TEXT_SMALL,
            color: Colors.grey,
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
