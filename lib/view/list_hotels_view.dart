import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ListHotelsView extends StatefulWidget {
  @override
  _ListHotelsViewState createState() => _ListHotelsViewState();
}

class _ListHotelsViewState extends State<ListHotelsView> {
  final _pageSize = 10;
  final _controller = ScrollController();
  var _currentPage = 0;
  var _isFetchingMore = false;
  final List<DocumentSnapshot> _documents = [];

  @override
  void initState() {
    super.initState();
    _controller.addListener(_scrollListener);
    _fetchData();
  }

  @override
  void dispose() {
    _controller.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      _loadMore();
    }
  }

  void _fetchData() {
    FirebaseFirestore.instance
        .collection('hotels_ru')
        .orderBy('price')
        .limit(_pageSize)
        .get()
        .then((querySnapshot) {
      setState(() {
        _documents.addAll(querySnapshot.docs);
      });
    });
  }

  void _loadMore() {
    if (!_isFetchingMore) {
      setState(() {
        _isFetchingMore = true;
      });

      FirebaseFirestore.instance
          .collection('hotels_ru')
          .orderBy('price')
          .startAfterDocument(_documents.last)
          .limit(_pageSize)
          .get()
          .then((querySnapshot) {
        setState(() {
          _documents.addAll(querySnapshot.docs);
          _isFetchingMore = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lazy Loading Screen'),
      ),
      body: _documents.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              controller: _controller,
              itemCount: _documents.length + (_isFetchingMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == _documents.length) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final document = _documents[index];
                final city = document['city'] as String;
                final price = document['price'] as String;

                return ListTile(
                  title: Text(city),
                  subtitle: Text(price),
                );
              },
            ),
    );
  }
}
