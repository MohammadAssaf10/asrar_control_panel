import 'package:asrar_control_panel/config/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/routes_manager.dart';
import '../../../../config/strings_manager.dart';
import '../../../../core/app/functions.dart';
import '../../../auth/presentation/bloc/authentication_bloc.dart';
import '../../../chat/presentation/bloc/support_chat/support_chat_bloc.dart';
import '../../../employees_manager/presentation/employee_management_bloc/employee_management_bloc.dart';
import '../blocs/service_order/service_order_bloc.dart';
import '../blocs/shop_order_bloc/shop_order_bloc.dart';
import '../widgets/control_panel_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authState = BlocProvider.of<AuthenticationBloc>(context).state;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(AppStrings.asrarControlPanel.tr(context)),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              ControlPanelButton(
                  buttonTitle: AppStrings.addAnAdvertisementImage.tr(context),
                  onTap: () {
                    if (authState is AuthenticationSuccess) {
                      if (authState.employee.permissions.addsManagement) {
                        Navigator.pushNamed(
                            context, Routes.addAnAdvertisementImageRoute);
                      } else {
                        permissionsDialog(context);
                      }
                    }
                  }),
              ControlPanelButton(
                  buttonTitle: AppStrings.shop.tr(context),
                  onTap: () {
                    if (authState is AuthenticationSuccess) {
                      if (authState.employee.permissions.storeManagement) {
                        Navigator.pushNamed(
                          context,
                          Routes.shopRoute,
                        );
                      }
                    }
                  }),
              ControlPanelButton(
                buttonTitle: AppStrings.courses.tr(context),
                onTap: () {
                  if (authState is AuthenticationSuccess) {
                    if (authState.employee.permissions.coursesManagement) {
                      Navigator.pushNamed(context, Routes.coursesRoute);
                    } else {
                      permissionsDialog(context);
                    }
                  }
                },
              ),
              ControlPanelButton(
                buttonTitle: AppStrings.subscriptions.tr(context),
                onTap: () {
                  if (authState is AuthenticationSuccess) {
                    if (authState.employee.permissions.canWork) {
                      Navigator.pushNamed(context, Routes.subscriptionRoute);
                    } else {
                      permissionsDialog(context);
                    }
                  }
                },
              ),
              ControlPanelButton(
                buttonTitle: AppStrings.aboutUs.tr(context),
                onTap: () {
                  if (authState is AuthenticationSuccess) {
                    if (authState.employee.permissions.canWork) {
                      Navigator.pushNamed(context, Routes.aboutUsRoute);
                    } else {
                      permissionsDialog(context);
                    }
                  }
                },
              ),
              ControlPanelButton(
                buttonTitle: AppStrings.employeesRequests.tr(context),
                onTap: () {
                  if (authState is AuthenticationSuccess) {
                    if (authState.employee.permissions.employeeManagement) {
                      BlocProvider.of<EmployeeManagementBloc>(context)
                          .add(GetEmployeesRequests());
                      Navigator.pushNamed(
                        context,
                        Routes.employeeRequestRoute,
                      );
                    } else {
                      permissionsDialog(context);
                    }
                  }
                },
              ),
              ControlPanelButton(
                buttonTitle: AppStrings.support.tr(context),
                onTap: () {
                  if (authState is AuthenticationSuccess) {
                    if (authState.employee.permissions.technicalSupport) {
                      BlocProvider.of<SupportChatBloc>(context)
                          .add(GetSender());
                      Navigator.pushNamed(context, Routes.supportRoute);
                    } else {
                      permissionsDialog(context);
                    }
                  }
                },
              ),
              ControlPanelButton(
                buttonTitle: AppStrings.signOut.tr(context),
                onTap: () {
                  if (authState is AuthenticationSuccess) {
                    BlocProvider.of<AuthenticationBloc>(context).add(LogOut());
                    Navigator.pushReplacementNamed(context, Routes.loginRoute);
                  }
                },
              ),
            ],
          ),
          Column(
            children: [
              ControlPanelButton(
                  buttonTitle: AppStrings.services.tr(context),
                  onTap: () {
                    if (authState is AuthenticationSuccess) {
                      if (authState.employee.permissions.companyManagement) {
                        Navigator.pushNamed(context, Routes.servicesRoute);
                      } else {
                        permissionsDialog(context);
                      }
                    }
                  }),
              ControlPanelButton(
                  buttonTitle: AppStrings.news.tr(context),
                  onTap: () {
                    if (authState is AuthenticationSuccess) {
                      if (authState.employee.permissions.newsManagement) {
                        Navigator.pushNamed(context, Routes.newsRoute);
                      } else {
                        permissionsDialog(context);
                      }
                    }
                  }),
              ControlPanelButton(
                  buttonTitle: AppStrings.jobs.tr(context),
                  onTap: () {
                    if (authState is AuthenticationSuccess) {
                      if (authState.employee.permissions.canWork) {
                        Navigator.pushNamed(context, Routes.jobRoute);
                      } else {
                        permissionsDialog(context);
                      }
                    }
                  }),
              ControlPanelButton(
                  buttonTitle: AppStrings.shopOrder.tr(context),
                  onTap: () {
                    if (authState is AuthenticationSuccess) {
                      if (authState.employee.permissions.storeManagement) {
                        BlocProvider.of<ShopOrderBloc>(context)
                            .add(GetShopOrderEvent());
                        Navigator.pushNamed(context, Routes.shopOrderRoute);
                      } else {
                        permissionsDialog(context);
                      }
                    }
                  }),
              ControlPanelButton(
                  buttonTitle: AppStrings.termsOfUse.tr(context),
                  onTap: () {
                    if (authState is AuthenticationSuccess) {
                      if (authState.employee.permissions.canWork) {
                        Navigator.pushNamed(context, Routes.termsOfUseRoute);
                      } else {
                        permissionsDialog(context);
                      }
                    }
                  }),
              ControlPanelButton(
                buttonTitle: AppStrings.serviceOrdersChat.tr(context),
                onTap: () {
                  if (authState is AuthenticationSuccess) {
                    if (authState.employee.permissions.technicalSupport) {
                      BlocProvider.of<ServiceOrderBloc>(context)
                          .add(GetServiceOrder());
                      Navigator.pushNamed(context, Routes.serviceOrderRoute);
                    } else {
                      permissionsDialog(context);
                    }
                  }
                },
              ),
              ControlPanelButton(
                buttonTitle: AppStrings.employeeManagement.tr(context),
                onTap: () {
                  if (authState is AuthenticationSuccess) {
                    if (authState.employee.permissions.employeeManagement) {
                      BlocProvider.of<EmployeeManagementBloc>(context)
                          .add(FetchEmployeesList());
                      Navigator.pushNamed(context, Routes.employeeList);
                    } else {
                      permissionsDialog(context);
                    }
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
