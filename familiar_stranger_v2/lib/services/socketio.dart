import 'package:familiar_stranger_v2/controllers/conversationController.dart';
import 'package:familiar_stranger_v2/controllers/user/notificationController.dart';
import 'package:familiar_stranger_v2/services/api.dart';
import 'package:familiar_stranger_v2/ui/components/widgets/dialog/dialog_calling.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as socketIO;

late socketIO.Socket socket;
ConversationController conversationController = Get.put(ConversationController());
NotificationController notificationController = Get.put(NotificationController());

void connectSocket() {
  socket = socketIO.io('http://172.16.0.136:3000', <String, dynamic>{
    'transports': ['websocket'],
    'autoConnect': false,
  });
  socket.connect();
  socket.on('connect', (data) {
    print('Connected');

    socket.on('to-conversation', (data) => {conversationController.toConversation(data)});

    socket.on('disconnect-conversation', (data) => {Get.back()});

    socket.on('message', (data) => {
      print(data),
      conversationController.updateListMessage(data)
    });

    socket.on('sendNotification', (data) => {
      print(data),
      notificationController.addNotification(data)
    });

    socket.on('voiceCall', (data) => {
      (data['type'] == "voice")
      ? Get.dialog(DialogCalling(title:'Voice Call', 
        accept: (){
          Get.toNamed('/voice_calling', parameters: data);
        }, reject: (){
          Get.back();
        }))
      : Get.dialog(DialogCalling(title:'Video Call', 
        accept: (){
          Get.toNamed('/video_calling', parameters: data);
        }, reject: (){
          Get.back();
        }))
    });
  });
}

void signinSocket(id) {
  print('signin' + id);
  socket.emit('signin', id);
}

void logoutSocket() {
  socket.emit('logout');
}

void disconnect() {
  //socket.off('signin');

  socket.disconnect();

  socket.on('disconnect', (data) {
    print('disconnect');
  });
}

void startConnect() {
  socket.emit('start-connect');
}

void stopConnect() {
  socket.emit('stop-connect');
}

void disconnectConversation() {
  socket.emit('disconnect-conversation');
}

void message(data) {
  socket.emit('message', data);
}

void sendInvite(data) async {
  await addNotificationToData(data['senderId'], data['targetId'], "InviteToRoom", data['content']);
  socket.emit('sendNotification',data);
}

void sendAddFriend(data) async {
  if(await addFriend(data['targetId'])){
    userController.updateListFriend();
  } else {
    await addNotificationToData(data['senderId'], data['targetId'], "InviteToAddFriend", data['content']);
    socket.emit('sendNotification',data);  
  }
  
}


void acceptInvite(targerId){
  socket.emit('acceptInvite', targerId);
}

void voiceCall(data){
  socket.emit('voiceCall',data);
}