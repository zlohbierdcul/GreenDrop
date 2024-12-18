import 'package:flutter/material.dart';
import 'package:greendrop/src/domain/models/user.dart';
import 'package:greendrop/src/presentation/account/widgets/user_address_add.dart';
import 'package:greendrop/src/presentation/account/widgets/user_address_list.dart';
import 'package:greendrop/src/presentation/account/widgets/user_details.dart';
import 'package:greendrop/src/presentation/account/widgets/user_logout.dart';
import 'package:greendrop/src/presentation/account/widgets/user_settings.dart';
import 'package:greendrop/src/presentation/common_widgets/center_constrained_body.dart';
import 'package:provider/provider.dart';
import '../../common_widgets/app_drawer.dart';
import '../provider/account_data_provider.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  static final TextEditingController _userNameController =
      TextEditingController();
  static final TextEditingController _firstNameController =
      TextEditingController();
  static final TextEditingController _lastNameController =
      TextEditingController();
  static final TextEditingController _emailController = TextEditingController();
  static final TextEditingController _streetController =
      TextEditingController();
  static final TextEditingController _houseNumberController =
      TextEditingController();
  static final TextEditingController _plzController = TextEditingController();
  static final TextEditingController _cityController = TextEditingController();

  void _initializeControllers(AccountProvider accountProvider) {
    User user = accountProvider.user ?? User.genericUser;
    _userNameController.text = user.userName;
    _firstNameController.text = user.firstName;
    _lastNameController.text = user.lastName;
    _emailController.text = user.eMail;
    _streetController.text =
        user.addresses.isNotEmpty ? user.addresses[0].street : "-";
    _houseNumberController.text =
        user.addresses.isNotEmpty ? user.addresses[0].streetNumber : "-";
    _plzController.text =
        user.addresses.isNotEmpty ? user.addresses[0].zipCode : "-";
    _cityController.text =
        user.addresses.isNotEmpty ? user.addresses[0].city : "-";
  }


  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<AccountProvider>(context, listen: false);
      provider.loadAccountData();
      _initializeControllers(provider);
    });
    return Scaffold(
      appBar: AppDrawer.buildGreendropsAppBar(context),
      body: const CenterConstrainedBody(
        body: Center(
          child: Column(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: SizedBox(
                          width: double.infinity,
                          height: 60,
                          child: Card(
                            child: Center(
                              child: Text(
                                "Account",
                                style: TextStyle(fontSize: 24),
                              ),
                            ),
                          ),
                        ),
                      ),
                      UserSettings(),
                      UserDetails(),
                      UserAddressList(),
                      UserAddressAdd(),
                      UserLogout()
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
