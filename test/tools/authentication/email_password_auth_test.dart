import 'package:firebase_auth/firebase_auth.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:remote_nomads/tools/authentication/email_password_auth.dart';
import 'package:test/test.dart';

import 'email_password_auth_test.mocks.dart';

@GenerateMocks([FirebaseAuth, User, UserCredential])
void main() {
  late MockFirebaseAuth mockFirebaseAuth;
  late MockUserCredential mockUserCredential;
  late MockUser mockUser;

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    mockUserCredential = MockUserCredential();
    mockUser = MockUser();
  });

  group('Auth Service Test', () {
    test('registerWithEmailAndPassword returns a User on success', () async {
      // Mock the successful user creation flow
      when(mockFirebaseAuth.createUserWithEmailAndPassword(
        email: anyNamed('email'),
        password: anyNamed('password'),
      )).thenAnswer((_) async => mockUserCredential);

      when(mockUserCredential.user).thenReturn(mockUser);
      when(mockUser.email).thenReturn('test@test.com');

      // Call the actual function
      final user =
          await registerWithEmailAndPassword('test@test.com', 'password');

      // Check if the user was returned
      expect(user, isA<User>());
      expect(user?.email, 'test@test.com');
    });

    test('registerWithEmailAndPassword throws FirebaseAuthException on failure',
        () async {
      // Mock a FirebaseAuthException
      when(mockFirebaseAuth.createUserWithEmailAndPassword(
        email: anyNamed('email'),
        password: anyNamed('password'),
      )).thenThrow(FirebaseAuthException(code: 'email-already-in-use'));

      expect(() async {
        await registerWithEmailAndPassword('test@test.com', 'password');
      }, throwsA(isA<FirebaseAuthException>()));
    });

    test('signInWithEmailAndPassword returns a User on success', () async {
      // Mock the successful sign-in flow
      when(mockFirebaseAuth.signInWithEmailAndPassword(
        email: anyNamed('email'),
        password: anyNamed('password'),
      )).thenAnswer((_) async => mockUserCredential);

      when(mockUserCredential.user).thenReturn(mockUser);
      when(mockUser.email).thenReturn('test@test.com');

      // Call the actual function
      final user =
          await signInWithEmailAndPassword('test@test.com', 'password');

      // Check if the user was returned
      expect(user, isA<User>());
      expect(user?.email, 'test@test.com');
    });

    test('signInWithEmailAndPassword throws FirebaseAuthException on failure',
        () async {
      // Mock a FirebaseAuthException
      when(mockFirebaseAuth.signInWithEmailAndPassword(
        email: anyNamed('email'),
        password: anyNamed('password'),
      )).thenThrow(FirebaseAuthException(code: 'wrong-password'));

      expect(() async {
        await signInWithEmailAndPassword('test@test.com', 'password');
      }, throwsA(isA<FirebaseAuthException>()));
    });

    test('signOut successfully signs out', () async {
      // Mock the sign-out call
      when(mockFirebaseAuth.signOut()).thenAnswer((_) async => null);

      // Call the actual function
      await signOut();

      // Verify that signOut was called
      verify(mockFirebaseAuth.signOut()).called(1);
    });
  });
}
