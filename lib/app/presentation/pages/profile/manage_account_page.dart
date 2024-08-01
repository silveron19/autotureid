import 'package:autotureid/app/presentation/provider/auth_notifier.dart';
import 'package:autotureid/app/presentation/widgets/global/circular_loading_indicator.dart';
import 'package:autotureid/app/presentation/widgets/profile/manage_account_tile.dart';
import 'package:autotureid/const/resource.dart';
import 'package:autotureid/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ManageAccountPage extends StatefulWidget {
  const ManageAccountPage({super.key});

  @override
  State<ManageAccountPage> createState() => _ManageAccountPageState();
}

class _ManageAccountPageState extends State<ManageAccountPage> {
  @override
  void initState() {
    Provider.of<AuthNotifier>(context, listen: false).logoutState.reset();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthNotifier>(
      builder: (context, auth, child) {
        final state = auth.logoutState;
        if (state.isError()) {
          Fluttertoast.showToast(
            msg: state.failure!,
            toastLength: Toast.LENGTH_SHORT,
          );
        } else {
          if (state.isSuccess()) {
            Future.microtask(() => context.go('/login'));
            Fluttertoast.showToast(
              msg: 'Berhasil log out',
              toastLength: Toast.LENGTH_SHORT,
            );
          }
        }
        return Stack(
          children: [
            Scaffold(
              appBar: AppBar(
                title: const Text('Atur Akun'),
              ),
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: kDefaultPadding),
                  child: Column(
                    children: [
                      ManageAccountTile(
                        title: 'Ganti Password',
                        subtitle: 'Coba ingat kembali password sebelumnya, sebelum menggantinya',
                        image: R.ASSETS_ICONS_RESET_PASSWORD_PNG,
                        onTap: () => context.push('/profile/manage-account/reset-password'),
                      ),
                      ManageAccountTile(
                        title: 'Log out',
                        subtitle: 'Ingin keluar dari akun? Pastikan tau untuk kembali, ya.',
                        image: R.ASSETS_ICONS_LOGOUT_PNG,
                        onTap: () => auth.logout(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (state.isLoading())
              Container(
                color: Colors.black.withOpacity(0.5),
                child: const CircularLoadingIndicator(),
              ),
          ],
        );
      },
    );
  }
}
