abstract class AuthService<T> {
  Future<void> performAuth(T data);
}
