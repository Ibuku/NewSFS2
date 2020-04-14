import 'package:flutter/foundation.dart';

class UserNotification {
  final String id;
  final String message;
  final String formattedMessage;
  final String date;

  UserNotification({
    @required this.id,
    @required this.message,
    this.formattedMessage,
    @required this.date
  });

  static String _formatNotificationMessage(String message) {
    if(message.contains('email') && message.contains('verified')){
      return 'Email Verified';
    }
    if(message.contains('loan')){
      if(message.contains('requested')) {
        return 'Loan Request';
      } else if(message.contains('approve')){
        return 'Loan Approved';
      } else if(message.contains('decline')) {
        return 'Loan Declined';
      }
    }

    if(message.contains('guarantor')){
      if(message.contains('approve') || message.contains('accept')){
        return 'Guarantor Approval';
      }
    }
    return '';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'message': message,
      'created_at': date
    };
  }

  static UserNotification fromMap(Map<String, dynamic> map,) {
    if (map == null) return null;
    String formattedMsg = _formatNotificationMessage(map['data']['message']);

    return UserNotification (
        id: map['id'],
        message: map['data']['message'],
        formattedMessage: formattedMsg != '' ? formattedMsg : map['data']['message'],
        date: map['created_at']
    );
  }
}
