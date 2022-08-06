import 'dart:io';

import 'package:flutter/foundation.dart';

bool localSupport = Platform.isAndroid || Platform.isIOS || Platform.isLinux || Platform.isMacOS || Platform.isWindows;
bool fireBaseSupport = Platform.isAndroid || Platform.isIOS || kIsWeb || Platform.isMacOS;
