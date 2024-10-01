import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:parmosys_flutter/feature/parmosys_drawer/widgets/parmosys_drawer_button.dart';
import 'package:parmosys_flutter/gen/assets.gen.dart';
import 'package:parmosys_flutter/utils/const.dart';
import 'package:parmosys_flutter/utils/strings.dart';
import 'package:parmosys_flutter/utils/styles.dart';
import 'package:parmosys_flutter/widgets/spacings.dart';

class ParmosysDrawer extends StatelessWidget {
  const ParmosysDrawer({super.key});

  void _onPressExit(BuildContext context) => context.goNamed(initialRoute);

  @override
  Widget build(BuildContext context) {
    final medium = TextStyles.medium.copyWith(color: Colors.black);
    const verticalSpace = VerticalSpace(space: 28.0);

    return Drawer(
      backgroundColor: Colors.white,
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
            style: TextStyles.black.copyWith(color: Colors.black),
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
                        value: false,
                        // TODO: Add function
                        onChanged: (_) {},
                        inactiveThumbColor: Colors.black,
                        trackColor: const WidgetStatePropertyAll(Colors.white),
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
                  suffix: Text(
                    gridViewValue,
                    style: medium.copyWith(color: viewModeTextColor),
                  ),
                ),
                verticalSpace,
                const ParmosysDrawerButton(
                  label: aboutLabel,
                  iconColor: categoryPageBackgroundColor,
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
        ],
      ),
    );
  }
}
