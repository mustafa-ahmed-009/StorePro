import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shops_manager_offline/core/functions/date_format.dart';
import 'package:shops_manager_offline/features/billings/presentation/managers/cubit/bill_cubit.dart';
import 'package:shops_manager_offline/features/billings/presentation/view/desktop/bill_view_by_date_widget/bill_serach_bar_widget.dart';
import 'package:shops_manager_offline/features/billings/presentation/view/desktop/bill_view_by_date_widget/bills_list_view_bloc_builder.dart';
import 'package:shops_manager_offline/features/billings/presentation/view/desktop/bill_view_by_date_widget/month_bills_view.dart';
import 'package:table_calendar/table_calendar.dart';

class FinancialView extends StatefulWidget {
  const FinancialView({super.key});

  @override
  State<FinancialView> createState() => _FinancialViewState();
}

class _FinancialViewState extends State<FinancialView> {
  DateTime myFocusedDay = DateTime.now(); // Track the focused month
  DateTime mySelectedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.twoWeeks;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BillCubit()
        ..fetchBills(
            currentDate: getCurrentDateWithoutHour(date: mySelectedDay)),
      child: Builder(
        builder: (context) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "المالية",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Center(
                child: BillSearchBarWidget(
                  hintText: " اضعط للبحث عن فاتورة بالرقم التعريفي الخاص بها ",
                ),
              ),
              SizedBox(height: 16), // Add spacing
              TableCalendar(
                calendarFormat: _calendarFormat,
                focusedDay: myFocusedDay,
                selectedDayPredicate: (day) => isSameDay(mySelectedDay, day),
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                onFormatChanged: (format) {
                  if (_calendarFormat != format) {
                    // Call `setState()` when updating calendar format
                    setState(() {
                      _calendarFormat = format;
                    });
                  }
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    mySelectedDay = selectedDay;
                    context.read<BillCubit>().fetchBills(
                          currentDate:
                              getCurrentDateWithoutHour(date: mySelectedDay),
                        );
                  });
                },
                onPageChanged: (focusedDay) {
                  setState(() {
                    myFocusedDay = focusedDay;
                  });
                },
                calendarBuilders: CalendarBuilders(
                  headerTitleBuilder: (context, day) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            DateFormat('MMMM yyyy').format(day),
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Flexible(
                          child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MonthBillsView(
                                              month:
                                                  DateFormat('M').format(day),
                                            )));
                              },
                              child: Text("عرض اجمالي فواتير الشهر الحالي ")),
                        ),
                        SizedBox.shrink()
                      ],
                    );
                  },
                ),
              ),
              Expanded(
                child: BillsListViewBlocBuilder(
                    currentDate:
                        getCurrentDateWithoutHour(date: mySelectedDay)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
