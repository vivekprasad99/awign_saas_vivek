enum NotificationType {
  all('ALL'),
  punchIn('PUNCH_IN'),
  punchOut('PUNCH_OUT'),
  leave('LEAVE'),
  regularization('REGULARIZATION'),
  reimbursement('REIMBURSEMENT');

  const NotificationType(this.value);

  final String value;

  static NotificationType? get(strPunchType) {
    switch(strPunchType) {
      case 'ALL':
        return NotificationType.all;
      case 'PUNCH_IN':
        return NotificationType.punchIn;
      case 'PUNCH_OUT':
        return NotificationType.punchOut;
      case 'LEAVE':
        return NotificationType.leave;
      case 'REGULARIZATION':
        return NotificationType.regularization;
      case 'REIMBURSEMENT':
        return NotificationType.reimbursement;
      default:
        return null;
    }
  }
}