import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_app_1/demo/infiniteListDemo/Post.dart';
import 'package:flutter_app_1/demo/infiniteListDemo/PostEvent.dart';
import 'package:flutter_app_1/demo/infiniteListDemo/PostState.dart';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final http.Client httpClient;

  PostBloc({@required this.httpClient});

  @override
  PostState get initialState => PostUninitialized();

  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {
    if (event is Fetch && !_hasReachedMax(currentState)) {
      try {
        // 当最开始时
        if (currentState is PostUninitialized) {
          final posts = await _fetchPosts(0, 20);
          yield PostLoaded(posts: posts, hasReachedMax: false);
          // TODO 这里有点问题，你咋知道肯定有第二页数据呢
          return;
        }

        // 翻页时
        if (currentState is PostLoaded) {
          final posts =
              await _fetchPosts((currentState as PostLoaded).posts.length, 20);
          yield posts.isEmpty
              ? (currentState as PostLoaded).copyWith(hasReachedMax: true)
              : PostLoaded(
                  posts: (currentState as PostLoaded).posts + posts,
                  hasReachedMax: false,
                );
        }
      } catch (_) {
        yield PostError();
      }
    }
  }

//  @override
//  Stream<PostEvent> transform(Stream<PostEvent> events) {
//    return super.transform((events as Observable<PostEvent>)
//        .debounceTime(Duration(milliseconds: 500)));
//  }
  //  @override
//  Stream<PostState> transform(Stream<PostEvent> events,
//      Stream<PostState> next(PostEvent event)) {
//    return super.transform((events as Observable<PostEvent>).debounceTime(Duration(milliseconds: 500)), next);
//  }
//
//  @override
//  Stream<PostState> mapEventToState(PostEvent event) async* {
//    if (event is Fetch && !_hasReachedMax(currentState)) {
////      try {
////        // 当最开始时
////        if (currentState is PostUninitialized) {
////          final posts = await _fetchPosts(0, 20);
////          yield PostLoaded(posts: posts, hasReachedMax: false);
////          // TODO 这里有点问题，你咋知道肯定有第二页数据呢
////          return;
////        }
////
////        // 翻页时
////        if (currentState is PostLoaded) {
////          final posts =
////              await _fetchPosts((currentState as PostLoaded).posts.length, 20);
////          yield posts.isEmpty
////              ? (currentState as PostLoaded).copyWith(hasReachedMax: true)
////              : PostLoaded(
////                  posts: (currentState as PostLoaded).posts,
////                  hasReachedMax: false,
////                );
////        }
////      } catch (_) {
////        yield PostError();
////      }
////    }
//  }

  bool _hasReachedMax(PostState state) {
    return state is PostLoaded && state.hasReachedMax;
  }

  Future<List<Post>> _fetchPosts(int startIndex, int limit) async {
    final reponse = await httpClient.get(
        'https://jsonplaceholder.typicode.com/posts?_start=$startIndex&_limit=$limit');
    if (reponse.statusCode == 200) {
      final data = json.decode(reponse.body) as List;
      return data.map((rawPost) {
        return Post(
          id: rawPost['id'],
          title: rawPost['title'],
          body: rawPost['body'],
        );
      }).toList();
    } else {
      throw Exception('请求有问题');
    }
  }
}
