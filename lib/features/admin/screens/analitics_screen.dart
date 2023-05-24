import 'package:amazone_clone/common/widget/loader.dart';
import 'package:amazone_clone/features/admin/models/sales.dart';
import 'package:amazone_clone/features/admin/services/admin_services.dart';
import 'package:amazone_clone/features/admin/widgets/chart_product.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter_new/flutter.dart' as charts;

class AnalicticScreen extends StatefulWidget {
  const AnalicticScreen({super.key});

  @override
  State<AnalicticScreen> createState() => _AnalicticScreenState();
}

class _AnalicticScreenState extends State<AnalicticScreen> {
  final AdminServices adminServices = AdminServices();
  int? totalSales;
  List<Sales>? earnings;

  @override
  void initState() {
    super.initState();
    getEarnings();
  }

  void getEarnings() async {
    var earningData = await adminServices.getEarnings(context);
    totalSales = earningData['totalEarnings'];
    earnings = earningData['sales'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return totalSales == null || earnings == null
        ? const Loader()
        : Column(
            children: [
              Text(
                'RP. $totalSales',
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  height: 250,
                  child: ProductCategoryChart(
                    seriesList: [
                      charts.Series(
                        id: 'Sales',
                        data: earnings!,
                        domainFn: (Sales sales, _) => sales.label,
                        measureFn: (Sales sales, _) => sales.earning,
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
  }
}
