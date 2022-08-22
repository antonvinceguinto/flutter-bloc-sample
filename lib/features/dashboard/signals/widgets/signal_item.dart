import 'package:bloc_vgv_todoapp/core/utils/extensions.dart';
import 'package:bloc_vgv_todoapp/features/dashboard/signals/widgets/info_text.dart';
import 'package:firestore_repository/models/signal_model.dart';
import 'package:flutter/material.dart';

class SignalItem extends StatelessWidget {
  const SignalItem({super.key, required this.signal});

  final Signal signal;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/images/flutter-logo.png',
                    width: 24,
                    height: 24,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    signal.title,
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    signal.timestamp.toDate().readableDate,
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                  ),
                ],
              ),
              Text(
                signal.isExpired ? 'EXPIRED' : 'ACTIVE',
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: signal.isExpired ? Colors.red : Colors.green,
                    ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  InfoText(
                    'BUY: 23,892',
                    labelColor: Colors.amber,
                  ),
                  InfoText(
                    'TP: 24,210',
                    labelColor: Colors.green,
                  ),
                  InfoText(
                    'STOP: 23,700',
                    labelColor: Colors.red,
                  ),
                ],
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.grey.shade900.withOpacity(0.7),
                ),
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Notes:',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: Colors.grey.shade500,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      signal.details,
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: Colors.white70,
                          ),
                    ),
                    if (signal.imageUrl.isNotEmpty) ...{
                      const SizedBox(height: 10),
                      Image.network(
                        signal.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    }
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
