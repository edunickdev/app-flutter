import 'package:flutter_riverpod/flutter_riverpod.dart';

final mode = StateProvider<bool>((ref) => false);
final color = StateProvider<int>((ref) => 0);
