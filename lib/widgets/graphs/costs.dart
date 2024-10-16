import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hero/widgets/graphs/color_helper.dart';
import 'package:hero/widgets/graphs/graph_colors.dart';
import 'package:hero/widgets/warning_message.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Costs extends StatefulWidget {
  final List budgets;
  Costs({super.key, required this.budgets});
  final Color leftBarColor = AppColors.contentColorYellow;
  final Color rightBarColor = AppColors.contentColorRed;
  final Color avgColor =
      AppColors.contentColorOrange.avg(AppColors.contentColorRed);
  @override
  State<StatefulWidget> createState() => CostsState();
}

class CostsState extends State<Costs> {
  final double width = 7;

  late List<BarChartGroupData> rawBarGroups = [];
  late List<BarChartGroupData> showingBarGroups;

  int touchedGroupIndex = -1;
  double maxPrice = 0.0;

  @override
  void initState() {
    super.initState();
    List<BarChartGroupData> items = [];

    var count = 0;
    for (var row in widget.budgets) {   
      if(count <8){
        //  print('Travel: ${row['travel_name']}, Total Budget: ${row['total_price']}, Total Budget: ${row['total_estimate']}');
        var estimate = row['total_estimate'] != null ? row['total_estimate'] : 0.0;
        var real = row['total_price'] != null ? row['total_price'] : 0.0;

        final barGroup = makeGroupData(0,estimate, real);
        items.add(barGroup);
        
        if (real > maxPrice) {
          maxPrice = real;
        }
        count++;
      }
    }

    
    // final barGroup1 = makeGroupData(0, 5, 12);
    // final barGroup2 = makeGroupData(1, 16, 12);
    // final barGroup3 = makeGroupData(2, 18, 5);
    // final barGroup4 = makeGroupData(3, 20, 16);
    // final barGroup5 = makeGroupData(4, 17, 6);
    // final barGroup6 = makeGroupData(5, 19, 1.5);
    // final barGroup7 = makeGroupData(6, 10, 1.5);

    // final items = [
    //   barGroup1,
    //   barGroup2,
    //   barGroup3,
    //   barGroup4,
    //   barGroup5,
    //   barGroup6,
    //   barGroup7,
    // ];

    // rawBarGroups = [items];

    showingBarGroups = items;
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio:1.5,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: (widget.budgets.isNotEmpty)
          ?Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
            Row(
              children: [
                Container( width: 20 , height: 5,color: AppColors.contentColorYellow,),
                const SizedBox(width: 10,),
                Text(AppLocalizations.of(context)!.preventivo),
              ],
            ),
            Row(
              children: [
                Container( width: 20 , height: 5,color: AppColors.contentColorRed,),
                const SizedBox(width: 10,),
                Text(AppLocalizations.of(context)!.prezzo),
              ],
            ),
            const SizedBox(height: 20,),
            
            Expanded(
              child: BarChart(
                BarChartData(
                  maxY: maxPrice, // da inserire valore massimo
                  barTouchData: BarTouchData(
                    touchTooltipData: BarTouchTooltipData(
                      getTooltipColor: ((group) {
                        return Colors.grey;
                      }),
                      getTooltipItem: (a, b, c, d) => null,
                    ),
                    touchCallback: (FlTouchEvent event, response) {},
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: bottomTitles,
                        reservedSize: 42,
                      ),
                    ),
                    // leftTitles: AxisTitles(
                    //   sideTitles: SideTitles(
                    //     showTitles: true,
                    //     reservedSize: 28,
                    //     interval: 1,
                    //     getTitlesWidget: leftTitles,
                    //   ),
                    // ),
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  barGroups: showingBarGroups,
                  gridData: const FlGridData(show: false),
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            
          ],
        ):WarningMessage(message: AppLocalizations.of(context)!.graficoNonDisponibile,),
      ),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    if (value == 0) {
      text = '0';
    } else if (value/4 == maxPrice/4) {
      text = value.toString();
    } else if (value/2 == maxPrice/4) {
      text = value.toString();
    } else {
      return Container();
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 0,
      child: Text(text, style: style),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    List<String> travelTitles = [];
    var count = 0;
    widget.budgets.forEach((row) {   
      if(count <8){
        //  print('Travel: ${row['travel_name']}, Total Budget: ${row['total_price']}, Total Budget: ${row['total_estimate']}');
        travelTitles.add(row['travel_name']);
        count++;
      }
    });

    if (value.toInt() < 0 || value.toInt() >= travelTitles.length) {
      return const SizedBox.shrink(); // Return an empty widget if out of bounds
    }
    // final titles = <String>['Mn', 'Te', 'Wd', 'Tu', 'Fr', 'St', 'Su'];

    final Widget text = Text(
      travelTitles[value.toInt()],
      style: const TextStyle(
        color: Color(0xff7589a2),
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16, //margin top
      child: text,
    );
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      barRods: [
        BarChartRodData(
          toY: y1,
          color: widget.leftBarColor,
          width: width,
        ),
        BarChartRodData(
          toY: y2,
          color: widget.rightBarColor,
          width: width,
        ),
      ],
    );
  }

  
}
