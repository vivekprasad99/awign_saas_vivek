enum DynamicModule {
  hrmsAttendance('HRMS_ATTENDANCE'),
  hrmsRegularization('HRMS_REGULARIZATION'),
  hrmsLeave('HRMS_LEAVE'),
  hrmsReimbursement('HRMS_REIMBURSEMENT'),
  hrmsDocuments('HRMS_DOCUMENTS'),
  hrmsHolidays('HRMS_HOLIDAYS'),
  hrmsFaqs('HRMS_FAQS'),
  hrmsCompOff('HRMS_COMP_OFF'),
  hrmsTaskFulfilment('HRMS_TASK_FULFILLMENT');

  const DynamicModule(this.value);

  final String value;

  static DynamicModule? get(strPunchType) {
    switch(strPunchType) {
      case 'HRMS_ATTENDANCE':
        return DynamicModule.hrmsAttendance;
      case 'HRMS_REGULARIZATION':
        return DynamicModule.hrmsRegularization;
      case 'HRMS_LEAVE':
        return DynamicModule.hrmsLeave;
      case 'HRMS_REIMBURSEMENT':
        return DynamicModule.hrmsReimbursement;
      case 'HRMS_DOCUMENTS':
        return DynamicModule.hrmsDocuments;
      case 'HRMS_HOLIDAYS':
        return DynamicModule.hrmsHolidays;
      case 'HRMS_FAQS':
        return DynamicModule.hrmsFaqs;
      case 'HRMS_COMP_OFF':
        return DynamicModule.hrmsCompOff;
      case 'HRMS_TASK_FULFILLMENT':
        return DynamicModule.hrmsTaskFulfilment;
      default:
        return null;
    }
  }
}