import 'package:awign_saas/core/data/model/button_state.dart';
import 'package:awign_saas/hrms/reimbursements/data/model/category_response.dart';
import 'package:awign_saas/hrms/reimbursements/data/model/manager_response.dart';
import 'package:awign_saas/hrms/reimbursements/data/model/reimbursement_type_response.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/data/model/ui_state.dart';

part 'reimbursement_form_state.g.dart';

@CopyWith()
class ReimbursementFormState extends Equatable {
  final UIState? uiState;
  final ButtonState? buttonState;
  final DateTime? fromSelectedDate;
  final DateTime? toSelectedDate;
  final String? receiptNo;
  final String? receiptNoError;
  final String? amount;
  final String? amountError;
  final String? remark;
  final String? remarkError;
  final String? filePath;
  final String? fileName;
  final int? totalFileSize;
  final String? uploadedFileURL;
  final ManagerResponse? managerResponse;
  final Manager? manager;
  final List<ReimbursementType>? reimbursementTypes;
  final List<ReimbursementSubType>? reimbursementSubTypes;
  final bool? isReimbursementTypesLoading;
  final bool? isReimbursementCategoriesLoading;
  final bool? isManagersLoading;
  final ReimbursementType? selectedReimbursementType;
  final ReimbursementSubType? selectedReimbursementSubType;
  final String? vendorName;
  final String? stayDate;
  final String? fromDestination;
  final String? stayLocation;
  final String? toDestination;
  final String? dateOfTravel;
  final String? distanceTravelled;
  final List<ReimbursementCategory>? reimbursementCategories;
  final ReimbursementCategory? selectedReimbursementCategory;
  final int? uploadPercentValue;
  final double? uploadProgressValue;

  const ReimbursementFormState(
      {this.uiState,
      this.buttonState = const ButtonState(isEnable: false),
      this.fromSelectedDate,
      this.toSelectedDate,
      this.receiptNo,
      this.receiptNoError,
      this.amount,
      this.amountError,
      this.remark,
      this.remarkError,
      this.filePath,
      this.fileName,
      this.totalFileSize,
      this.uploadedFileURL,
      this.managerResponse,
      this.manager,
      this.reimbursementTypes,
      this.reimbursementSubTypes,
      this.isReimbursementTypesLoading,
      this.isReimbursementCategoriesLoading,
      this.isManagersLoading,
      this.selectedReimbursementType,
      this.selectedReimbursementSubType,
      this.vendorName,
      this.stayDate,
      this.fromDestination,
      this.stayLocation,
      this.toDestination,
      this.dateOfTravel,
      this.reimbursementCategories,
      this.selectedReimbursementCategory,
      this.distanceTravelled,
      this.uploadPercentValue,
      this.uploadProgressValue,
      });

  @override
  List<Object?> get props => [
        uiState,
        buttonState,
        fromSelectedDate,
        toSelectedDate,
        receiptNo,
        receiptNoError,
        amount,
        amountError,
        remark,
        remarkError,
        filePath,
        fileName,
        totalFileSize,
        uploadedFileURL,
        managerResponse,
        manager,
        reimbursementTypes,
        reimbursementSubTypes,
        isReimbursementTypesLoading,
        isReimbursementCategoriesLoading,
        isManagersLoading,
        selectedReimbursementType,
        selectedReimbursementSubType,
        vendorName,
        stayDate,
        fromDestination,
        toDestination,
        dateOfTravel,
        reimbursementCategories,
        selectedReimbursementCategory,
        distanceTravelled,
        uploadPercentValue,
        uploadProgressValue,
      ];
}
