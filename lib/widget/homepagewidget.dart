import 'package:flutter/material.dart';
import 'package:instaapp/helpermethods/firestoremethos.dart';
import 'package:instaapp/view/commentspage.dart';

class Homepagewidget extends StatefulWidget {
  Homepagewidget({super.key, required this.data});
  final Map<String, dynamic> data;

  @override
  _HomepagewidgetState createState() => _HomepagewidgetState();
}

class _HomepagewidgetState extends State<Homepagewidget> {
  late bool isLiked;
  late String postId;

  @override
  void initState() {
    super.initState();
    isLiked = widget.data['isLiked'] ?? false;
    postId = widget.data['postid'];
  }

  void toggleLike() async {
    setState(() {
      isLiked = !isLiked;
    });

    try {
      if (isLiked) {
        await FirestoreMethods().addlike(postId);
        print('Added like');
      } else {
        await FirestoreMethods().removelike(postId);
        print('Removed like');
      }
    } catch (e) {
      print('Error toggling like: $e');
      // Revert the like state if there's an error
      setState(() {
        isLiked = !isLiked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String userImage = widget.data['userimage'] ?? 'https://via.placeholder.com/150';
    String username = widget.data['username'] ?? 'Unknown user';
    String postImage = widget.data['postimage'] ?? 'https://via.placeholder.com/600';
    String description = widget.data['description'] ?? '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(userImage),
              minRadius: 15,
            ),
            const SizedBox(width: 10),
            Text(username),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 4,
          child: InteractiveViewer(
            child: Image.network(
              postImage,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                print('Error loading post image: $error');
                return Text('Image not available');
              },
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: toggleLike,
              icon: Icon(
                Icons.favorite,
                color: isLiked ? Colors.red : Colors.grey,
              ),
            ),
            IconButton(onPressed: () {
              FirestoreMethods().deletepost(post: widget.data);
            }, icon: const Icon(Icons.remove)),
          ],
        ),
         Text('${widget.data['likes'].length} likes'),
        const SizedBox(height: 5),
        Text(description),
        const SizedBox(height: 10),
        TextButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return const CommentsPage();
            }));
          },
          child: const Text('add comment'),
        ),
        const Text(
          '1 hour ago',
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}
