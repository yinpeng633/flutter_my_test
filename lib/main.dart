import 'package:flutter/material.dart';
import 'package:flutter_app_1/demo/infiniteListDemo/Post.dart';
import 'package:flutter_app_1/demo/infiniteListDemo/PostBloc.dart';
import 'package:flutter_app_1/demo/infiniteListDemo/PostEvent.dart';
import 'package:flutter_app_1/demo/infiniteListDemo/PostState.dart';

import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter dp',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Posts'),
        ),
        body: HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  final _scrollController = ScrollController();
  final PostBloc _postBloc = PostBloc(httpClient: http.Client());
  final _scrollThreshold = 200.0;

  _HomePageState() {
    _scrollController.addListener(() {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.position.pixels;
      if (maxScroll - currentScroll <= _scrollThreshold) {
        _postBloc.dispatch(Fetch());
      }
    });

    _postBloc.dispatch(Fetch());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: _postBloc,
        builder: (BuildContext context, PostState state) {
          if (state is PostUninitialized) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is PostError) {
            return Center(
              child: Text('拉去数据失败'),
            );
          }

          if (state is PostLoaded) {
            if (state.posts.isEmpty) {
              return Center(
                child: Text('数据为空'),
              );
            }

            // 这里为啥报错？？？？
//            if (state.hasReachedMax) {
//              Scaffold.of(context).showSnackBar(new SnackBar(content: Text("已经到底拉")));
////              return Center(
////
////              );
//            }

            return ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return index >= state.posts.length
                      ? BottomLoader()
                      : PostWidget(post: state.posts[index]);
                },
                itemCount: state.hasReachedMax
                    ? state.posts.length
                    : state.posts.length + 1,
                controller: _scrollController);
          }
        });
  }

  @override
  void dispose() {
    _postBloc.dispose();
    super.dispose();
  }
}

class BottomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: 33,
          height: 33,
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
          ),
        ),
      ),
    );
  }
}

class PostWidget extends StatelessWidget {
  final Post post;

  PostWidget({Key key, @required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        '${post.id}',
        style: TextStyle(fontSize: 10),
      ),
      title: Text(post.title),
      isThreeLine: true,
      subtitle: Text(post.body),
      dense: true,
    );
  }
}
