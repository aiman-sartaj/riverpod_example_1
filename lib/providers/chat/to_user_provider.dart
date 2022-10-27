import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/user/user.dart';

final toUserProvider = FutureProvider.family.autoDispose<User, String>((ref, uid) async {
  final List<User> users = [
    User(
      id: '1',
      name: 'John Doe',
      imgUrl: 'https://picsum.photos/200',
    ),
    User(
      id: '2',
      name: 'Jane Doe',
      imgUrl: 'https://picsum.photos/200',
    )
  ];

  await Future.delayed(const Duration(seconds: 2));

  return users.firstWhere((user) => user.id == uid);
});
