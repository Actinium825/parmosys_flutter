import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:parmosys_flutter/feature/parmosys_drawer/widgets/parmosys_drawer_button.dart';
import 'package:parmosys_flutter/gen/assets.gen.dart';
import 'package:parmosys_flutter/providers/selected_theme_provider.dart';
import 'package:parmosys_flutter/utils/const.dart';
import 'package:parmosys_flutter/utils/extension.dart';
import 'package:parmosys_flutter/utils/strings.dart';
import 'package:parmosys_flutter/utils/styles.dart';
import 'package:parmosys_flutter/widgets/spacings.dart';

class ParmosysDrawer extends ConsumerWidget {
  const ParmosysDrawer({super.key});

  void _onPressExit(BuildContext context) => context.goNamed(initialRoute);

  Future<String> get _getVersionNumber async {
    final packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  void _onChangeThemeMode(WidgetRef ref, bool isDarkMode) =>
      ref.read(selectedThemeProvider.notifier).changeThemeMode(isDarkMode);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = context.isDarkMode;
    final medium = TextStyles.medium.copyWith(color: isDarkMode ? Colors.white : Colors.black);
    const verticalSpace = VerticalSpace(space: 28.0);

    return Drawer(
      backgroundColor: isDarkMode ? drawerDarkColor : Colors.white,
      child: Column(
        children: [
          const Spacer(),
          Image.asset(
            Assets.png.logo.path,
            scale: logoScale,
            color: logoColor,
          ),
          const VerticalSpace(space: 20.0),
          Text(
            drawerHeader,
            style: TextStyles.black.copyWith(color: isDarkMode ? Colors.white : Colors.black),
          ),
          const VerticalSpace(space: 4.0),
          Text(
            drawerHeader,
            style: medium,
          ),
          const VerticalSpace(space: 48.0),
          Padding(
            padding: drawerBodyPadding,
            child: Column(
              children: [
                ParmosysDrawerButton(
                  label: darkModeLabel,
                  iconColor: Colors.yellow,
                  icon: Icons.dark_mode_rounded,
                  suffix: SizedBox(
                    height: drawerButtonsIconSize,
                    child: FittedBox(
                      child: Switch(
                        value: ref.read(selectedThemeProvider) == ThemeMode.dark,
                        onChanged: (isDarkMode) => _onChangeThemeMode(ref, isDarkMode),
                        inactiveThumbColor: Colors.black,
                        activeColor: Colors.white,
                        trackColor: WidgetStatePropertyAll(isDarkMode ? drawerDarkColor : Colors.white),
                        trackOutlineColor: const WidgetStatePropertyAll(Colors.transparent),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                  ),
                ),
                verticalSpace,
                ParmosysDrawerButton(
                  // TODO: Add function
                  onTap: () {},
                  label: viewLabel,
                  icon: Icons.visibility,
                  iconColor: isDarkMode ? Colors.black : Colors.white,
                  suffix: Text(
                    gridViewValue,
                    style: medium.copyWith(color: viewModeTextColor),
                  ),
                ),
                verticalSpace,
                const ParmosysDrawerButton(
                  label: aboutLabel,
                  iconColor: lightBackgroundColor,
                  icon: Icons.info,
                ),
                verticalSpace,
                ParmosysDrawerButton(
                  label: exitLabel,
                  onTap: () => _onPressExit(context),
                  iconColor: Colors.red,
                  icon: Icons.exit_to_app_rounded,
                ),
              ],
            ),
          ),
          const Spacer(),
          FutureBuilder<String>(
            future: _getVersionNumber,
            builder: (_, snapshot) => Text(
              'v ${snapshot.data}',
              style: medium.copyWith(fontSize: 16.0),
            ),
          ),
          const VerticalSpace(space: 8.0),
        ],
      ),
    );
  }
}
