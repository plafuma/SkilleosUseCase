import 'package:flutter_riverpod/flutter_riverpod.dart';

var providerIndex = StateProvider<int>((ref) => 0);
var isReversedProvider = StateProvider<bool>((ref) => false);
