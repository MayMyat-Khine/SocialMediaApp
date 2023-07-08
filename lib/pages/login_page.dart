import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/blocs/login_bloc.dart';
import 'package:social_media_app/pages/home_page.dart';
import 'package:social_media_app/pages/register_page.dart';
import 'package:social_media_app/resources/dimens.dart';
import 'package:social_media_app/utils/extensions.dart';
import 'package:social_media_app/widgets/label_and_textfield_view.dart';
import 'package:social_media_app/widgets/primary_buttom_view.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginBloc(),
      child: Scaffold(
        body: Selector<LoginBloc, bool>(
          selector: (context, bloc) => bloc.isLoading,
          builder: (context, isLoading, child) => Stack(
            children: [
              Container(
                padding: const EdgeInsets.only(
                  top: LOGIN_SCREEN_TOP_PADDING,
                  bottom: MARGIN_LARGE,
                  left: MARGIN_XLARGE,
                  right: MARGIN_XLARGE,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "LOGIN",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: TEXT_BIG,
                      ),
                    ),
                    const SizedBox(
                      height: MARGIN_XXLARGE,
                    ),
                    Consumer<LoginBloc>(
                      builder: (context, bloc, child) => LabelAndTextFieldView(
                        label: "EMAIL",
                        hint: "EMAIL",
                        onChanged: (email) => bloc.onEmailChanged(email),
                      ),
                    ),
                    const SizedBox(
                      height: MARGIN_XLARGE,
                    ),
                    Consumer<LoginBloc>(
                      builder: (context, bloc, child) => LabelAndTextFieldView(
                        label: "PASSWORD",
                        hint: "PASSWORD",
                        onChanged: (password) =>
                            bloc.onPasswordChanged(password),
                        isSecure: true,
                      ),
                    ),
                    const SizedBox(
                      height: MARGIN_XXLARGE,
                    ),
                    Consumer<LoginBloc>(
                      builder: (context, bloc, child) => TextButton(
                        onPressed: () {
                          bloc
                              .onTapLogin()
                              .then((_) =>
                                  navigateToScreen(context, const HomePage()))
                              .catchError((error) => showSnackBarWithMessage(
                                  context, error.toString()));
                        },
                        child: const PrimaryButtonView(
                          label: "LOGIN",
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: MARGIN_LARGE,
                    ),
                    // const ORView(),
                    const SizedBox(
                      height: MARGIN_LARGE,
                    ),
                    const RegisterTriggerView()
                  ],
                ),
              ),
              Visibility(
                visible: isLoading,
                child: Container(
                  color: Colors.black12,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class RegisterTriggerView extends StatelessWidget {
  const RegisterTriggerView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "DONT HAVE AN ACCOUNT",
        ),
        const SizedBox(width: MARGIN_SMALL),
        GestureDetector(
          onTap: () => navigateToScreen(
            context,
            const RegisterPage(),
          ),
          child: const Text(
            "REGISTER",
            style: TextStyle(
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
          ),
        )
      ],
    );
  }
}
