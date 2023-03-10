import 'dart:ffi' as ffi;
import 'dart:ffi';
import 'dart:io';

import 'package:path/path.dart' as path;

final DynamicLibrary projLibrary = Platform.isAndroid
    ? ffi.DynamicLibrary.open('libproj.so')
    : Platform.isIOS
    ? ffi.DynamicLibrary.process()
    : ffi.DynamicLibrary.open(path.join(
  path.dirname(Platform.script.toFilePath()),
  'lib',
  'libproj.dylib',
));

typedef projCtx = ffi.Pointer<ffi.Void> Function();
typedef ProjCtx = ffi.Pointer<ffi.Void> Function();

typedef projPJ = ffi.Pointer<ffi.Void> Function(ProjCtx, ffi.Pointer<ffi.Void>);
typedef ProjPJ = ffi.Pointer<ffi.Void> Function(
    ffi.Pointer<ffi.Void>, ffi.Pointer<ffi.Void>);

class Proj {
  Proj._();

  static final projCtx createContext = projLibrary
      .lookup<ffi.NativeFunction<projCtx>>('proj_context_create')
      .asFunction();

  static final projPJ pjInitPlus =
  projLibrary.lookup<ffi.NativeFunction<projPJ>>('pj_init_plus') as projPJ;

// as projPJ ;

// static late final projPJ pjInitPlus = projLibrary
//     .lookup<ffi.NativeFunction<projPJ>>('pj_init_plus')
//     .asFunction();
}
