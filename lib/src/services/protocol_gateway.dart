import '../models/connection_protocol.dart';
import '../models/managed_device.dart';
import '../models/route_endpoint.dart';

class ProtocolLaunchRequest {
  const ProtocolLaunchRequest({
    required this.device,
    required this.route,
    required this.protocol,
  });

  final ManagedDevice device;
  final RouteEndpoint route;
  final ConnectionProtocol protocol;
}

abstract class ProtocolGateway {
  Future<void> prepare(ProtocolLaunchRequest request);

  Future<void> launch(ProtocolLaunchRequest request);
}

class PlaceholderProtocolGateway implements ProtocolGateway {
  @override
  Future<void> prepare(ProtocolLaunchRequest request) async {
    // Placeholder only. Future implementations must enforce explicit authorization.
  }

  @override
  Future<void> launch(ProtocolLaunchRequest request) async {
    // Placeholder only. No operational connection behavior is implemented here.
    throw UnimplementedError('Protocol launch is intentionally not implemented.');
  }
}
