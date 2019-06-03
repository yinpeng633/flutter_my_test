import 'package:equatable/equatable.dart';
import 'package:flutter_app_1/demo/infiniteListDemo/Post.dart';



abstract class PostState extends Equatable {
  PostState([List pros = const []]) : super(pros);
}


class PostUninitialized extends PostState {

  @override
  String toString() {
    return 'PostUninitialized{}';
  }
}

class PostError extends PostState {

  @override
  String toString() {
    return 'PostError{}';
  }
}

class PostLoaded extends PostState {

  final List<Post> posts;
  final bool hasReachedMax;


  PostLoaded({this.posts, this.hasReachedMax}) : super([posts, hasReachedMax]);
//  PostLoaded({List<Post> posts, bool hasReachedMax}) {
//    this.posts = posts;
//    this.hasReachedMax = hasReachedMax;
//  }


  @override
  String toString() {
    return 'PostLoaded{}';
  }


  copyWith({
    List<Post> posts,
    bool hasReachedMax,
  }) {
    return PostLoaded(
      posts: posts ?? this.posts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax
    );
  }
}




