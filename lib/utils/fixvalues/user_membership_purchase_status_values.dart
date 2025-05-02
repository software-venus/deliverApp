import 'package:entrega/models/user_membership_purchase_status_model.dart';
import 'package:entrega/variables/globalvar.dart';

class UserMembershipPurchaseStatusValues {
  UserMembershipPurchaseStatusModel userMembershipPurchaseStatusModelPending =
      UserMembershipPurchaseStatusModel(false, "Pending",
          userMembershipPurchaseStatusModelValuePendingCaption);

  UserMembershipPurchaseStatusModel userMembershipPurchaseStatusModelEnd =
      UserMembershipPurchaseStatusModel(
          false, "End", userMembershipPurchaseStatusModelValueEndCaption);

  UserMembershipPurchaseStatusModel userMembershipPurchaseStatusModelCancel =
      UserMembershipPurchaseStatusModel(
          false, "Cancel", userMembershipPurchaseStatusModelValueCancelCaption);
}
