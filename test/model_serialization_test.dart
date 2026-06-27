import 'package:flutter_test/flutter_test.dart';
import 'package:easyremote/src/models/app_settings.dart';
import 'package:easyremote/src/models/key_derivation_params.dart';
import 'package:easyremote/src/models/managed_device.dart';
import 'package:easyremote/src/models/connection_protocol.dart';
import 'package:easyremote/src/models/device_kind.dart';
import 'package:easyremote/src/models/route_endpoint.dart';
import 'package:easyremote/src/models/route_source.dart';

void main() {
  test('settings serializes to json map', () {
    final json = AppSettings.defaults().toJson();
    expect(json['requireEntryConfirmation'], isTrue);
  });

  test('key params serializes to json map', () {
    final json = KeyDerivationParams.recommendedPlaceholder().toJson();
    expect(json['algorithm'], isNotEmpty);
  });

  test('device serializes to json map', () {
    const device = ManagedDevice(
      id: 'd1',
      name: 'Demo',
      group: 'Group',
      kind: DeviceKind.generic,
      routes: [
        RouteEndpoint(
          id: 'r1',
          displayName: 'Route',
          source: 'local',
          sourceType: RouteSourceType.local,
          addressLabel: 'local',
          isAvailable: true,
          latencyMs: 1,
        ),
      ],
      protocols: [ConnectionProtocol.files],
    );
    expect(device.toJson()['id'], 'd1');
  });
}
