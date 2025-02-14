import 'package:flutter/material.dart';
import 'package:shops_manager_offline/core/config/failures.dart';
// Import your AppStyles
import 'package:sqflite/sqflite.dart';

class SqfliteDatabaseFailure extends Failure {
  SqfliteDatabaseFailure(super.errMessage);

  factory SqfliteDatabaseFailure.fromDatabaseError(dynamic error) {
    if (error is DatabaseException) {
      // Handle specific Sqflite database errors
      final errorMessage = error.toString(); // Get the actual error message
      debugPrint('DatabaseException: $errorMessage'); // Print the error message for debugging

      switch (error.getResultCode()) {
        case 1: // SQLITE_ERROR
          return SqfliteDatabaseFailure('حدث خطأ في قاعدة البيانات: $errorMessage');
        case 5: // SQLITE_BUSY
          return SqfliteDatabaseFailure('قاعدة البيانات مشغولة. يرجى المحاولة مرة أخرى لاحقًا.');
        case 6: // SQLITE_LOCKED
          return SqfliteDatabaseFailure('قاعدة البيانات مقفلة. يرجى المحاولة مرة أخرى لاحقًا.');
        case 7: // SQLITE_NOMEM
          return SqfliteDatabaseFailure('قاعدة البيانات تعاني من نقص في الذاكرة. يرجى إغلاق التطبيقات الأخرى والمحاولة مرة أخرى.');
        case 8: // SQLITE_READONLY
          return SqfliteDatabaseFailure('قاعدة البيانات للقراءة فقط. لا يمكن إجراء عمليات الكتابة.');
        case 9: // SQLITE_INTERRUPT
          return SqfliteDatabaseFailure('تمت مقاطعة العملية. يرجى المحاولة مرة أخرى.');
        case 10: // SQLITE_IOERR
          return SqfliteDatabaseFailure('حدث خطأ في الإدخال/الإخراج. يرجى التحقق من التخزين.');
        case 11: // SQLITE_CORRUPT
          return SqfliteDatabaseFailure('قاعدة البيانات تالفة. يرجى إعادة تثبيت التطبيق.');
        case 12: // SQLITE_NOTFOUND
          return SqfliteDatabaseFailure('لم يتم العثور على المورد المطلوب في قاعدة البيانات.');
        case 13: // SQLITE_FULL
          return SqfliteDatabaseFailure('قاعدة البيانات ممتلئة. يرجى تحرير بعض المساحة.');
        case 14: // SQLITE_CANTOPEN
          return SqfliteDatabaseFailure('لا يمكن فتح قاعدة البيانات. يرجى التحقق من الأذونات.');
        case 15: // SQLITE_PROTOCOL
          return SqfliteDatabaseFailure('حدث خطأ في البروتوكول. يرجى المحاولة مرة أخرى.');
        case 16: // SQLITE_EMPTY
          return SqfliteDatabaseFailure('قاعدة البيانات فارغة. لم يتم العثور على أي بيانات.');
        case 17: // SQLITE_SCHEMA
          return SqfliteDatabaseFailure('تم تغيير مخطط قاعدة البيانات. يرجى تحديث التطبيق.');
        case 18: // SQLITE_TOOBIG
          return SqfliteDatabaseFailure('البيانات كبيرة جدًا. يرجى تقليل الحجم والمحاولة مرة أخرى.');
        case 19: // SQLITE_CONSTRAINT
          return SqfliteDatabaseFailure('حدث انتهاك للقيود. يرجى التحقق من البيانات.');
        case 20: // SQLITE_MISMATCH
          return SqfliteDatabaseFailure('حدث عدم تطابق في نوع البيانات. يرجى التحقق من الإدخال.');
        case 21: // SQLITE_MISUSE
          return SqfliteDatabaseFailure('تم إساءة استخدام قاعدة البيانات. يرجى التحقق من الكود.');
        case 22: // SQLITE_NOLFS
          return SqfliteDatabaseFailure('نظام الملفات لا يدعم الملفات الكبيرة. يرجى استخدام جهاز آخر.');
        case 23: // SQLITE_AUTH
          return SqfliteDatabaseFailure('فشل المصادقة. يرجى التحقق من بيانات الاعتماد.');
        case 24: // SQLITE_FORMAT
          return SqfliteDatabaseFailure('تنسيق قاعدة البيانات غير صالح. يرجى إعادة تثبيت التطبيق.');
        case 25: // SQLITE_RANGE
          return SqfliteDatabaseFailure('حدث خطأ في النطاق. يرجى التحقق من الإدخال.');
        case 26: // SQLITE_NOTADB
          return SqfliteDatabaseFailure('الملف ليس قاعدة بيانات صالحة. يرجى التحقق من الملف.');
        default:
          // Log details for debugging purposes
          debugPrint('Unhandled DatabaseException: Code: ${error.getResultCode()}, Message: $errorMessage');
          return SqfliteDatabaseFailure('حدث خطأ غير متوقع في قاعدة البيانات: $errorMessage');
      }
    } else if (error is Exception) {
      // Handle generic exceptions
      final errorMessage = error.toString(); // Get the actual error message
      debugPrint('Unhandled Exception: $errorMessage'); // Print the error message for debugging
      return SqfliteDatabaseFailure('حدث خطأ غير متوقع: $errorMessage');
    } else {
      // Handle unknown errors
      final errorMessage = error.toString(); // Get the actual error message
      debugPrint('Unhandled Error: $errorMessage'); // Print the error message for debugging
      return SqfliteDatabaseFailure('حدث خطأ غير معروف: $errorMessage');
    }
  }
}