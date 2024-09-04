import 'package:dartz/dartz.dart';

/// Abstract class representing a failure in the application.
///
/// This class encapsulates details about the failure, including the type, description,
/// stack trace, and any additional arguments related to the failure.
abstract class FailureAbstract {
  final dynamic type;
  final String description;
  final StackTrace? stackTrace;
  final dynamic args;

  /// Converts the failure to a string representation.
  String toString();

  /// Constructor for the abstract failure class.
  ///
  /// [type] represents the type of failure.
  /// [description] provides a detailed description of the failure.
  /// [stackTrace] captures the stack trace at the point of failure.
  /// [args] includes any additional arguments related to the failure.
  FailureAbstract(this.type, this.description, this.args, this.stackTrace);
}

/// Concrete implementation of [FailureAbstract].
///
/// This class provides specific behavior and properties for handling failures.
class Failure implements FailureAbstract {
  late String _description;
  StackTrace? _stackTrace;
  dynamic _type;
  dynamic _args;

  /// Constructor for [Failure] class.
  ///
  /// [type] specifies the type of failure.
  /// [description] gives a detailed description of the failure.
  /// [stackTrace] captures the stack trace related to the failure.
  /// [args] includes any additional arguments related to the failure.
  @override
  Failure(type, description, stackTrace, args) {
    _description = description ?? "";
    _type = type;
    _stackTrace = stackTrace;
    _args = args;
  }

  /// Getter for the failure's description.
  @override
  String get description => _description;

  /// Converts the failure to a string representation.
  @override
  String toString() {
    return _description;
  }

  /// Getter for the failure's type.
  @override
  get type => _type;

  /// Getter for any additional arguments related to the failure.
  get args => _args;

  /// Getter for the stack trace related to the failure.
  StackTrace get stackTrace => _stackTrace!;
}

/// Extension on [Task] for converting left-side errors into [Failure] objects.
extension TaskX<T extends Either<Object, U>, U> on Task<T> {

  /// Maps left-side errors to [Failure] objects.
  ///
  /// This method transforms the left side of an [Either] from an [Object] to a [Failure].
  /// If the left side cannot be cast to [Failure], the original error is thrown.
  Task<Either<Failure, U>> mapLeftToFailure() {
    return map(
          (either) => either.leftMap((obj) {
        try {
          return obj as Failure;
        } catch (e) {
          throw obj;
        }
      }),
    );
  }
}
