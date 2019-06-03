// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_app_1/main.dart';
import 'package:bloc/bloc.dart';

enum UserEvent { Click, Tap }


Stream<int> createStream() async* {
  for (int i = 0; i < 10; i++) {
    yield i;
  }
}

Future<int> operateStream(Stream<int> stream) async {
  int sum = 0;
  await for (int v in stream) {
    sum += v;
  }
  return sum;
}

Future main() async {
//  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
//    // Build our app and trigger a frame.
//    await tester.pumpWidget(MyApp());
//
//    // Verify that our counter starts at 0.
//    expect(find.text('0'), findsOneWidget);
//    expect(find.text('1'), findsNothing);
//
//    // Tap the '+' icon and trigger a frame.
//    await tester.tap(find.byIcon(Icons.add));
//    await tester.pump();
//
//    // Verify that our counter has incremented.
//    expect(find.text('0'), findsNothing);
//    expect(find.text('1'), findsOneWidget);
//  });
//    UserEvent event = UserEvent.Click;
//    assert(event == UserEvent.Click);
//    print(UserEvent.Click);

//  // 创建stream, 使用async*和yield创建
//  Stream<int> intStream = createStream();
//
//  // 使用快捷方法创建
//  List<int> list = [1, 2, 3, 4, 5, 6];
//  Stream<int> quickStream = Stream.fromIterable(list);
//
//  int result = await operateStream(quickStream.map((i) => i + 10));
//  print(result);
//
//
//  Stream.fromFuture(operateStream(quickStream));

    BlocSupervisor.delegate = SimpleBlocDelegate();

    CounterBloc counterBloc = CounterBloc();
    counterBloc.dispatch(UserEvent.Tap);
    counterBloc.dispatch(UserEvent.Click);
}




class CounterBloc extends Bloc<UserEvent, int> {
  @override
  int get initialState => 0;

  @override
  Stream<int> mapEventToState(UserEvent event) async* {
    switch (event) {
      case UserEvent.Click:
        yield initialState + 1;
        break;
      case UserEvent.Tap:
        yield initialState - 1;
        break;
    }
  }

  @override
  void onTransition(Transition<UserEvent, int> transition) {
    print(transition.event.toString() + " " + transition.currentState.toString());
  }

  @override
  void onError(Object error, StackTrace stacktrace) {

  }

  @override
  void dispose() {

  }


}

class SimpleBlocDelegate extends BlocDelegate {

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }


}


