import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/photo_bloc.dart';
import '../model/photo_model.dart';
import 'photo_detail_screen.dart';

class PhotoListScreen extends StatefulWidget {
  @override
  State<PhotoListScreen> createState() => _PhotoListScreenState();
}

class _PhotoListScreenState extends State<PhotoListScreen> {
  @override
  void initState() {
    BlocProvider.of<PhotoBloc>(context).add(FetchPhotos());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Unsplash Gallery',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      body: BlocBuilder<PhotoBloc, PhotoState>(
        builder: (context, state) {
          if (state is PhotoLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PhotoLoaded) {
            return ListView.builder(
              itemCount: state.photos.length,
              itemBuilder: (context, index) {
                Photo photo = state.photos[index];
                return ListTile(
                  leading: Image.network(
                    photo.url,
                    width: 100,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                  title: Text(
                    photo.title,
                    maxLines: 2,
                  ),
                  subtitle: Text('by ${photo.author}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PhotoDetailScreen(photo: photo),
                      ),
                    );
                  },
                );
              },
            );
          } else if (state is PhotoError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return const Center(child: Text('No photos found'));
          }
        },
      ),
    );
  }
}
