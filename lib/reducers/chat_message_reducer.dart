import 'package:dash_chat/dash_chat.dart';
import 'package:digamobile/actions/messaging_actions.dart';
import 'package:digamobile/models/api_specific_models/snatchbot_message_response_model.dart';

List<ChatMessage> chatMessageReducer(
    List<ChatMessage> currentMessages, action) {
  if (action is AddMessageAction) {}

  return currentMessages;
}
