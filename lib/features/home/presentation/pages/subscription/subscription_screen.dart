import 'package:asrar_control_panel/config/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/routes_manager.dart';
import '../../../../../config/strings_manager.dart';
import '../../blocs/subscription_bloc/subscription_bloc.dart';
import '../../widgets/control_panel_button.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ControlPanelButton(
            buttonTitle: AppStrings.addSubscription.tr(context),
            onTap: () {
              Navigator.pushNamed(context, Routes.addSubscriptionRoute);
            },
          ),
          ControlPanelButton(
            buttonTitle: AppStrings.subscriptions.tr(context),
            onTap: () {
              BlocProvider.of<SubscriptionBloc>(context).add(
                GetSubscriptionsListEvent(),
              );
              Navigator.pushNamed(context, Routes.deleteSubscriptionRoute);
            },
          ),
        ],
      ),
    );
  }
}
