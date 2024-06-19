import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:unsplash_gallery/api/api_service.dart';
import 'package:unsplash_gallery/model/photo_model.dart';

part 'photo_event.dart';
part 'photo_state.dart';

class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  final ApiService apiService;

  PhotoBloc(this.apiService) : super(PhotoInitial()) {
    on<FetchPhotos>((event, emit) async {
      emit(PhotoLoading());
      try {
        final photos = await apiService.fetchPhotos();
        emit(PhotoLoaded(photos));
      } catch (error) {
        emit(PhotoError(error.toString()));
      }
    });
  }
}
