import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

/// An abstract interface class for a socket client.
/// The generic type `T` represents the type of the connection.
abstract interface class SocketClient<T> {
  /// Connects to the specified [uri] and returns an instance of type [T].
  T connect(Uri uri);
}

/// A socket client implementation using WebSocketChannel.
class WebSocketChannelClient implements SocketClient<WebSocketChannel> {
  @override
  WebSocketChannel connect(Uri uri) {
    return WebSocketChannel.connect(uri);
  }
}

/// Provider for the WebSocketChannelClient.
final webSocketChannelClientProvider =
    Provider<SocketClient<WebSocketChannel>>((_) {
  return WebSocketChannelClient();
});
