import 'package:animate_do/animate_do.dart';
import 'package:bukeet/assets/app_assets.dart';
import 'package:bukeet/modules/authentication/controllers/authentication_controller.dart';
import 'package:bukeet/utils/app/app_margin.dart';
import 'package:bukeet/utils/app/app_size.dart';
import 'package:bukeet/utils/buttons/gradient_button_widget.dart';
import 'package:bukeet/widgets/buttons/border_button_widget.dart';
import 'package:bukeet/widgets/buttons/icon_gradient_button_widget.dart';
import 'package:bukeet/widgets/buttons/timer_button_gradient_widget.dart';
import 'package:bukeet/widgets/images/asset_image_widget.dart';
import 'package:bukeet/widgets/inputs/date_input_widget.dart';
import 'package:bukeet/widgets/inputs/otp_input_widget.dart';
import 'package:bukeet/widgets/inputs/password_input_widget.dart';
import 'package:bukeet/widgets/inputs/single_input_widget.dart';
import 'package:bukeet/widgets/responsive/responsive_widget.dart';
import 'package:bukeet/widgets/responsive/web_frame_widget.dart';
import 'package:bukeet/widgets/text/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthenticationPage extends StatelessWidget {
  final AuthenticationController controller;

  const AuthenticationPage({
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
    var state = controller.state.value;
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
        color: (state == GetStartedLoginSignUpState.getStarted)
            ? controller.theme.white.value
            : controller.theme.backgroundDeviceSetting.value,
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

    if (state == GetStartedLoginSignUpState.getStarted) {
      return _getStartedWidget();
    } else if (state == GetStartedLoginSignUpState.registerEmail) {
      return _fullInformationWidget();
    } else if (state == GetStartedLoginSignUpState.validateOtp) {
      return _validateCodeWidget();
    } else if (state == GetStartedLoginSignUpState.createPassword) {
      return _fullPasswordWidget();
    } else if (state == GetStartedLoginSignUpState.login) {
      return _loginWidget();
    }

    return const SizedBox();
  }

  Widget _logoWidget() {
    return FadeIn(
      duration: const Duration(milliseconds: 1000),
      child: Column(
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
      ),
    );
  }

  Widget _fullPasswordWidget() {
    return FadeIn(
      delay: const Duration(milliseconds: 500),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _indicatorWidget(true, true, true),
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
            GetStartedLoginSignUpState.login,
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
            gradient: controller.theme.balancedGradient.value,
            disableColor: controller.theme.disable.value,
            onPressed: () {
              controller.resetOtpValues();
              controller.updateState(GetStartedLoginSignUpState.validateOtp);
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
            gradient: controller.theme.balancedGradient.value,
            disableColor: controller.theme.disable.value,
            textColor: controller.theme.text.value,
            onPressed: () => controller.onSignUp(),
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
          controller: controller.passwordSignUpController,
          onChanged: (value) => controller.onChangeSignUpPassword(),
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

  Widget _indicatorWidget(bool first, bool second, bool third) {
    return SizedBox(
      width: AppSize.width() * 0.9,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 5,
            width: AppSize.width() * 0.28,
            decoration: BoxDecoration(
              gradient: (first)
                  ? controller.theme.refreshGradient.value
                  : controller.theme.disableGradient.value,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          Container(
            height: 5,
            width: AppSize.width() * 0.28,
            decoration: BoxDecoration(
              gradient: (second)
                  ? controller.theme.refreshGradient.value
                  : controller.theme.disableGradient.value,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          Container(
            height: 5,
            width: AppSize.width() * 0.28,
            decoration: BoxDecoration(
              gradient: (third)
                  ? controller.theme.refreshGradient.value
                  : controller.theme.disableGradient.value,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _loginWidget() {
    return FadeIn(
      delay: const Duration(milliseconds: 500),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(),
          _textWidget('access_your_account', 'welcome'),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _textInputWidget("email_address", controller.theme.black.value),
              SizedBox(height: AppSize.height() * 0.005),
              _emailInputWidgetLogin(),
            ],
          ),
          SizedBox(
            width: AppSize.width() * 0.9,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _textInputWidget(
                      "password",
                      controller.theme.black.value,
                    ),
                    const SizedBox(),
                    InkWell(
                      onTap: () => controller.resetPasssword(),
                      child: _textInputWidgetUnderline(
                        "forgot",
                        controller.theme.primary.value,
                      ),
                    ),
                  ],
                ),
                _passwordInputWidgetLogin(),
              ],
            ),
          ),
          _loginButtonWidget(),
          _onSignUpWidget(),
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
      controller: controller.emailLoginController,
      onChanged: (value) => controller.onChangedLoginForm(),
    );
  }

  Widget _passwordInputWidgetLogin() {
    return PasswordInputWidget(
      maxLength: 12,
      hintText: "***".tr,
      textInputType: TextInputType.visiblePassword,
      controller: controller.passwordLoginController,
      onChanged: (value) => controller.onChangedLoginForm(),
      isVisible: controller.showPasswordLogin.value,
      onToggleVisibility: () => controller.togglePasswordVisibility(),
    );
  }

  Widget _loginButtonWidget() {
    return GradientButtonWidget(
      fontFamily: AppFontFamily.workSans,
      textSize: TextWidgetSizes.small,
      gradient: controller.theme.balancedGradient.value,
      disableColor: controller.theme.disable.value,
      textColor: controller.theme.text.value,
      onPressed: () => controller.onSignIn(),
      isActive: controller.activeNextLogin.value,
      title: 'login_w_email'.tr,
      height: 55.0,
      width: double.infinity,
      iconRigth: AppIcons.rightArrowPopUp,
      iconSize: 20,
      iconColor: controller.theme.black.value,
    );
  }

  Widget _getStartedWidget() {
    return FadeIn(
      delay: const Duration(milliseconds: 500),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(),
          _signUpButtonWidgetGetStarted(),
          _loginButtonWidgetGetStarted(),
          const SizedBox(),
          const SizedBox(),
          const SizedBox(),
        ],
      ),
    );
  }

  Widget _signUpButtonWidgetGetStarted() {
    return GradientButtonWidget(
      textSize: TextWidgetSizes.small,
      fontFamily: AppFontFamily.workSans,
      gradient: controller.theme.balancedGradient.value,
      disableColor: controller.theme.disable.value,
      textColor: controller.theme.black.value,
      onPressed: () => controller.updateState(
        GetStartedLoginSignUpState.registerEmail,
      ),
      title: 'get_started'.tr,
      isActive: true,
      height: 52.0,
      width: AppSize.width() * 0.9,
    );
  }

  Widget _loginButtonWidgetGetStarted() {
    return BorderButtonWidget(
      textSize: TextWidgetSizes.small,
      fontFamily: AppFontFamily.workSans,
      backgroundColor: controller.theme.white.value,
      borderColor: controller.theme.itemBorder.value,
      textColor: controller.theme.textStarted.value,
      onPressed: () => controller.updateState(
        GetStartedLoginSignUpState.login,
      ),
      title: 'already_have_account'.tr,
      isActive: true,
      height: 52.0,
      width: AppSize.width() * 0.9,
      rightIcon: AppIcons.login,
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

  Widget _textInputWidgetUnderline(String text, Color color) {
    return TextWidget(
      text.tr,
      fontFamily: AppFontFamily.workSans,
      textAlign: TextAlign.center,
      fontWeight: TextWidgetWeight.medium,
      dsize: RelSize(
        size: TextWidgetSizes.xsmall,
      ),
      color: color,
      decoration: TextDecoration.underline,
    );
  }

  Widget _onSignUpWidget() {
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
                      'dont'.tr,
                      fontFamily: AppFontFamily.workSans,
                      textAlign: TextAlign.center,
                      dsize: RelSize(
                        size: TextWidgetSizes.small,
                      ),
                      color: controller.theme.text.value,
                    ),
                    GestureDetector(
                      onTap: () => controller.updateState(
                        GetStartedLoginSignUpState.registerEmail,
                      ),
                      child: TextWidget(
                        'register'.tr,
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

  Widget _fullInformationWidget() {
    return FadeIn(
      delay: const Duration(milliseconds: 500),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _indicatorWidget(true, false, false),
          _textWidget(
            'fill_your_profile_information',
            'we_need_some',
          ),
          const SizedBox(),
          const SizedBox(),
          _namesWidgetInputs(),
          _emailWidgetInputs(),
          _dateInputWidget(),
          _userTypeDropDownWidget(),
          _genderDropDownWidget(),
          SizedBox(height: AppSize.width() * 0.05),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _signUpButtonWidget(),
              SizedBox(height: AppSize.width() * 0.05),
              _buttonText(
                'already',
                'login_in',
                GetStartedLoginSignUpState.login,
              ),
            ],
          ),
          SizedBox(height: AppSize.width() * 0.05),
        ],
      ),
    );
  }

  Widget _dateInputWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _textInputWidget('birthday', controller.theme.black.value),
        GestureDetector(
          onTap: () => controller.chooseDate(),
          child: DateInputWidget(
            hintText: 'hint_date'.tr,
            textInputType: TextInputType.text,
            controller: controller.dateController,
            onChanged: (value) => controller.validateSignUpForm(),
          ),
        ),
      ],
    );
  }

  Widget _namesWidgetInputs() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _textInputWidget('full_name', controller.theme.black.value),
        _firstNameInputWidget(),
      ],
    );
  }

  Widget _emailWidgetInputs() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _textInputWidget('email', controller.theme.black.value),
        _emailInputWidget(),
      ],
    );
  }

  Widget _userTypeDropDownWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _textInputWidget('user_type', controller.theme.black.value),
        Container(
          width: AppSize.width() * 0.9,
          height: AppSize.height() * 0.06,
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: controller.theme.white.value,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: controller.theme.grayAccent.value,
              width: 1.0,
            ),
          ),
          child: DropdownButton<String>(
            isExpanded: true,
            underline: const SizedBox(),
            focusColor: controller.theme.backgroundDeviceSetting.value,
            hint: TextWidget(
              fontStyle: FontStyle.italic,
              'select_user_type'.tr,
              fontFamily: AppFontFamily.workSans,
              textAlign: TextAlign.center,
              dsize: RelSize(
                size: TextWidgetSizes.small,
              ),
              color: controller.theme.onText.value,
            ),
            value: controller.selectedUserType.value.isEmpty
                ? null
                : controller.selectedUserType.value,
            items: controller.userTypes.map((String userType) {
              return DropdownMenuItem<String>(
                value: userType,
                child: TextWidget(
                  userType,
                  fontFamily: AppFontFamily.workSans,
                  textAlign: TextAlign.center,
                  dsize: RelSize(
                    size: TextWidgetSizes.small,
                  ),
                  color: controller.theme.gray.value,
                ),
              );
            }).toList(),
            onChanged: (String? newUserType) {
              if (newUserType != null) {
                controller.setSelectedUserType(newUserType);
                controller.validateSignUpForm();
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _genderDropDownWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _textInputWidget('gender', controller.theme.black.value),
        Container(
          width: AppSize.width() * 0.9,
          height: AppSize.height() * 0.06,
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: controller.theme.white.value,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: controller.theme.grayAccent.value,
              width: 1.0,
            ),
          ),
          child: DropdownButton<String>(
            isExpanded: true,
            underline: const SizedBox(),
            focusColor: controller.theme.backgroundDeviceSetting.value,
            hint: TextWidget(
              fontStyle: FontStyle.italic,
              'select_gender'.tr,
              fontFamily: AppFontFamily.workSans,
              textAlign: TextAlign.center,
              dsize: RelSize(
                size: TextWidgetSizes.small,
              ),
              color: controller.theme.onText.value,
            ),
            value: controller.selectedGender.value.isEmpty
                ? null
                : controller.selectedGender.value,
            items: controller.genders.map((String gender) {
              return DropdownMenuItem<String>(
                value: gender,
                child: TextWidget(
                  gender,
                  fontFamily: AppFontFamily.workSans,
                  textAlign: TextAlign.center,
                  dsize: RelSize(
                    size: TextWidgetSizes.small,
                  ),
                  color: controller.theme.gray.value,
                ),
              );
            }).toList(),
            onChanged: (String? newGender) {
              if (newGender != null) {
                controller.setSelectedGender(newGender);
                controller.validateSignUpForm();
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _signUpButtonWidget() {
    return GradientButtonWidget(
      fontFamily: AppFontFamily.workSans,
      gradient: controller.theme.balancedGradient.value,
      disableColor: controller.theme.disable.value,
      textColor: controller.theme.text.value,
      onPressed: () => controller.onCheckEmail(),
      isActive: controller.activeNextfull.value,
      title: 'continue'.tr,
      height: 50.0,
      width: double.infinity,
      iconRigth: AppIcons.rightArrowPopUp,
      iconSize: 20,
      iconColor: controller.theme.black.value,
    );
  }

  Widget _validateCodeWidget() {
    return FadeIn(
      delay: const Duration(milliseconds: 500),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _indicatorWidget(true, true, false),
          _textCodeWidget(),
          _codeInputWidget(),
          _invalidCodeWidget(),
          _codeButtonWidget(),
          _buttonTextCode(
            'wrong_email',
            'go_back',
            GetStartedLoginSignUpState.registerEmail,
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
                fontFamily: AppFontFamily.workSans,
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
                      fontFamily: AppFontFamily.workSans,
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
                                fontFamily: AppFontFamily.workSans,
                                fontWeight: TextWidgetWeight.light,
                                dsize: RelSize(size: TextWidgetSizes.small),
                                color: controller.theme.grayDark.value,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: controller.emailSignUpController.text
                                      .toLowerCase(),
                                  style: onlyTextStyle(
                                    fontFamily: AppFontFamily.workSans,
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
                fontFamily: AppFontFamily.workSans,
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

  Widget _firstNameInputWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleInputWidget(
          isActive: true,
          maxLength: 25,
          mandatory: true,
          hintText: 'your_name'.tr,
          textInputType: TextInputType.text,
          controller: controller.firstNameInputController,
          onChanged: (value) => controller.validateSignUpForm(),
        ),
        (controller.firstNameWarning.value)
            ? TextWidget(
                'name_check'.tr,
                fontFamily: AppFontFamily.workSans,
                color: (controller.firstNameWarning.value)
                    ? controller.theme.primary.value
                    : Colors.transparent,
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

  Widget _emailInputWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleInputWidget(
          isActive: true,
          mandatory: true,
          hintText: 'yourname@'.tr,
          textInputType: TextInputType.emailAddress,
          controller: controller.emailSignUpController,
          onChanged: (value) => controller.validateSignUpForm(),
        ),
        (controller.emailWarning.value)
            ? TextWidget(
                'email_check'.tr,
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

  Widget _confirmpasswordInputWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PasswordInputWidget(
          maxLength: 12,
          hintText: 'con_password'.tr,
          controller: controller.confirmPasswordSignUpController,
          onChanged: (value) => controller.onChangeSignUpPassword(),
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
