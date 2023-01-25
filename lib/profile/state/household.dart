import 'package:flutter_riverpod/flutter_riverpod.dart';

class HouseholdState {
  final int? size;
  HouseholdState({this.size});
}

final householdStateProvider =
    StateProvider<HouseholdState>((ref) => HouseholdState());
