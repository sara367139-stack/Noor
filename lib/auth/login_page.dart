import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noorah/auth/auth_provider.dart';
import 'package:go_router/go_router.dart';


class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}


class _LoginPageState extends ConsumerState<LoginPage> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoading = false;


  Future<void> login() async {

    setState(() {
      isLoading = true;
    });


    try {

      await ref
          .read(authServiceProvider)
          .login(
            emailController.text.trim(),
            passwordController.text.trim(),
          );


      if (mounted) {
      context.go('/home');
      }


    } catch (e) {

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );

    }


    setState(() {
      isLoading = false;
    });

  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Login"),
      ),


      body: Padding(
        padding: const EdgeInsets.all(24),

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,

          children: [


            TextField(
              controller: emailController,

              keyboardType:
                  TextInputType.emailAddress,

              decoration: const InputDecoration(
                labelText: "Email",
                prefixIcon: Icon(Icons.email),
              ),

            ),


            const SizedBox(height: 16),


            TextField(
              controller: passwordController,

              obscureText: true,

              decoration: const InputDecoration(
                labelText: "Password",
                prefixIcon: Icon(Icons.lock),
              ),

            ),


            const SizedBox(height: 30),



            SizedBox(
              width: double.infinity,

              child: ElevatedButton(

                onPressed:
                    isLoading ? null : login,


                child: isLoading
                    ? const CircularProgressIndicator()
                    : const Text("Login"),

              ),
            ),


            TextButton(

              onPressed: (){

             context.push('/register');
              },

              child: const Text(
                "Create Account",
              ),

            )

          ],
        ),
      ),
    );
  }


  @override
  void dispose() {

    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

}