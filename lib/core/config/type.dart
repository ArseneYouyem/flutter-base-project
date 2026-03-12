import 'dart:io';

typedef ParamsCallback<R, T> = R Function(T value);
typedef TwoParamsCallback<T1, T2> = Function(T1 value1, T2 value2);
typedef CallbackFunction<R> = R Function();
typedef ArrowFunction<T> = Function(T value);
typedef BoolCallback = CallbackFunction<bool>;
typedef FutureCallback<R> = CallbackFunction<Future<R>>;
typedef JsonType = Map<String, dynamic>;
typedef JsonStringType = Map<String, String>;
typedef JsonFileType = Map<String, File>;
