/*
// FutureProvider

final usersProvider = FutureProvider<List<User>>((ref) async {
  try {
    final currentUserUid = ref.watch(currentUserUidProvider);
    if (currentUserUid == null) {
      throw Exception('DEBUG: Not found user ID');
    }

    final usersSnapshot = await UserCollections.get();
    final users = usersSnapshot.docs
        .map((doc) {
          return User.fromJson(doc.data());
        })
        .where((user) => user.userId != currentUserUid)
        .toList();
    return users;
  } catch (e) {
  }
});

*/