import 'package:get/get.dart';
import 'package:photo_gallery_flutter/keys.dart';
import 'package:photo_gallery_flutter/services/network_helper.dart';

enum GalleryStatus{
  loading,
  initial,
  loaded,
  error,
}


class GalleryController extends GetxController {
  //yha pe controller bnaya ha photo_gallery_screen k liye

  @override

  void onInit() {
    super.onInit();
    getImages();
  }

  GalleryStatus status = GalleryStatus.initial;

  int _page = 1;


  List<String> _images = [];

  List<String> get images{
    return [..._images];
  }
  int get photoCount => images.length;

  Future<void> getImages() async {
    status = GalleryStatus.loading;
    update();

      List<String> pixabyImages = [];

      String url = "https://pixabay.com/api/?key=$pixabyApiKey&image_type=photo&per_page=20&category=travel&page=$_page";
      NetworkHelper networkHelper = NetworkHelper(url: url);
      Map<String, dynamic> data = await networkHelper.getData();
      //entry represent all the items(Find by using JsonProExtension(google chrome))
      for (var entry in data["hits"]) {
        pixabyImages.add(entry["largeImageURL"]);
      }
      _images = pixabyImages;
    status = GalleryStatus.loaded;
      update();





  }

  Future<void> lodeMore() async {

    status = GalleryStatus.loading;
    update();
    List<String> pixabyImages = [];

    String url = "https://pixabay.com/api/?key=$pixabyApiKey&image_type=photo&per_page=20&category=travel&page={$_page + 1}";
    _page ++;
    NetworkHelper networkHelper = NetworkHelper(url: url);
    Map<String, dynamic> data = await networkHelper.getData();
    //entry represent all the items(Find by using JsonProExtension(google chrome))
    for (var entry in data["hits"]) {
      pixabyImages.add(entry["largeImageURL"]);
    }
    _images.addAll(pixabyImages);

    status = GalleryStatus.loaded;

    update();

  }
}