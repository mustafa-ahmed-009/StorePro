import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

String currentDataFormatted() {
  DateTime now = DateTime.now();
  String formattedDate = DateFormat('M-d-yyyy h:mm a').format(now);
  return formattedDate;
}

String getCurrentDateWithoutHour({required DateTime date}) {
  String formattedDate = DateFormat('M-d-yyyy').format(date);
  return formattedDate;
}

String formatDateInArabic(String dateString) {
  // Initialize Arabic locale
  initializeDateFormatting('ar', null);

  // Parse the custom date string into a DateTime object
  final inputFormat = DateFormat('M-d-yyyy h:mm a');
  DateTime date = inputFormat.parse(dateString);

  // Define the Arabic date format
  final arabicDateFormat = DateFormat('d MMMM yyyy h:mm a', 'ar');

  // Format the date in Arabic
  return arabicDateFormat.format(date);
}
