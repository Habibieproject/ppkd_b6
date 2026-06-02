import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ppkd_b6/constant/app_color.dart';
import 'package:ppkd_b6/constant/app_image.dart';
import 'package:ppkd_b6/day_20/database/db_helper.dart';
import 'package:ppkd_b6/day_20/models/user_model_sql.dart';
import 'package:ppkd_b6/day_20/views/login_screen.dart';
import 'package:ppkd_b6/extension/navigator.dart';

class RegisterScreenDay20 extends StatefulWidget {
  const RegisterScreenDay20({super.key});

  @override
  State<RegisterScreenDay20> createState() => _RegisterScreenDay20State();
}

class _RegisterScreenDay20State extends State<RegisterScreenDay20> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  void register() async {
    final email = emailController.text.trim();
    final pass = passwordController.text;

    if (email.isEmpty || pass.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Isi semua field woi!')));
      return;
    }

    final user = UserModelSql(email: email, password: pass);
    bool success = await DBHelper().registerUser(user);

    // Cek apakah widget masih terpasang (mounted) sebelum menggunakan context
    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Akun berhasil dibuat')));
      context.push(LoginScreenDay20());

      // Tambahkan navigasi ke halaman login jika perlu
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Email sudah terdaftar!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            AppImage.bg,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Image.asset(AppImage.logo, width: 128)],
                    ),
                    SizedBox(height: 24),

                    Container(
                      padding: EdgeInsets.all(24),
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Create an account or log in to explore our app",

                            style: TextStyle(color: AppColor.greyColorOr),
                          ),

                          SizedBox(height: 24),

                          textTitleForm("Email"),
                          SizedBox(height: 12),

                          textFormConst(
                            controller: emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Email tidak boleh kosong";
                              } else if (!value.contains('@')) {
                                return "Format email tidak valid";
                              }
                              return null;
                            },
                            hintText: "Masukkan Email",
                          ),
                          SizedBox(height: 24),

                          textTitleForm("Password"),
                          SizedBox(height: 12),

                          textFormConst(
                            controller: passwordController,
                            hintText: "Masukkan Password",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Password tidak boleh kosong";
                              } else if (value.length < 6) {
                                return "Password terlalu singkat";
                              }
                              return null;
                            },
                          ),
                          // Text(
                          //   emailController.text,
                          //   style: TextStyle(fontSize: 50),
                          // ),
                          SizedBox(height: 24),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Remember Me",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColor.greyColorOr,
                                ),
                              ),
                              Text(
                                "Forgot Password?",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColor.blueForgot,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12),

                          SizedBox(
                            height: 48,
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                backgroundColor: AppColor.blueButtons,
                              ),
                              onPressed: register,
                              // () {
                              //   // if (_formKey.currentState!.validate()) {
                              //   //   print("Sudah memenuhi syarat");
                              //   //   showDialog(
                              //   //     context: context,
                              //   //     builder: (BuildContext context) {
                              //   //       return AlertDialog(
                              //   //         title: Text("Berhasil"),
                              //   //         content: Text("Anda berhasil login"),
                              //   //         actions: [
                              //   //           TextButton(
                              //   //             onPressed: () async {
                              //   //               await PreferenceHandler.setLogin(
                              //   //                 true,
                              //   //               );
                              //   //               context.push(
                              //   //                 MainScreenDrawerDay15(
                              //   //                   email: emailController.text,
                              //   //                   password:
                              //   //                       passwordController.text,
                              //   //                 ),
                              //   //               );
                              //   //               // context.push(MainScreen2Day15());
                              //   //             },
                              //   //             child: Text("Lanjut"),
                              //   //           ),
                              //   //         ],
                              //   //       );
                              //   //     },
                              //   //   );
                              //   // } else {
                              //   //   print(emailController.text);
                              //   //   Fluttertoast.showToast(
                              //   //     msg: "Silakan periksa kembali",
                              //   //     toastLength: Toast.LENGTH_SHORT,
                              //   //     gravity: ToastGravity.BOTTOM,
                              //   //     timeInSecForIosWeb: 1,
                              //   //     backgroundColor: Colors.red,
                              //   //     textColor: Colors.white,
                              //   //     fontSize: 16.0,
                              //   //   );
                              //   //   // ScaffoldMessenger.of(context).showSnackBar(
                              //   //   //   SnackBar(content: Text("Silakan periksa kembali")),
                              //   //   // );
                              //   // }
                              // },
                              child: Text(
                                "Register",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 24),
                          Text.rich(
                            TextSpan(
                              text: "Have an account? ",
                              recognizer: TapGestureRecognizer()
                                ..onTap = () =>
                                    context.push(LoginScreenDay20()),
                              style: TextStyle(color: AppColor.greyColorOr),
                              children: [
                                TextSpan(
                                  text: "Sign In",
                                  style: TextStyle(
                                    color: AppColor.blueForgot,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  TextFormField textFormConst({
    required String hintText,
    required String? Function(String?)? validator,
    required TextEditingController controller,
  }) {
    return TextFormField(
      onChanged: (value) {
        setState(() {});
      },
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        enabledBorder: borderConst(),
        focusedBorder: borderConst(),
        border: borderConst(),
      ),
    );
  }

  OutlineInputBorder borderConst() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: AppColor.greyColorDivider),
    );
  }

  Widget textTitleForm(String text) => Row(
    children: [
      Text(text, style: TextStyle(color: AppColor.greyColorOr, fontSize: 12)),
    ],
  );
}
