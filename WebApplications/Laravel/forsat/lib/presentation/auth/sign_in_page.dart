import 'package:flutter/material.dart';
import 'package:forsat/network/classes/errors/common_error.dart';
import 'package:forsat/network/models/auth/sign_in_form_model.dart';
import 'package:forsat/res/colors.dart';
import 'package:forsat/res/images.dart';
import 'package:forsat/router/router_constants.dart';
import 'package:forsat/widgets/show_snackbar.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _key = GlobalKey();
    return Scaffold(
      key: _key,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
        automaticallyImplyLeading: false,
      ),
      body: Injector(
        inject: [Inject<SignInFormModel>(() => SignInFormModel())],
        builder: (context) {
          final _singletonSignInFormModel = RM.get<SignInFormModel>();
          return Container(
            padding: EdgeInsets.all(16),
            child: ListView(
              children: <Widget>[
                Container(
                  height: 150,
                  child: Center(
                    child: Image.asset(MyImages.logo_solid),
                  ),
                ),
                buildSizedBox(20),
                StateBuilder<SignInFormModel>(
                  builder: (context, signInFormModel) {
                    return TextFormField(
                      onChanged: (String email) {
                        signInFormModel.setState(
                          (state) => state.setEmail(email),
                          catchError: true
                        );
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        errorText: signInFormModel.hasError
                          ? signInFormModel.error.message
                          : null,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
                          child: Icon(Icons.email),
                        ),
                        hintText: "Enter your email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    );
                  },
                ),
                buildSizedBox(15),
                StateBuilder<SignInFormModel>(
                  builder: (_, signFormModel) {
                    return TextFormField(
                      onChanged: (String password) {
                        signFormModel.setState((state) => state.setPassword(password),
                          catchError: true);
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        errorText: signFormModel.hasError
                          ? signFormModel.error.message
                          : null,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
                          child: Icon(Icons.lock),
                        ),
                        hintText: "Enter your password",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30)),
                      ),
                    );
                  },
                ),
                buildSizedBox(25),
                StateBuilder(
                  observe: () => _singletonSignInFormModel,
                  builder: (_, model) {
                    return MaterialButton(
                      onPressed: () {
                        if (!_singletonSignInFormModel.state.validateData()) {
                          showSnackbar(key: _key, message: "Please match the criteria of all forms");
                        } else {
                          _singletonSignInFormModel.setState(
                            (state) async {
                              await state.signInUser();
                              Navigator.pushReplacementNamed(context, homeRoute);
                            },
                            onError: (context, error)
                              => showSnackbar(
                                  color: Colors.red,
                                  key: _key,
                                  message: (error as CommonError).message
                              )
                          );
                        }
                      },
                      height: 55,
                      shape: StadiumBorder(),
                      color: MyColors.primaryColor,
                      child: Center(
                        child: Text(
                          "Sign In",
                          style: TextStyle(color: Colors.white, fontSize: 23),
                        ),
                      ),
                    );
                  },
                ),
                buildSizedBox(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Don't have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, signUpRoute);
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(color: MyColors.primaryColor),
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }

  SizedBox buildSizedBox(double height) {
    return SizedBox(
      height: height,
    );
  }
}
