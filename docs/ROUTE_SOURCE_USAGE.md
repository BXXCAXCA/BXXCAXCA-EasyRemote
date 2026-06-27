# Route Source Usage

`RouteSourceType` identifies where a route came from.

Current values:

- `local`
- `manual`
- `mesh`
- `tunnel`
- `relay`
- `history`
- `unknown`

Use direct import when only the source type is needed:

```dart
import 'package:easyremote/src/models/route_source.dart';
```

Use the routing barrel when route endpoint and source type are both needed:

```dart
import 'package:easyremote/src/models/routing_models.dart';
```
