import 'package:autotureid/app/domain/entities/user_plan.dart';
import 'package:autotureid/core/enums.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserPlanModel {
  final String id;
  final String userId;
  final String planId;
  final Timestamp? startDate;
  final Timestamp? endDate;
  final Timestamp? renewalDate;
  final String status;

  UserPlanModel({
    required this.id,
    required this.userId,
    required this.planId,
    required this.startDate,
    required this.endDate,
    required this.renewalDate,
    required this.status,
  });

  factory UserPlanModel.fromJson(Map<String, dynamic> json) {
    return UserPlanModel(
      id: json['id'],
      userId: json['user_id'],
      planId: json['plan_id'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      renewalDate: json['renewal_date'],
      status: json['status'],
    );
  }

  factory UserPlanModel.fromEntity(UserPlan entity) {
    return UserPlanModel(
      id: entity.id,
      userId: entity.userId,
      planId: entity.planId,
      startDate: entity.startDate != null ? Timestamp.fromDate(entity.startDate!) : null,
      endDate: entity.endDate != null ? Timestamp.fromDate(entity.endDate!) : null,
      renewalDate: entity.renewalDate != null ? Timestamp.fromDate(entity.renewalDate!) : null,
      status: entity.status.name,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'plan_id': planId,
      'start_date': startDate,
      'end_date': endDate,
      'renewal_date': renewalDate,
      'status': status,
    };
  }

  UserPlan toEntity() {
    return UserPlan(
      id: id,
      userId: userId,
      planId: planId,
      startDate: startDate?.toDate(),
      endDate: endDate?.toDate(),
      renewalDate: renewalDate?.toDate(),
      status: UserPlanStatus.values.firstWhere((e) => e.name == status),
    );
  }
}
