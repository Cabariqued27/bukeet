import 'package:animate_do/animate_do.dart';
import 'package:bukeet/assets/app_assets.dart';
import 'package:bukeet/modules/authentication/controllers/reset_password_controller.dart';
import 'package:bukeet/utils/app/app_margin.dart';
import 'package:bukeet/utils/app/app_size.dart';
import 'package:bukeet/utils/buttons/gradient_button_widget.dart';
import 'package:bukeet/widgets/buttons/icon_gradient_button_widget.dart';
import 'package:bukeet/widgets/buttons/timer_button_gradient_widget.dart';
import 'package:bukeet/widgets/images/asset_image_widget.dart';
import 'package:bukeet/widgets/inputs/otp_input_widget.dart';
import 'package:bukeet/widgets/inputs/password_input_widget.dart';
import 'package:bukeet/widgets/inputs/single_input_widget.dart';
import 'package:bukeet/widgets/responsive/responsive_widget.dart';
import 'package:bukeet/widgets/responsive/web_frame_widget.dart';
import 'package:bukeet/widgets/text/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordPage extends StatelessWidget {
  final ResetPasswordController controller;

  const ResetPasswordPage({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      desktop: WebFrameWidget(
        child: _mobileContent(),
      ),
      tablet: WebFrameWidget(
        child: _mobileContent(),
      ),
      mobile: _mobileContent(),
    );
  }

  Widget _mobileContent() {
    return Obx(
      () => Scaffold(
        body: _pageWidget(),
        backgroundColor: controller.theme.background.value,
      ),
    );
  }

  Widget _pageWidget() {
    return SingleChildScrollView(
      physics: const ScrollPhysics(),
      child: SizedBox(
        width: AppSize.width(),
        height: AppSize.height(),
        child: Stack(
          children: [
            AssetImageWidget(
              pathImage: AppImages.started,
              width: AppSize.width(),
              height: AppSize.height(),
            ),
            _menuWidget(),
            Container(
              width: AppSize.width(),
              height: AppSize.height(),
              margin: EdgeInsets.symmetric(
                vertical: AppMargin.vertical(),
                horizontal: AppMargin.horizontal(),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
                  _logoWidget(),
                  const SizedBox(),
                  const SizedBox(),
                  const SizedBox(),
                  const SizedBox(),
                  const SizedBox(),
                  const SizedBox(),
                  const SizedBox(),
                  const SizedBox(),
                  const SizedBox(),
                  const SizedBox(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuWidget() {
    return Positioned.fill(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: _widgetContent(),
      ),
    );
  }

  Widget _widgetContent() {
    return AnimatedContainer(
      width: AppSize.width(),
      height: controller.determineHeight(),
      duration: const Duration(milliseconds: 0),
      padding: EdgeInsets.only(
        top: AppMargin.vertical() * 0.5,
        left: AppMargin.horizontal() * 0.5,
        right: AppMargin.horizontal() * 0.5,
        bottom: AppMargin.vertical() * 1.1,
      ),
      decoration: BoxDecoration(
        color: controller.theme.backgroundDeviceSetting.value,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 6,
            offset: const Offset(0, 0),
            color: controller.theme.backgroundDeviceSetting.value,
          ),
        ],
      ),
      child: _contentWidget(),
    );
  }

  Widget _contentWidget() {
    var state = controller.state.value;

    if (state == ResetPasswordState.validateOtp) {
      return _validateCodeWidget();
    } else if (state == ResetPasswordState.createPassword) {
      return _fullPasswordWidget();
    } else if (state == ResetPasswordState.login) {
      return _sendOtpEmailWidget();
    }

    return const SizedBox();
  }

  Widget _logoWidget() {
    return Column(
      children: [
        /*SvgAssetWidget(
          width: AppSize.width() * 0.57,
          height: AppSize.width() * 0.18,
          color: controller.theme.black.value,
          path: AppLogos.breethlyCompleteLogo,
        ),*/
        TextWidget(
          'bukeet'.tr,
          fontFamily: AppFontFamily.workSans,
          fontWeight: TextWidgetWeight.bold,
          dsize: RelSize(size: TextWidgetSizes.xxxxlarge),
          color: controller.theme.black.value,
          textAlign: TextAlign.left,
          height: 1,
        ),
      ],
    );
  }

  Widget _fullPasswordWidget() {
    return FadeIn(
      delay: const Duration(milliseconds: 500),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _textWidget('set_a_password', 'password_help'),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _passwordInputWidget(),
              _textInputWidget(
                'must_have',
                controller.theme.mustHaveColorText.value,
              ),
              _confirmpasswordInputWidget(),
            ],
          ),
          _setPasswordButtonWidget(),
          _buttonText(
            'already',
            'login_in',
            ResetPasswordState.login,
          ),
        ],
      ),
    );
  }

  Widget _setPasswordButtonWidget() {
    return SizedBox(
      width: AppSize.width() * 0.9,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconGradientButtonWidget(
            fontFamily: AppFontFamily.workSans,
            textSize: TextWidgetSizes.small,
            gradient: controller.theme.refreshBackgroundExplore.value,
            disableColor: controller.theme.disable.value,
            onPressed: () {
              controller.resetOtpValues();
              controller.updateState(ResetPasswordState.validateOtp);
            },
            isActive: true,
            height: 55.0,
            width: AppSize.width() * 0.15,
            iconRigth: AppIcons.leftArrow,
            iconSize: 20,
            iconColor: controller.theme.primary.value,
          ),
          GradientButtonWidget(
            fontFamily: AppFontFamily.workSans,
            textSize: TextWidgetSizes.small,
            gradient: controller.theme.refreshBackgroundExplore.value,
            disableColor: controller.theme.disable.value,
            textColor: controller.theme.text.value,
            onPressed: () => controller.onChangePassword(),
            isActive: controller.activeNextPassword.value,
            title: 'set_password'.tr,
            height: 55.0,
            width: AppSize.width() * 0.72,
            iconRigth: AppIcons.rightArrowPopUp,
            iconSize: 20,
            iconColor: controller.theme.black.value,
          ),
        ],
      ),
    );
  }

  Widget _passwordInputWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PasswordInputWidget(
          maxLength: 12,
          hintText: 'create_a_password'.tr,
          textInputType: TextInputType.visiblePassword,
          controller: controller.passwordOtpController,
          onChanged: (value) => controller.onChangeOtpPassword(),
          isVisible: controller.showPassword.value,
          onToggleVisibility: () => controller.updateShowPassword(),
        ),
        (controller.signUpPasswordWarning.value)
            ? TextWidget(
                'password_check'.tr,
                fontFamily: AppFontFamily.workSans,
                color: controller.theme.primary.value,
                textAlign: TextAlign.start,
                dsize: RelSize(
                  size: TextWidgetSizes.xsmall,
                ),
                textOverflow: TextOverflow.clip,
              )
            : const SizedBox(),
      ],
    );
  }

  Widget _sendOtpEmailWidget() {
    return FadeIn(
      delay: const Duration(milliseconds: 500),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(),
          _textWidget('reset_password', 'enter_your_email'),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _textInputWidget("email_address", controller.theme.black.value),
              SizedBox(height: AppSize.height() * 0.005),
              _emailInputWidgetLogin(),
            ],
          ),
          _sendOtpButtonWidget(),
          SizedBox(height: AppSize.height() * 0.037),
          const SizedBox(),
        ],
      ),
    );
  }

  Widget _emailInputWidgetLogin() {
    return SingleInputWidget(
      isActive: true,
      mandatory: false,
      hintText: "yourname@".tr,
      textInputType: TextInputType.emailAddress,
      controller: controller.emailOtpController,
      onChanged: (value) => controller.onChangedOtpForm(),
    );
  }

  Widget _sendOtpButtonWidget() {
    return GradientButtonWidget(
      fontFamily: AppFontFamily.workSans,
      textSize: TextWidgetSizes.small,
      gradient: controller.theme.refreshBackgroundExplore.value,
      disableColor: controller.theme.disable.value,
      textColor: controller.theme.text.value,
      onPressed: () => controller.onSendOtp(),
      isActive: controller.activeNextSendOtp.value,
      title: 'send_otp_email'.tr,
      height: 55.0,
      width: double.infinity,
      iconRigth: AppIcons.rightArrowPopUp,
      iconSize: 20,
      iconColor: controller.theme.black.value,
    );
  }

  Widget _textInputWidget(String text, Color color) {
    return TextWidget(
      text.tr,
      fontFamily: AppFontFamily.workSans,
      textAlign: TextAlign.center,
      fontWeight: TextWidgetWeight.medium,
      dsize: RelSize(
        size: TextWidgetSizes.xsmall,
      ),
      color: color,
    );
  }

  Widget _validateCodeWidget() {
    return FadeIn(
      delay: const Duration(milliseconds: 500),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _textCodeWidget(),
          _codeInputWidget(),
          _invalidCodeWidget(),
          _codeButtonWidget(),
          _buttonTextCode(
            'wrong_email',
            'go_back',
            ResetPasswordState.login,
          ),
        ],
      ),
    );
  }

  Widget _invalidCodeWidget() {
    return (controller.showInvalidOtpMessage.value)
        ? TextWidget(
            'the_code_entered'.tr,
            fontFamily: AppFontFamily.workSans,
            textAlign: TextAlign.center,
            dsize: RelSize(size: TextWidgetSizes.xxsmall),
            color: controller.theme.redSolid.value,
            textOverflow: TextOverflow.clip,
          )
        : const SizedBox();
  }

  Widget _codeButtonWidget() {
    return TimerGradientButtonWidget(
      textSize: TextWidgetSizes.small,
      fontFamily: AppFontFamily.workSans,
      gradient: controller.theme.refreshGradient.value,
      disableColor: controller.theme.disable.value,
      textColor: controller.theme.text.value,
      onPressed: () => controller.onReSendOtpCode(),
      onEndTime: () => controller.onEndOtpTime(),
      isActive: controller.activeRequestOtp.value,
      endTime: controller.reSendOtpTime.value,
      title: 'send_new_code'.tr,
      height: 50.0,
      width: double.infinity,
    );
  }

  Widget _buttonTextCode(String text, String text2, var value) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: FittedBox(
                child: Row(
                  children: [
                    SizedBox(width: AppSize.width() * 0.27),
                    TextWidget(
                      text.tr,
                      fontWeight: FontWeight.w500,
                      fontFamily: AppFontFamily.workSans,
                      textAlign: TextAlign.center,
                      dsize: RelSize(
                        size: TextWidgetSizes.small,
                      ),
                      color: controller.theme.textStarted.value,
                    ),
                    SizedBox(width: AppSize.width() * 0.01),
                    GestureDetector(
                      onTap: () {
                        controller.resetOtpValues();
                        controller.updateState(value);
                      },
                      child: TextWidget(
                        text2.tr,
                        fontWeight: FontWeight.w500,
                        fontFamily: AppFontFamily.workSans,
                        textAlign: TextAlign.center,
                        dsize: RelSize(
                          size: TextWidgetSizes.small,
                        ),
                        color: controller.theme.primary.value,
                      ),
                    ),
                    SizedBox(width: AppSize.width() * 0.27),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _codeInputWidget() {
    return OtpInputWidget(
      theme: controller.theme,
      hasInvalidCode: controller.showInvalidOtpMessage.value,
      codeController: controller.otpInputController,
      onCompleteCode: () => controller.onValidateOtp(),
      onChanged: () {},
    );
  }

  Widget _textCodeWidget() {
    return SizedBox(
      width: AppSize.width() * 0.9,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              TextWidget(
                'lets_confirm'.tr,
                fontFamily: AppFontFamily.leagueSpartan,
                textAlign: TextAlign.center,
                fontWeight: TextWidgetWeight.bold,
                dsize: RelSize(
                  size: TextWidgetSizes.large,
                ),
                color: controller.theme.grayDark.value,
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(
                width: AppSize.width() * 0.9,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      'confirm_email'.tr,
                      fontFamily: AppFontFamily.leagueSpartan,
                      textAlign: TextAlign.start,
                      fontWeight: TextWidgetWeight.light,
                      dsize: RelSize(
                        size: TextWidgetSizes.small,
                      ),
                      color: controller.theme.grayDark.value,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              style: onlyTextStyle(
                                fontFamily: AppFontFamily.leagueSpartan,
                                fontWeight: TextWidgetWeight.light,
                                dsize: RelSize(size: TextWidgetSizes.small),
                                color: controller.theme.grayDark.value,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: controller.emailOtpController.text,
                                  style: onlyTextStyle(
                                    fontFamily: AppFontFamily.leagueSpartan,
                                    fontWeight: TextWidgetWeight.bold,
                                    dsize: RelSize(size: TextWidgetSizes.small),
                                    color: controller.theme.grayDark.value,
                                  ),
                                ),
                                TextSpan(
                                  text: 'second_confirm_email'.tr,
                                ),
                                TextSpan(
                                  text: 'third_confirm_email'.tr,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _textWidget(String text, String text2) {
    return SizedBox(
      width: AppSize.width() * 0.9,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              TextWidget(
                text.tr,
                fontFamily: AppFontFamily.leagueSpartan,
                textAlign: TextAlign.center,
                fontWeight: TextWidgetWeight.bold,
                dsize: RelSize(
                  size: TextWidgetSizes.large,
                ),
                color: controller.theme.text.value,
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(
                width: AppSize.width() * 0.85,
                child: TextWidget(
                  text2.tr,
                  fontFamily: AppFontFamily.workSans,
                  textAlign: TextAlign.start,
                  fontWeight: TextWidgetWeight.normal,
                  dsize: RelSize(
                    size: TextWidgetSizes.xsmall,
                  ),
                  color: controller.theme.grayDark.value,
                  maxLines: 3,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _confirmpasswordInputWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PasswordInputWidget(
          maxLength: 12,
          hintText: 'con_password'.tr,
          controller: controller.confirmPasswordOtpController,
          onChanged: (value) => controller.onChangeOtpPassword(),
          isVisible: controller.showConfirmPassword.value,
          onToggleVisibility: () => controller.updateShowConfirmPassword(),
        ),
        (controller.signUpConfirmPasswordWarning.value)
            ? TextWidget(
                'confirm_password_check'.tr,
                fontFamily: AppFontFamily.workSans,
                color: controller.theme.primary.value,
                textAlign: TextAlign.start,
                dsize: RelSize(
                  size: TextWidgetSizes.xsmall,
                ),
                textOverflow: TextOverflow.clip,
              )
            : const SizedBox(),
      ],
    );
  }

  Widget _buttonText(String text, String text2, var value) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: FittedBox(
                child: Row(
                  children: [
                    SizedBox(width: AppSize.width() * 0.2),
                    TextWidget(
                      text.tr,
                      fontWeight: FontWeight.w500,
                      fontFamily: AppFontFamily.workSans,
                      textAlign: TextAlign.center,
                      dsize: RelSize(
                        size: TextWidgetSizes.small,
                      ),
                      color: controller.theme.textStarted.value,
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.resetOtpValues();
                        controller.updateState(value);
                      },
                      child: TextWidget(
                        text2.tr,
                        fontWeight: FontWeight.w500,
                        fontFamily: AppFontFamily.workSans,
                        textAlign: TextAlign.center,
                        dsize: RelSize(
                          size: TextWidgetSizes.small,
                        ),
                        color: controller.theme.primary.value,
                      ),
                    ),
                    SizedBox(width: AppSize.width() * 0.2),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
