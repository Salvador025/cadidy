import 'package:flutter_test/flutter_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:cadidy/service/users_service.dart';

void main() {
  group('UsersService', () {
    late FakeFirebaseFirestore firestore;
    late MockFirebaseAuth auth;
    late UsersService usersService;

    setUp(() async {
      firestore = FakeFirebaseFirestore();
      auth = MockFirebaseAuth(mockUser: MockUser(uid: 'testUid'));
      await auth.signInWithEmailAndPassword(
          email: 'test@test.com', password: '123456');
      usersService = UsersService(firestore: firestore, auth: auth);
    });

    test('saveUserData should create a user document in Firestore', () async {
      await usersService.saveUserData(
        uid: 'testUid',
        email: 'test@test.com',
        displayName: 'John',
        lastName: 'Doe',
        address: '123 Main St',
        profilePicture: 'profile.jpg',
        phone: '1234567890',
        username: 'johndoe',
      );

      final snapshot = await firestore.collection('users').doc('testUid').get();
      expect(snapshot.exists, true);
      expect(snapshot['email'], 'test@test.com');
    });

    test('doesUIDExist should return true when UID exists', () async {
      await firestore
          .collection('users')
          .doc('testUid')
          .set({'uid': 'testUid', 'email': 'test@test.com'});

      final exists = await usersService.doesUIDExist('testUid');
      expect(exists, true);
    });

    test('doesUIDExist should return false when UID does not exist', () async {
      final exists = await usersService.doesUIDExist('nonexistentUid');
      expect(exists, false);
    });

    test('updateUserField should update the specified field', () async {
      await firestore
          .collection('users')
          .doc('testUid')
          .set({'uid': 'testUid', 'email': 'test@test.com', 'phone': '1234'});

      await usersService.updateUserField('phone', '5678');

      final updatedDoc =
          await firestore.collection('users').doc('testUid').get();
      expect(updatedDoc['phone'], '5678');
    });
  });
}
