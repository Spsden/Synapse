// import 'package:flutter/foundation.dart';
// import 'dart:async';
//
// extension StreamSpy<T> on Stream<T> {
//   Stream<T> spy(String name) {
//     return transform(
//       StreamTransformer.fromHandlers(
//         handleData: (data, sink) {
//           if (kDebugMode) {
//             print('🕵️ [$name] Stream Event: $data');
//           }
//           sink.add(data);
//         },
//         handleError: (error, stackTrace, sink) {
//           if (kDebugMode) {
//             print('🕵️ [$name] Stream Error: $error');
//           }
//           sink.addError(error, stackTrace);
//         },
//         handleDone: (sink) {
//           if (kDebugMode) {
//             print('🕵️ [$name] Stream Done');
//           }
//           sink.close();
//         },
//       ),
//     );
//   }
// }
