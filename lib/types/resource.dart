/// This library contains the resource sealed classes hierarchy
/// intended to present the state of the data fetching process:
/// Loading, Success and Error.
///
/// The sample usage is:
///
/// ```dart
/// switch (resource) {
///  case ResourceLoading<int> _:
///   print('Loading...');
///   break;
///  case ResourceError<int> error:
///   print('Error: ${error.error}');
///   break;
///  case ResourceSuccess<int> success:
///   print('Data: ${success.data}');
///   break;
/// }
/// ```
///
/// The name "Resource" is not the best name for this class and may be
/// changed in the future to something more descriptive.
library;

import 'package:flutter/cupertino.dart';

/// A base sealed class that represents the state of the data fetching process.
@immutable
sealed class Resource<T> {
  const Resource();
  Resource<R> transform<R>(R Function(T) transformer) {
    return switch (this) {
      ResourceLoading<T>() => ResourceLoading<R>(),
      ResourceError<T>(error: var e) => ResourceError<R>(e),
      ResourceSuccess<T>(data: var d) => ResourceSuccess<R>(transformer(d))
    };
  }
}

/// A state that represents the data is being fetched. It has no data.
@immutable
class ResourceLoading<T> extends Resource<T> {
  const ResourceLoading();
}

/// A state that represents the data has been successfully fetched.
/// It contains the fetched data.
@immutable
class ResourceSuccess<T> extends Resource<T> {
  final T data;

  const ResourceSuccess(this.data);
}

/// A state that represents an error occurred during the data fetching process.
/// It contains the error object.
@immutable
class ResourceError<T> extends Resource<T> {
  final Object error;

  const ResourceError(this.error);
}

extension ResourceX<T> on Resource<T> {
  R when<R>({
    required R Function() loading,
    required R Function(T data) success,
    required R Function(Object error)
        error, // Ubah tipe dari String menjadi Object
  }) {
    if (this is ResourceLoading<T>) {
      return loading();
    } else if (this is ResourceSuccess<T>) {
      return success((this as ResourceSuccess<T>).data);
    } else if (this is ResourceError<T>) {
      return error((this as ResourceError<T>).error);
    } else {
      throw Exception("Unhandled resource type");
    }
  }
}
