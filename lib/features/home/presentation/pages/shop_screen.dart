import 'package:asrar_control_panel/config/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/routes_manager.dart';
import '../../../../config/strings_manager.dart';
import '../blocs/product/bloc/product_bloc.dart';
import '../widgets/control_panel_button.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              ControlPanelButton(
                buttonTitle: AppStrings.addProduct.tr(context),
                onTap: () {
                  Navigator.pushNamed(context, Routes.addProductRoute);
                },
              ),
            ],
          ),
          Column(
            children: [
              ControlPanelButton(
                buttonTitle: AppStrings.products.tr(context),
                onTap: () {
                  BlocProvider.of<ProductBloc>(context)
                      .add(GetProductsListEvent());
                  Navigator.pushNamed(context, Routes.productsRoute);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
