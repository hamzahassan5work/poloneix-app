import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poloniex_app/core/network/rest_client.dart';
import 'package:poloniex_app/core/network/rest_api.dart';
import 'package:poloniex_app/core/network/socket_client.dart';
import 'package:poloniex_app/features/trade/domain/models/connection_success_response_model.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

abstract class TradeNetworkDataSource {
  Future<ConnectionSuccessResponseModel> webSocketConnectionRequest();
  Future<WebSocketChannel> subscribeToTopic(String endpoint, String token);
}

class TradeNetworkDataSourceImpl implements TradeNetworkDataSource {
  final RestAPI restAPI;
  final SocketClient<WebSocketChannel> socketClient;

  TradeNetworkDataSourceImpl(this.restAPI, this.socketClient);

  @override
  Future<ConnectionSuccessResponseModel> webSocketConnectionRequest() async {
    return restAPI.webSocketConnectionRequest();
  }

  @override
  Future<WebSocketChannel> subscribeToTopic(
    String endpoint,
    String token,
  ) async {
    final wsUrl = Uri.parse('$endpoint?token=$token');
    final channel = socketClient.connect(wsUrl);

    await channel.ready;

    return channel;
  }
}

/// Provider for the trade network data source.
///
/// This provider creates an instance of [TradeNetworkDataSource] by
/// injecting the [dioClientProvider] and returning an instance of
/// [_TradeNetworkDataSourceImpl] with the provided [RestAPI] client.
final tradeNetworkDataSourceProvider = Provider<TradeNetworkDataSource>((ref) {
  final restClient = ref.watch(dioClientProvider);
  final socketClient = ref.watch(webSocketChannelClientProvider);
  return TradeNetworkDataSourceImpl(RestAPI(restClient.client), socketClient);
});
