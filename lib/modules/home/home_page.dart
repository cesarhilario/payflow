import 'package:flutter/material.dart';
import 'package:payflow/modules/home/home_controller.dart';
import 'package:payflow/shared/routes/routes_controller.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeController = HomeController();
  final routesController = RoutesController();

  final pages = [
    Container(
      color: Colors.red,
    ),
    Container(color: Colors.blue),
  ];

  @override
  Widget build(BuildContext context) {
    routesController.setContext(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(152),
        child: Container(
          height: 152,
          color: AppColors.primary,
          child: Center(
            child: ListTile(
              title: Text.rich(TextSpan(
                  text: "Olá, ",
                  style: AppTextStyles.titleRegular,
                  children: [
                    TextSpan(
                        text: "César Hilário",
                        style: AppTextStyles.titleBoldBackground)
                  ])),
              subtitle: Text(
                "Mantenha as suas contas em dia",
                style: AppTextStyles.captionShape,
              ),
              trailing: Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(5)),
              ),
            ),
          ),
        ),
      ),
      body: pages[homeController.currentPage],
      bottomNavigationBar: SizedBox(
        height: 90,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          IconButton(
            onPressed: () {
              homeController.setPage(0);
              setState(() {});
            },
            icon: const Icon(Icons.home),
            color: AppColors.primary,
          ),
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(5)),
            child: IconButton(
              onPressed: () {
                routesController.goToBarcodeScannerPage();
              },
              icon: const Icon(Icons.add_box_outlined),
              color: AppColors.background,
            ),
          ),
          IconButton(
              onPressed: () {
                homeController.setPage(1);
                setState(() {});
              },
              icon: const Icon(Icons.description_outlined)),
        ]),
      ),
    );
  }
}
