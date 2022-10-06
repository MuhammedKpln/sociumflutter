import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scflutter/components/RoundedButton.dart';
import 'package:scflutter/components/Scaffold.dart';
import 'package:scflutter/models/user.dart';
import 'package:scflutter/repositories/auth.repository.dart';
import 'package:scflutter/state/auth.state.dart';
import 'package:scflutter/theme/animation_durations.dart';
import 'package:scflutter/utils/router.gr.dart';
import 'package:easy_localization/easy_localization.dart' as es;
import 'package:supabase_flutter/supabase_flutter.dart';

class OnboardScreenPage extends ConsumerStatefulWidget {
  const OnboardScreenPage({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<OnboardScreenPage> {
  int carouselIndex = 0;
  SupabaseClient supabase = Supabase.instance.client;
  final AuthRepository _authRepository = AuthRepository();

  @override
  void initState() {
    super.initState();

    _login();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _updateState(UserModel user) {
    final model = AuthStateModel(
        accessToken: supabase.auth.currentSession?.accessToken,
        refreshToken: supabase.auth.currentSession?.refreshToken,
        rawUser: supabase.auth.currentUser,
        user: user);
    ref.read(userProvider.notifier).setUser(model);
  }

  _login() async {
    final currentUser = supabase.auth.currentUser;
    if (currentUser != null) {
      final user =
          await _authRepository.getUserProfile(userUuid: currentUser.id);

      if (user != null) {
        _updateState(user);
      }

      context.router.replace(const HomeScreenRoute());
    }
  }

  Widget renderCarouselCurrentPage() {
    List<Widget> list = [];

    for (var i = 0; i < 3; i++) {
      list.add(AnimatedContainer(
        duration: Duration(milliseconds: AnimationDurations.low.duration),
        padding: EdgeInsets.all(carouselIndex == i ? 5 : 3),
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
      ));
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: list,
    );
  }

  _buildBottomSheet({bool registering = false}) {
    return SizedBox(
        height: MediaQuery.of(context).size.height / 3,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("onboardBottomSheetTitleText",
                      style: Theme.of(context).textTheme.titleMedium)
                  .tr(),
              RoundedButton.icon(
                onPressed: () => null,
                icon: SvgPicture.asset(
                  "assets/google.svg",
                  width: 20,
                  color: Colors.white,
                ),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(const Color(0xffDB4437))),
                label: Text(!registering
                        ? "onboardLoginWithGoogleBtnTxt"
                        : "onboardRegisterWithGoogleBtnTxt")
                    .tr(),
              ),
              RoundedButton.icon(
                onPressed: () => null,
                icon: const Icon(Icons.apple),
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(Colors.black),
                    backgroundColor: MaterialStateProperty.all(Colors.white)),
                label: Text(!registering
                        ? "onboardLoginWithAppleBtnTxt"
                        : "onboardRegisterWithAppleBtnTxt")
                    .tr(),
              ),
              RoundedButton.icon(
                icon: const Icon(Icons.mail_outline),
                onPressed: () => !registering
                    ? context.router.push(const LoginScreenRoute())
                    : context.router.push(const RegisterScreenStepOneRoute()),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black)),
                label: Text(!registering
                        ? "onboardLoginWithEmailBtnTxt"
                        : "onboardRegisterWithEmailBtnTxt")
                    .tr(),
              ),
            ],
          ),
        ));
  }

  void onPressLogin() {
    showModalBottomSheet(
        enableDrag: false,
        isScrollControlled: true,
        context: context,
        useRootNavigator: false,
        backgroundColor: const Color(0xFF212227),
        builder: ((context) => _buildBottomSheet()));
  }

  void onPressRegister() {
    showModalBottomSheet(
        enableDrag: false,
        isScrollControlled: true,
        context: context,
        useRootNavigator: false,
        backgroundColor: const Color(0xFF212227),
        builder: ((context) => _buildBottomSheet(registering: true)));
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        appBar: AppBar(
          title: SvgPicture.asset('assets/logo.svg'),
          elevation: 0,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            renderCarousel(),
            renderCarouselCurrentPage(),
            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: RoundedButton(
                      onPressed: onPressRegister,
                      child: const Text("onboardStartBtnText").tr()),
                ),
                SizedBox(
                  width: double.infinity,
                  child: RoundedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.transparent),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                          side: MaterialStateProperty.all(
                              const BorderSide(color: Colors.white))),
                      onPressed: onPressLogin,
                      child: const Text("onboardLoginBtnText").tr()),
                ),
              ],
            ),
            const Text(
              "onboardPrivacyPolicyText",
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ).tr()
          ],
        ));
  }

  CarouselSlider renderCarousel() {
    return CarouselSlider.builder(
      itemBuilder: (context, int index, int pageViewIndex) {
        String image = "assets/meet.svg";
        String description = "onboardSliderFirst".tr();

        switch (index) {
          case 1:
            image = "assets/explore.svg";
            description = "onboardSliderSecond".tr();
            break;

          case 2:
            image = "assets/touch.svg";
            description = "onboardSliderThird".tr();
        }

        return (Column(
          children: [
            SvgPicture.asset(
              image,
              height: 300,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Text(
                description,
                style: const TextStyle(fontSize: 20, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ));
      },
      itemCount: 3,
      options: CarouselOptions(
          autoPlay: false,
          enableInfiniteScroll: false,
          aspectRatio: 1,
          height: 400,
          viewportFraction: 1,
          onPageChanged: (index, reason) =>
              setState(() => carouselIndex = index)),
    );
  }
}
