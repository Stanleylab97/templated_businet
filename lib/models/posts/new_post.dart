class NewPost {
  final String path;
  final String name;

  const NewPost({this.path, this.name});
}

const newPostItems = <NewPost>[
  NewPost(name: 'Image', path: 'assets/images/linkedin/icons/image.svg'),
  NewPost(name: 'video', path: 'assets/images/linkedin/icons/film.svg'),
  NewPost(name: 'File', path: 'assets/images/linkedin/icons/file.svg'),
  NewPost(name: 'Article', path: 'assets/images/linkedin/icons/article.svg'),
];