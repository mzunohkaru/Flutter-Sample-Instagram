import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_clone/Core/Auth/ViewModel/registration_view_model.dart';
import 'package:instagram_clone/Core/Root/View/splash_view.dart';
import 'package:instagram_clone/Widgets/dialog_widget.dart';
import 'package:instagram_clone/Widgets/textfiled_widget.dart';

class RegistrationView extends HookWidget {
  final viewModel = RegistrationViewModel();

  RegistrationView({super.key});

  @override
  Widget build(BuildContext context) {
    final mailController = useTextEditingController();
    final usernameController = useTextEditingController();
    final passwordController = useTextEditingController();
    final obscure = useState(true);
    final isValidation = useState(false);

    useEffect(() {
      void listener() {
        isValidation.value = mailController.text.isNotEmpty &&
            usernameController.text.isNotEmpty &&
            passwordController.text.isNotEmpty;
      }

      mailController.addListener(listener);
      usernameController.addListener(listener);
      passwordController.addListener(listener);
      return () {
        mailController.removeListener(listener);
        usernameController.removeListener(listener);
        passwordController.removeListener(listener);
      };
    }, [mailController, usernameController, passwordController]);

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Image.asset("assets/logo.png"),
              const SizedBox(
                height: 20,
              ),
              RegistrationTextFieldWidget(
                mailController: mailController,
                labelText: "メールアドレス",
                iconData: Icons.mail,
              ),
              const SizedBox(
                height: 20,
              ),
              RegistrationTextFieldWidget(
                mailController: usernameController,
                labelText: "ユーザー名",
                iconData: Icons.person,
              ),
              const SizedBox(
                height: 20,
              ),
              PasswordTextFiledWidget(
                  passwordController: passwordController,
                  obscure: obscure,
                  labelText: "パスワード"),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: isValidation.value
                      ? () async {
                          await viewModel
                              .signUp(
                                  email: mailController.text,
                                  password: passwordController.text,
                                  username: usernameController.text)
                              .then((result) {
                            if (result != null) {
                              showAuthErrorDialog(
                                  context: context,
                                  title: "ログインエラー",
                                  content: result);
                            }
                          });
          
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const SplashView(),
                            ),
                          );
                        }
                      : null,
                  child:
                      const Text("Sign Up", style: TextStyle(fontSize: 16)),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Row(
                  children: [
                    Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text("OR"),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.facebook,
                      color: Colors.blue,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Continue with Facebook",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              const Divider(),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: RichText(
                  text: const TextSpan(
                    text: "Already have an account?",
                    style: TextStyle(color: Colors.blue),
                    children: <TextSpan>[
                      TextSpan(
                        text: ' Sign In',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 60,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget passwordTextFiled(
      {required TextEditingController controller,
      required ValueNotifier<bool> obscure,
      required Function function}) {
    return SizedBox(
      width: double.infinity,
      child: TextField(
        controller: controller,
        obscureText: obscure.value,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          filled: true,
          prefixIcon: const Icon(Icons.lock),
          suffixIcon: IconButton(
            onPressed: function(),
            icon: Icon(obscure.value ? Icons.visibility_off : Icons.visibility),
          ),
          labelText: 'パスワード',
        ),
      ),
    );
  }
}
