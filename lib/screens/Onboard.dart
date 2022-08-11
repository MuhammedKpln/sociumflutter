import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scflutter/components/RoundedButton.dart';
import 'package:scflutter/components/Scaffold.dart';
import 'package:scflutter/extensions/i18n.dart';
import 'package:scflutter/state/auth.dart';
import 'package:scflutter/storage/auth.storage.dart';
import 'package:scflutter/theme/animation_durations.dart';
import 'package:scflutter/utils/router.gr.dart';

class OnboardScreenPage extends ConsumerStatefulWidget {
  const OnboardScreenPage({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<OnboardScreenPage> {
  int carouselIndex = 0;

  @override
  void initState() {
    super.initState();

    _login();
  }

  Future<void> _login() async {
    final accessToken = await getAccessToken();
    final refreshToken = await getRefreshToken();

    if (accessToken != null) {
      final user = await getUser();

      if (user != null) {
        final model = AuthStateModel(
            accessToken: accessToken, refreshToken: refreshToken, user: user);
        final authState = ref.read(userProvider.notifier);
        await authState.setUser(model);

        context.router.replace(const HomeScreenRoute());
      }
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
              Text(context.locale!.onboardBottomSheetTitleText,
                  style: Theme.of(context).textTheme.titleMedium),
              RoundedButton(
                onPressed: () => null,
                icon: SvgPicture.asset(
                  "assets/google.svg",
                  width: 20,
                  color: Colors.white,
                ),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(const Color(0xffDB4437))),
                child: Text(!registering
                    ? context.locale!.onboardLoginWithGoogleBtnTxt
                    : context.locale!.onboardRegisterWithGoogleBtnTxt),
              ),
              RoundedButton(
                onPressed: () => null,
                icon: const Icon(Icons.apple),
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(Colors.black),
                    backgroundColor: MaterialStateProperty.all(Colors.white)),
                child: Text(!registering
                    ? context.locale!.onboardLoginWithAppleBtnTxt
                    : context.locale!.onboardRegisterWithAppleBtnTxt),
              ),
              RoundedButton(
                icon: const Icon(Icons.mail_outline),
                onPressed: () => !registering
                    ? context.router.push(const LoginScreenRoute())
                    : context.router.push(const RegisterScreenStepOneRoute()),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black)),
                child: Text(!registering
                    ? context.locale!.onboardLoginWithEmailBtnTxt
                    : context.locale!.onboardRegisterWithEmailBtnTxt),
              )
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
                      child: Text(context.locale!.onboardStartBtnText)),
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
                      child: Text(context.locale!.onboardLoginBtnText)),
                ),
              ],
            ),
            Text(
              context.locale!.onboardPrivacyPolicyText,
              style: const TextStyle(color: Colors.grey, fontSize: 13),
            )
          ],
        ));
  }

  CarouselSlider renderCarousel() {
    return CarouselSlider.builder(
      itemBuilder: (context, int index, int pageViewIndex) {
        String image = "assets/meet.svg";
        String description = context.locale!.onboardSliderFirst;

        switch (index) {
          case 1:
            image = "assets/explore.svg";
            description = context.locale!.onboardSliderSecond;
            break;

          case 2:
            image = "assets/touch.svg";
            description = context.locale!.onboardSliderThird;
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
