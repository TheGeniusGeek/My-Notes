//Login Exceptions
class UserNotFoundAuthException implements Exception {}

class WrongPasswordAuthException implements Exception {}

//Register Exception
class WeakPasswordAuthException implements Exception {}

class EmailAlreadyInUseAuthException implements Exception {}

class InvalidEmailAuthException implements Exception {}

class UnknownAuthException implements Exception {}

class GenericAuthException implements Exception {}

class UserNotLoggedInAuthException implements Exception {}
