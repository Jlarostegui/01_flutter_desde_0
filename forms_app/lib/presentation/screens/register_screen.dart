import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forms_app/infrastructure/inputs/inputs.dart';
import 'package:forms_app/presentation/blocs/register/register_cubit.dart';
import 'package:forms_app/presentation/widgets/widgets.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo Usuario'),
      ),
      body: BlocProvider(
        create: (context) => RegisterCubit(),
        child: const _RegisterView(),
      ),
    );
  }
}

class _RegisterView extends StatelessWidget {
  const _RegisterView();

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FlutterLogo(
                size: 100,
              ),
              SizedBox(
                height: 20,
              ),
              _RegisterForm(),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RegisterForm extends StatelessWidget {
  const _RegisterForm();

  @override
  Widget build(BuildContext context) {
    final resgisterCubit = context.watch<RegisterCubit>();
    final Username username = resgisterCubit.state.username;
    final Password password = resgisterCubit.state.password;
    final Email email = resgisterCubit.state.email;

    return Form(
      // key: _formKey,
      child: Column(
        children: [
          CustomTextFormField(
            label: 'Nombre Usuario',
            onChanged: resgisterCubit.usernameChanged,
            erroMessage: username.errorMesagge,
            // onChanged: (value) {
            //   resgisterCubit.usernameChanged(value);
            //   // _formKey.currentState?.validate();
            // },
            validator: (value) {
              if (value == null || value.isEmpty) return 'Campo requerido';
              if (value.trim().isEmpty) return 'Campo requerido';
              if (value.length < 6) return 'Mas de 6 letras';
              return null;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          CustomTextFormField(
            label: 'Correo electronico',
            onChanged: resgisterCubit.emailChanged,
            erroMessage: email.errorMesagge,
            // onChanged: (value) {
            //   resgisterCubit.emailChanged(value);
            //   // _formKey.currentState?.validate();
            // },
            // validator: (value) {
            //   final emailRegExp = RegExp(
            //     r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
            //   );

            //   if (value == null || value.isEmpty) return 'Campo requerido';
            //   if (value.trim().isEmpty) return 'Campo requerido';
            //   if (!emailRegExp.hasMatch(value)) {
            //     return 'Introduce un correo valido';
            //   }
            //   return null;
            // },
          ),
          const SizedBox(
            height: 20,
          ),
          CustomTextFormField(
            label: 'Contraseña',
            obscureText: true,
            onChanged: resgisterCubit.passwordChanged,
            erroMessage: password.errorMesagge,
            // onChanged: (value) {
            //   resgisterCubit.passwordChanged(value);
            //   // _formKey.currentState?.validate();
            // },
            // validator: (value) {
            //   if (value == null || value.isEmpty) return 'Campo requerido';
            //   if (value.trim().isEmpty) return 'Campo requerido';
            //   if (value.length < 6) return 'Mas de 6 letras';
            //   return null;
            // },
          ),
          const SizedBox(
            height: 20,
          ),
          FilledButton.tonalIcon(
            onPressed: () {
              // final isValid = _formKey.currentState?.validate();
              // if (!isValid!) return;

              resgisterCubit.onSubmit();
            },
            icon: const Icon(Icons.save),
            label: const Text('Crear Usuario'),
          ),
        ],
      ),
    );
  }
}
