import 'dart:async';

class SubscriptionsContainer {
  final _subscriptions = <StreamSubscription<dynamic>>[];

  set add(StreamSubscription<dynamic> subscription) {
    _subscriptions.add(subscription);
  }

  cancel() {
    for (var subscription in _subscriptions) {
      subscription.cancel();
    }
  }
}
