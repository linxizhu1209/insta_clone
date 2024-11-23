import 'package:flutter/material.dart';

import 'chatroom_screen.dart';

class ChatroomListScreen extends StatelessWidget {
  const ChatroomListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("채팅방 목록"),
      ),
      body: ListView.builder( // todo 서버에서 채팅방 목록 불러오기 (상대방 이름-채팅방이름, 마지막 메시지, 시간, 상대방 사진)
          itemCount: 10,
          itemBuilder: (context, index){
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Text("${index+1}", // 상대방 사진
                  style: TextStyle(
                    color: Colors.white, // 텍스트 색상을 흰색으로 변경
                    fontWeight: FontWeight.bold, // 텍스트를 굵게
                  ),
                ),
              ),
              title: Text("채팅방 ${index+1}"), // 상대방 이름
              subtitle: Text("쌸라쌸라"), // 마지막 메시지
              trailing: Text("13:30 PM"), // 마지막 주고받은 시간
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChatroomScreen(roomName: "채팅방 ${index+1}"),
                        ),
                );
              },
            );
          }),
    );
  }
}
