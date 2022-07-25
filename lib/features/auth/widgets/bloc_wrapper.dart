import 'package:bloc_vgv_todoapp/features/auth/cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocLoginWrapper extends StatelessWidget {
  const BlocLoginWrapper({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return child;
      },
    );
  }
}

InputDecoration customInputDecoration({
  required String labelText,
  required IconData icon,
}) {
  return InputDecoration(
    hintText: labelText,
    // fillColor: Colors.grey[100],
    // filled: true,
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 8,
    ),
    icon: Icon(
      icon,
      color: Colors.blueGrey.shade400,
    ),
    border: UnderlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide(
        width: 3,
        color: Colors.blueGrey.shade400,
      ),
    ),
  );
}
