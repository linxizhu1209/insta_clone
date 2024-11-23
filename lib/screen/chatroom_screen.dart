import 'package:flutter/material.dart';

class ChatroomScreen extends StatelessWidget {
  final String roomName;

  const ChatroomScreen({required this.roomName, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(roomName),
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView(
                padding: EdgeInsets.all(8.0),
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 4.0),
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text("Hello!"), // 상대방이 보낸 메시지
                      //todo 상대방이 보낸 시간 및 상대방 이름, 상대방 사진
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 4.0),
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.blue[300],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text("Hi!!!!"), // 내가 보낸 메시지
                      // todo 내가 보낸 시간
                    ),
                  )
                ],
              ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "메시지를 입력해주세요",
                        border: OutlineInputBorder(),
                      ),
                    ),
                ),
                IconButton(
                  onPressed: (){
                    print("메시지 보내기 버튼이 눌렸습니다!");
                  },
                icon: Icon(Icons.send),
                ),
              ],
            ),)
        ],
      ),
    );
  }
}
