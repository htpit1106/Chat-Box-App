import 'package:chatbox/features/main/home/message/message_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessageCubit extends Cubit<MessageState> {
  MessageCubit() : super(MessageState());
}
