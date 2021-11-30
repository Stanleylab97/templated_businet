import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

enum PostType { POST_TEXT, POST_WITH_PHOTO, POST_WITH_VIDEO }

class Post {
  String author;
  String authorProfileUrl;
  String publishedAt;
  int loves;
  PostType postType;

  Post({
    this.author,
    this.authorProfileUrl,
    this.loves,
    this.publishedAt,
    this.postType,
  });

  /* factory fromFirestore() {
    return null;
  } */
}

class TextPost extends Post {
  String content;

  TextPost({this.content}) : super();
}

class PostWithPhoto extends Post {
  String legend, photoUrl;
  PostWithPhoto(
      {author,
      authorProfileUrl,
      loves,
      publishedAt,
      postType,
      this.legend,
      this.photoUrl})
      : super(
            author: author,
            authorProfileUrl: authorProfileUrl,
            loves: loves,
            publishedAt: publishedAt,
            postType: postType);

  factory PostWithPhoto.fromFirestore(DocumentSnapshot snapshot) {
    var d = snapshot.data();
    return PostWithPhoto(
      author: d['author'],
      authorProfileUrl: d['authorProfileUrl'],
      loves: 0,
      publishedAt: d['publishedAt'],
      postType: d['postType'],
      legend: d['legend'],
      photoUrl: d['photoUrl'],
    );
  }
}

class PostWithVideo extends Post {
  String description, thumbnailImagelUrl, youtubeVideoUrl, videoID;
  PostWithVideo(
      {author,
      authorProfileUrl,
      loves,
      publishedAt,
      postType,
      this.description,
      this.thumbnailImagelUrl,
      this.youtubeVideoUrl,
      this.videoID})
      : super(
            author: author,
            authorProfileUrl: authorProfileUrl,
            loves: loves,
            publishedAt: publishedAt,
            postType: postType);

  factory PostWithVideo.fromFirestore(DocumentSnapshot snapshot) {
    var d = snapshot.data();
    return PostWithVideo(
      author: d['author'],
      authorProfileUrl: d['authorProfileUrl'],
      loves: 0,
      publishedAt: d['publishedAt'],
      postType: d['postType'],
      description: d['description'],
      thumbnailImagelUrl: d['image url'],
      youtubeVideoUrl: d['youtube url'],
      videoID:
          YoutubePlayer.convertUrlToId(d['youtube url'], trimWhitespaces: true),
    );
  }
}
