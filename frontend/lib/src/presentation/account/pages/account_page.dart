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
import '../provider/user_provider.dart';

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

  void _initializeControllers(UserProvider userProvider) {
    User user = userProvider.user ?? User.genericUser;
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
      final provider = Provider.of<UserProvider>(context, listen: false);
      provider.loadAccountData();
      _initializeControllers(provider);
    });
    return Scaffold(
      appBar: AppDrawer.buildGreendropsAppBar(context),
      body: CenterConstrainedBody(
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Consumer<UserProvider>(
                    builder: (context, userProvider, child) => Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Padding(
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
                        if (userProvider.user != null) ...[
                          const UserSettings(),
                          const UserDetails(),
                          const UserAddressList(),
                          const UserAddressAdd(),
                        ] else
                          const CircularProgressIndicator(),
                        const UserLogout()
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
