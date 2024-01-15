import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:poloniex_app/features/trade/presentation/controllers/trade_controller.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LiveLineChart extends ConsumerStatefulWidget {
  const LiveLineChart({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LiveLineChartState();
}

class _LiveLineChartState extends ConsumerState<LiveLineChart> {
  List<_ChartData>? chartData;
  late int count;
  ChartSeriesController<_ChartData, int>? _chartSeriesController;

  @override
  void dispose() {
    _chartSeriesController = null;
    super.dispose();
  }

  @override
  void initState() {
    count = 0;
    chartData = null; // Initialize with null data
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(tradeStreamControllerProvider);
    data.whenData((value) {
      chartData ??= [];

      chartData!.add(_ChartData(count, value));
      if (chartData!.length == 20) {
        chartData!.removeAt(0);
        _chartSeriesController?.updateDataSource(
          addedDataIndexes: <int>[chartData!.length - 1],
          removedDataIndexes: <int>[0],
        );
      } else {
        _chartSeriesController?.updateDataSource(
          addedDataIndexes: <int>[chartData!.length - 1],
        );
      }
      count = count + 1;
    });

    return _buildLiveLineChart();
  }

  Widget _buildLiveLineChart() {
    if (chartData == null || chartData!.isEmpty) {
      return const SizedBox.shrink();
    }

    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      primaryXAxis: const NumericAxis(majorGridLines: MajorGridLines(width: 0)),
      primaryYAxis: NumericAxis(
        numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0),
        // numberFormat: NumberFormat(),
        // NUMBER FORMAT
        axisLine: AxisLine(width: 0),
        majorTickLines: MajorTickLines(size: 0),
      ),
      series: <LineSeries<_ChartData, int>>[
        LineSeries<_ChartData, int>(
          onRendererCreated:
              (ChartSeriesController<_ChartData, int> controller) {
            _chartSeriesController = controller;
          },
          dataSource: chartData!,
          color: const Color.fromRGBO(192, 108, 132, 1),
          xValueMapper: (_ChartData index, _) => index.price,
          yValueMapper: (_ChartData index, _) => index.index,
          animationDuration: 0,
        )
      ],
    );
  }
}

class _ChartData {
  _ChartData(this.price, this.index);
  final int price;
  final num index;
}
