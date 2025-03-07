import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mt_assignment/screens/login/bloc/login_bloc.dart';
import 'package:mt_assignment/screens/login/bloc/login_event.dart';
import 'package:mt_assignment/screens/login/bloc/login_state.dart';
import 'package:mt_assignment/screens/signup/sign_up.dart';
import 'package:mt_assignment/screens/transactions/transactions.dart';
import 'package:mt_assignment/widgets/footer.dart';
import 'package:mt_assignment/widgets/screen_title.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xfff3f4f6),
        body: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginFailed) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  backgroundColor: Color(0xffdc2626),
                  content: Text('Login failed. Please try again.')));
            } else if (state is MissingCredentials) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  backgroundColor: Color(0xffdc2626),
                  content: Text('Please enter email and password.')));
            } else if (state is LoginSuccess) {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => Transactions(loggedInUser: state.user),
              ));
            } else if (state is CanRegister) {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const SignUp(),
              ));
            }
          },
          child: const Stack(
            children: [
              Positioned(
                top: 100,
                left: 40,
                right: 40,
                child: _Header(),
              ),
              Positioned(
                  top: 300,
                  left: 40,
                  right: 40,
                  child: ScreenTitle(title: 'Login')),
              Positioned(
                  top: 400,
                  left: 40,
                  right: 40,
                  height: 1000,
                  child: _LoginForm()),
              Positioned(bottom: 16.0, left: 32, right: 32, child: Footer())
            ],
          ),
        ));
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      children: [
        Image.asset(
          'assets/images/logo.png',
          width: 150,
          height: 150,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Simu Bank',
                style: textTheme.headlineLarge?.copyWith(color: Colors.black),
              ),
              Text('Digital Banking',
                  style: textTheme.headlineSmall?.copyWith(color: Colors.grey))
            ],
          ),
        )
      ],
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm();

  static const paddingBottomLarge = 24.0;
  static const paddingBottomSmall = 8.0;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: paddingBottomLarge),
              child: TextField(
                onChanged: (value) {
                  context.read<LoginBloc>().add(EmailChanged(userInput: value));
                },
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Email',
                  hintStyle:
                      TextStyle(fontSize: 20.0, color: Color(0xff4b5563)),
                ),
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: const Color(0xff374151)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: paddingBottomLarge),
              child: TextField(
                onChanged: (value) {
                  context
                      .read<LoginBloc>()
                      .add(PasswordChanged(userInput: value));
                },
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Password',
                  hintStyle:
                      TextStyle(fontSize: 20.0, color: Color(0xff4b5563)),
                ),
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: const Color(0xff374151)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: paddingBottomLarge),
              child: ElevatedButton(
                onPressed: () {
                  context.read<LoginBloc>().add(ClickLogin());
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    minimumSize: const Size(300, 50),
                    backgroundColor: const Color(0xff2563eb)),
                child: Text(
                  'LOGIN',
                  style: textTheme.titleLarge?.copyWith(color: Colors.white),
                ),
              ),
            ),

            if (state is Processing) ...[
              Transform.scale(
              scale: 0.5,
              child: const CircularProgressIndicator(
                   color: Color(0xff2563eb)))
            ],

            Padding(
                padding: const EdgeInsets.only(bottom: paddingBottomSmall),
                child: Text(
                  'No account yet? Create now!',
                  style: textTheme.titleLarge
                      ?.copyWith(color: const Color(0xff4b5563)),
                )),
            Padding(
              padding: const EdgeInsets.only(bottom: paddingBottomLarge),
              child: ElevatedButton(
                onPressed: () {
                  context.read<LoginBloc>().add(ClickRegistration());
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    minimumSize: const Size(300, 50),
                    backgroundColor: const Color(0xffd1d5db)),
                child: Text(
                  'REGISTRATION',
                  style: textTheme.titleLarge?.copyWith(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
