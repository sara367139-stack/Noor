import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noorah/auth/auth_provider.dart';
import 'package:go_router/go_router.dart';


class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() =>
      _RegisterPageState();
}


class _RegisterPageState extends ConsumerState<RegisterPage> {

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isLoading = false;


  Future<void> register() async {

    if (passwordController.text !=
        confirmPasswordController.text) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Passwords do not match",
          ),
        ),
      );

      return;
    }


    setState(() {
      isLoading = true;
    });


    try {

     await ref
    .read(authServiceProvider)
    .register(
      nameController.text.trim(),
      emailController.text.trim(),
      passwordController.text.trim(),
    );


      if (mounted) {

       context.go('/home');

      }


    } catch (e) {

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
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
        title: const Text(
          "Create Account",
        ),
      ),


      body: Padding(

        padding: const EdgeInsets.all(24),

        child: SingleChildScrollView(

          child: Column(

            mainAxisAlignment:
                MainAxisAlignment.center,

            children: [


              TextField(

                controller: nameController,

                decoration:
                    const InputDecoration(
                  labelText: "Name",
                  prefixIcon:
                      Icon(Icons.person),
                ),

              ),


              const SizedBox(height: 16),


              TextField(

                controller: emailController,

                decoration:
                    const InputDecoration(
                  labelText: "Email",
                  prefixIcon:
                      Icon(Icons.email),
                ),

              ),


              const SizedBox(height: 16),


              TextField(

                controller: passwordController,

                obscureText: true,

                decoration:
                    const InputDecoration(
                  labelText: "Password",
                  prefixIcon:
                      Icon(Icons.lock),
                ),

              ),


              const SizedBox(height: 16),


              TextField(

                controller:
                    confirmPasswordController,

                obscureText: true,

                decoration:
                    const InputDecoration(
                  labelText:
                      "Confirm Password",
                  prefixIcon:
                      Icon(Icons.lock_outline),
                ),

              ),


              const SizedBox(height: 30),


              SizedBox(

                width: double.infinity,

                child: ElevatedButton(

                  onPressed:
                      isLoading
                          ? null
                          : register,


                  child: isLoading
                      ? const CircularProgressIndicator()
                      : const Text(
                          "Register",
                        ),

                ),

              ),

            ],

          ),

        ),

      ),

    );

  }



  @override
  void dispose() {

    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    super.dispose();

  }

}