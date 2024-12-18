import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/connect/server.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        StoryArea(),
        FeedList(),
      ]),
    );
  }
}

class StoryArea extends StatelessWidget {
  const StoryArea({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(10, (index) => UserStory(userName: 'JuJu $index')),
      ),
    );
  }
}

class UserStory extends StatelessWidget {
  
  final String userName;
  
  const UserStory({
    required this.userName,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            margin:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            decoration: BoxDecoration(
                color: Colors.blue.shade300,
                borderRadius: BorderRadius.circular(40)),
          ),
          Text(userName),
        ],
      ),
    );
  }
}

class FeedData {
  final String userName;
  final int likeCount;
  final String content;
  final String imageUrl;

  FeedData({required this.imageUrl, required this.userName, required this.likeCount, required this.content});
}
// final feedDataList = [
//   FeedData(userName: 'juju1', likeCount: 30, content: '오늘 점심 굿~'),
//   FeedData(userName: 'juju2', likeCount: 5, content: '아우 뭐야'),
//   FeedData(userName: 'juju3', likeCount: 54, content: '가방 득템'),
//   FeedData(userName: 'juju4', likeCount: 15, content: '공부잼따'),
//   FeedData(userName: 'juju5', likeCount: 22, content: '인스타용 멘트'),
//   FeedData(userName: 'juju6', likeCount: 34, content: '도쿄가자~'),
//   FeedData(userName: 'juju7', likeCount: 12, content: '내일은월욜일'),
//   FeedData(userName: 'juju8', likeCount: 54, content: '회사가자'),
//   FeedData(userName: 'juju9', likeCount: 30, content: '오늘 저녁 굿~'),
// ];

class FeedList extends StatefulWidget {
  const FeedList({super.key});

  @override
  State<StatefulWidget> createState() => _FeedListState();
}

class _FeedListState extends State<FeedList> {
  late Future<List<FeedData>> _futureFeedData;

  @override
  void initState() {
    super.initState();
    _futureFeedData = fetchFeedDataWithImages();
  }

  Future<List<FeedData>> fetchFeedDataWithImages() async {
    try {
      final imageUrls = await ApiService.fetchServerData();

      return List.generate(imageUrls.length, (index) {
        final imageUrl = imageUrls[index];
        return FeedData(
            imageUrl: imageUrl,
            userName: 'JuJU${index + 1}',
            likeCount: (index + 1) * 5,
            content: '좋은 날');
      });

    } catch(e) {
      throw Exception('error! $e}');
    }
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<FeedData>>(
      future: _futureFeedData,
      builder: (context, snapshot)
    {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}'));
      } else if (snapshot.hasData) {
        final feedDataList = snapshot.data!;
        return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: feedDataList.length,
            itemBuilder: (context, index) =>
                FeedItem(feedData: feedDataList[index])
        );
      } else {
        return const Center(child: Text('No data available'));
      }
    },
    );
  }
}

class FeedItem extends StatelessWidget {
  final FeedData feedData;

  const FeedItem({required this.feedData, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue.shade300,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(feedData.userName),
                ],
              ),
              Icon(Icons.more_vert),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          height: 280,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(feedData.imageUrl), // 이미지 URL
              fit: BoxFit.cover, // 이미지를 컨테이너 크기에 맞게 조정
            ),
          ),
        ),
        // Container(
        //   width: double.infinity,
        //   height: 280,
        //   color: Colors.indigo.shade300,
        // ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(onPressed: (){}, icon: Icon(Icons.favorite_outline)),
                  IconButton(onPressed: (){}, icon: Icon(CupertinoIcons.chat_bubble)),
                  IconButton(onPressed: (){}, icon: Icon(CupertinoIcons.paperplane)),
                ],
              ),
              IconButton(onPressed: (){}, icon: Icon(CupertinoIcons.bookmark)),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text('좋아요 ${feedData.likeCount}개', style: const TextStyle(fontWeight: FontWeight.bold),),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
          child: RichText(text: TextSpan(
            children: [
              TextSpan(text: feedData.userName, style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: feedData.content),
            ],
           style: TextStyle(color: Colors.black),
          )),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
