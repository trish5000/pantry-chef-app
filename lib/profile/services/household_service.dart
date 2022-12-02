import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pantry_chef_app/authentication/state/auth_provider.dart';
import 'package:pantry_chef_app/configuration/api_client.dart';
import 'package:pantry_chef_app/profile/models/household_member.dart';
import 'package:pantry_chef_app/profile/models/household_member_create.dart';

class HouseholdService {
  final Dio api;
  final UserContext userContext;
  HouseholdService({required this.userContext, required this.api});

  Future<List<HouseholdMember>> getHousehold() async {
    final userId = userContext.user!.id;
    final apiResponse = await api.get('/users/$userId/household');
    final householdMembers = apiResponse.data
        .map<HouseholdMember>((member) => HouseholdMember.fromJson(member))
        .toList();
    print(householdMembers.length);
    return householdMembers;
  }

  Future<HouseholdMember> addMember(HouseholdMemberCreate newMember) async {
    final userId = userContext.user!.id;
    final apiResponse = await api.post(
      '/users/$userId/household',
      data: newMember.toJson(),
    );
    return HouseholdMember.fromJson(apiResponse.data);
  }

  Future<HouseholdMember> updateHouseholdMember(HouseholdMember member) async {
    final userId = userContext.user!.id;
    final apiResponse = await api.put(
      '/users/$userId/household',
      data: member.toJson(),
    );
    return HouseholdMember.fromJson(apiResponse.data);
  }

  Future deleteFoodItem(HouseholdMember member) async {
    final userId = userContext.user!.id;
    await api.delete(
      '/users/$userId/household',
      data: member.toJson(),
    );
  }
}

final householdServiceProvider = Provider(
  (ref) {
    final userContext = ref.watch(authProvider);
    final api = ref.watch(apiClientProvider);
    return HouseholdService(
      userContext: userContext,
      api: api,
    );
  },
);
