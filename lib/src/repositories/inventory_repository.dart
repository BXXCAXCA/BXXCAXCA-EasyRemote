import '../models/managed_device.dart';
abstract class InventoryRepository {
  Future<List<ManagedDevice>> loadDevices();
  Future<void> saveDevice(ManagedDevice device);
  Future<void> deleteDevice(String id);
  Future<void> replaceAll(List<ManagedDevice> devices);
}
