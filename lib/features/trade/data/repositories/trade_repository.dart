import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poloniex_app/core/constants/strings.dart';
import 'package:poloniex_app/features/trade/data/datasources/trade_network_data_source.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

abstract interface class TradeRepository {
  Future<WebSocketChannel> initSubscription();
}

class TradeRepositoryImpl implements TradeRepository {
  TradeRepositoryImpl(this._tradeNetworkDataSource);

  final TradeNetworkDataSource _tradeNetworkDataSource;

  @override
  Future<WebSocketChannel> initSubscription() async {
    final response = await _tradeNetworkDataSource.webSocketConnectionRequest();
    final data = response.data;

    if (data.instanceServers.isNotEmpty) {
      return await _tradeNetworkDataSource.subscribeToTopic(
        data.instanceServers.first.endpoint,
        data.token,
      );
    } else {
      throw Exception(KStrings.noInstanceServersFound);
    }
  }
}

/// Provider for [TradeRepository] that creates an instance of [TradeRepositoryImpl].
final tradeRepositoryProvider = Provider<TradeRepository>((ref) {
  final dataSource = ref.watch(tradeNetworkDataSourceProvider);
  return TradeRepositoryImpl(dataSource);
});
