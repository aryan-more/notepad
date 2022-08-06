import 'dart:async';

class User {
  static String? user;
  static final _controller = StreamController<String?>();

  static void set(String newUser) {
    user = newUser;
    _controller.sink.add(user);
  }

  static Stream<String?> get stream => _controller.stream;
}

void main() {
  User.stream.listen((event) {
    print(event);
  });
  User.set("hello");
  User.set("hola");
  User.set("konichiwa");
  User.set("bonjour");
  User.set("namaste");
}
