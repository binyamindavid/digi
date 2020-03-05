import 'package:dash_chat/dash_chat.dart';
import 'package:digamobile/actions/messaging_actions.dart';
import 'package:digamobile/models/api_specific_models/snatchbot_message_response_model.dart';

List<ChatMessage> chatMessageReducer(
    List<ChatMessage> currentMessages, action) {
  if (action is AddMessageAction) {
    if (currentMessages != null) {
      return [...currentMessages, action.payload];
    } else {
      return <ChatMessage>[]..add(action.payload);
    }
  }

  if (action is AddAllMessagesAction) {
    if (currentMessages == null) {
      return action.payload;
    }
    return [...currentMessages, ...action.payload];
  }

  if (action is DeleteAllMessagesAction) {
    if (currentMessages != null) currentMessages.clear();
    return <ChatMessage>[];
  }

  return currentMessages;
}
