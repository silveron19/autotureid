import 'package:autotureid/core/enums.dart';

class UserPlan {
  final String id;
  final String userId;
  final String planId;
  final DateTime? startDate;
  final DateTime? endDate;
  final DateTime? renewalDate;
  final UserPlanStatus status;

  UserPlan({
    required this.id,
    required this.userId,
    required this.planId,
    required this.startDate,
    required this.endDate,
    required this.renewalDate,
    required this.status,
  });
}
