import 'package:equatable/equatable.dart';


class Post extends Equatable {

  final int id;
  final String title;
  final String body;


//  Post(this.id, this.title, this.content);

  Post({this.id, this.title, this.body}) : super([id, title, body]);

  @override
  String toString() {
    return 'Post{ id: $id, title: $title, body: $body }';
  }
}


//void main() {
//  List<int> list = [1, 2, 3, 4, 5, 6];
//  Stream<int> quickStream = Stream.fromIterable(list);
//  quickStream.lastWhere((i) {
//    return i < 4;
//  }).then((i) {
//    print(i);
//  });
//
//
//
////  print(list.lastWhere((i) => i < 4).toString());
//
//
////      .listen((event) {
////    print(event);
////  }, onDone: () {
////    print("done");
////  }, onError: (dd) {
////    print("onError");
////  }, cancelOnError: false);
//}