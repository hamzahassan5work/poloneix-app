import 'dart:async';
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poloniex_app/features/trade/data/repositories/trade_repository.dart';
import 'package:poloniex_app/features/trade/domain/models/topic_subscription_payload_models.dart';

class TradeStreamController extends StreamNotifier<double> {
  @override
  Stream<double> build() async* {
    final channel = await ref.watch(tradeRepositoryProvider).initSubscription();

    final streamController = StreamController<double>.broadcast();
    final stream = streamController.stream;

    final payload = jsonEncode(TopicBTCUSDTPERPPayload().toJson());

    void handleWelcomeMessage() {
      // Connection successful, send the payload
      channel.sink.add(payload);
    }

    void handleDataMessage(Map<String, dynamic> data) {
      if (data.containsKey('data')) {
        final price = (data['data']['price'] as num).toDouble();
        streamController.add(price);
      }
    }

    void handleAckMessage() {
      // Resend the payload after 20 seconds
      Future.delayed(const Duration(seconds: 20), () {
        channel.sink.add(payload);
      });
    }

    channel.stream.listen(
      (dynamic message) {
        final data = jsonDecode(message) as Map<String, dynamic>;

        switch (data['type']) {
          case 'welcome':
            handleWelcomeMessage();
            break;
          case 'ack':
            handleAckMessage();
            break;
          default:
            break;
        }

        handleDataMessage(data);
      },
      onDone: () {},
      onError: (error) {},
    );

    yield* stream;
  }
}

/// Provider for the trade stream controller.
/// This provider creates a [StreamNotifierProvider] for [TradeStreamController] with a generic type of [double].
/// The [TradeStreamController] is instantiated using the [TradeStreamController.new] constructor.
final tradeStreamControllerProvider =
    StreamNotifierProvider<TradeStreamController, double>(
  TradeStreamController.new,
);
