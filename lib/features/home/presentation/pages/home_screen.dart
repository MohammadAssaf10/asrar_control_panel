import 'package:asrar_control_panel/config/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/routes_manager.dart';
import '../../../../config/strings_manager.dart';
import '../blocs/shop_order_bloc/shop_order_bloc.dart';
import '../widgets/control_panel_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.asrarControlPanel.tr(context)),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              ControlPanelButton(
                buttonTitle: AppStrings.addAnAdvertisementImage.tr(context),
                onTap: () => Navigator.pushNamed(
                    context, Routes.addAnAdvertisementImageRoute),
              ),
              ControlPanelButton(
                buttonTitle: AppStrings.shop.tr(context),
                onTap: () => Navigator.pushNamed(
                  context,
                  Routes.shopRoute,
                ),
              ),
              ControlPanelButton(
                buttonTitle: AppStrings.courses.tr(context),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    Routes.coursesRoute,
                  );
                },
              ),
              ControlPanelButton(
                buttonTitle: AppStrings.subscriptions.tr(context),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    Routes.subscriptionRoute,
                  );
                },
              ),
              ControlPanelButton(
                buttonTitle: AppStrings.aboutUs.tr(context),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    Routes.aboutUsRoute,
                  );
                },
              ),
            ],
          ),
          Column(
            children: [
              ControlPanelButton(
                buttonTitle: AppStrings.services.tr(context),
                onTap: () => Navigator.pushNamed(
                  context,
                  Routes.servicesRoute,
                ),
              ),
              ControlPanelButton(
                buttonTitle: AppStrings.news.tr(context),
                onTap: () => Navigator.pushNamed(
                  context,
                  Routes.newsRoute,
                ),
              ),
              ControlPanelButton(
                buttonTitle: AppStrings.jobs.tr(context),
                onTap: () => Navigator.pushNamed(
                  context,
                  Routes.jobRoute,
                ),
              ),
              ControlPanelButton(
                  buttonTitle: AppStrings.shopOrder.tr(context),
                  onTap: () {
                    BlocProvider.of<ShopOrderBloc>(context)
                        .add(GetShopOrderEvent());
                    Navigator.pushNamed(
                      context,
                      Routes.shopOrderRoute,
                    );
                  }),
              ControlPanelButton(
                  buttonTitle: AppStrings.termsOfUse.tr(context),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      Routes.termsOfUseRoute,
                    );
                  }),
            ],
          ),
        ],
      ),
    );
  }
}
