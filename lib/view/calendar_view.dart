import 'package:find_hotels_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({super.key});

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  DateTimeRange dateRange =
      DateTimeRange(start: DateTime(2023, 11, 5), end: DateTime(2023, 12, 24));
  @override
  Widget build(BuildContext context) {
    final start = dateRange.start;
    final end = dateRange.end;
    final difference = dateRange.duration;

    return Scaffold(
      body: Column(
        children: [
          const CustomText(
            text: 'Data Range',
            size: 32,
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: pickDateRange,
                  child: Text(DateFormat('yyyy/MM/dd').format(start)),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: pickDateRange,
                  child: Text(DateFormat('yyyy/MM/dd').format(end)),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Text('Difference: ${difference.inDays}')
        ],
      ),
    );
  }

  Future pickDateRange() async {
    DateTimeRange? newDateRange = await showDateRangePicker(
        context: context,
        initialDateRange: dateRange,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100));
    if (newDateRange == null) return;
    setState(() => dateRange = newDateRange);
  }
}
