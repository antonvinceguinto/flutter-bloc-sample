import 'package:firestore_repository/models/signal_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignalLock extends StatelessWidget {
  const SignalLock({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () async {
        // if (!context
        //     .read<AuthenticationRepository>()
        //     .isEmailVerified) {
        //   Sw8Dialog.showOkDialog(
        //     context,
        //     'Email not verified',
        //     'Only verified email addresses can purchase signals',
        //   );
        // }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.lock_open_outlined,
            color: Colors.green,
            size: 48,
          ),
          const SizedBox(height: 9),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Colors.green.withOpacity(0.2),
            ),
            child: Text(
              'Unlock Signals for ₱120',
              style: Theme.of(context)
                  .textTheme
                  .button!
                  .copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
