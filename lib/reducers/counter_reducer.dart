import 'package:digamobile/actions/counter_actions.dart';

int counterReducer(int currentCount, action) {
  if (action is IncrementCountAction) {
    currentCount = currentCount + 3;
    return currentCount;
  } else if (action is DecrememtCountAction) {
    currentCount--;
    return currentCount;
  } else {
    return currentCount;
  }
}