class PostDetailWrapper {
  final String postId;
  final bool isMyPost;

  const PostDetailWrapper({
    required this.postId,
    this.isMyPost = false,
  });
}
