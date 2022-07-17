import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_gallery_flutter/controllers/gallery_controller.dart';


class PhotoGalleryScreen extends StatelessWidget {
   PhotoGalleryScreen({Key? key}) : super(key: key) ;
  // {Get.put(GalleryController()); //agr is trha images get krni ha to init controller ka function
     //    GalleryController me bany ga
   //}

 final GalleryController galleryController = Get.put(GalleryController());
   //iss trha hum GalleryController me sy chizen get kr skty ha...galleryController ko instance bna k
   //agr is trha image get krni ha to intiState me changing krni ha






  @override
  Widget build(BuildContext context) {



    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),

          child: GetBuilder<GalleryController>(
          //  initState:(_) =>  galleryController.getImages() ,
            //iss trha hum simple yha image get kr rhy ha bjay is k, K hamy GalleryController me image get
            //krny ka function bnana pry
            builder: (controller){
              if(controller.status == GalleryStatus.loading){
                return const Center(child: CircularProgressIndicator(),);
              }
              if(controller.status == GalleryStatus.loaded){
                return GridView.builder(
                  itemCount: controller.images.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 6,
                    mainAxisSpacing: 6,
                  ), itemBuilder: (context, index){
                  return Image.network(
                    controller.images[index] , fit:  BoxFit.cover,);
                },
                );

              }
              else {
                return Container();
              }
            },

          ),

      ),
      ),
          floatingActionButton:  FloatingActionButton(
            onPressed: () {
              galleryController.lodeMore();

            },
            child: const Icon(
              Icons.add,
              color: Colors.black,

            ),

          ) ,
    );
  }
}
