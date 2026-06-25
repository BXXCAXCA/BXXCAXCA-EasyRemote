import 'package:flutter/material.dart';
import '../../services/route_merge_service.dart';
import '../../state/inventory_controller.dart';

class RoutePlannerPage extends StatelessWidget {
  const RoutePlannerPage({super.key, required this.inventoryController});
  final InventoryController inventoryController;

  @override
  Widget build(BuildContext context) {
    final planner = RouteMergeService();
    return AnimatedBuilder(
      animation: inventoryController,
      builder: (context, _) {
        final plan = planner.buildPlan(inventoryController.devices);
        return Scaffold(
          appBar: AppBar(title: const Text('Routes')),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const Card(child: ListTile(leading: Icon(Icons.info_outline), title: Text('Route planning'), subtitle: Text('Ranks stored metadata routes only.'))),
              const SizedBox(height: 12),
              ...plan.map((result) => Card(
                child: ExpansionTile(
                  leading: Icon(result.device.kind.icon),
                  title: Text(result.device.name),
                  subtitle: Text(result.bestRoute == null ? 'No available route' : 'Best: ${result.bestRoute!.displayName} · ${result.bestRoute!.latencyLabel}'),
                  children: result.rankedRoutes.map((route) => ListTile(
                    leading: const Icon(Icons.route_outlined),
                    title: Text(route.displayName),
                    subtitle: Text('${route.sourceType.label} · ${route.addressLabel} · score ${route.score}'),
                  )).toList(),
                ),
              )),
            ],
          ),
        );
      },
    );
  }
}
