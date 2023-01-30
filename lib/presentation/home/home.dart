import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:wallper_chnager/blocs/bloc/wallpaper_bloc.dart';
import 'package:wallper_chnager/data/remote_data_source/wallpaper_api.dart';
import 'package:wallper_chnager/model/photo.dart';
import 'package:wallper_chnager/presentation/home/view_wallpaper.dart';

import '../../constant.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

List<Photos> photo = [];
String noImageFound = '';
WallpaperApi wallpaperApi = WallpaperApi();

class _HomePageState extends State<HomePage> {
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ConstantColors.scaffoldColor,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  width: size.width,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.7),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: Colors.blue,
                        style: BorderStyle.solid,
                        strokeAlign: BorderSide.strokeAlignOutside,
                        width: 1.5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, bottom: 1),
                    child: Center(
                      child: TextField(
                          controller: controller,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 20),
                          decoration: InputDecoration(
                            hintText: 'e.g  Nature',
                            hintStyle: const TextStyle(fontSize: 20),
                            border: InputBorder.none,
                            suffixIcon: Container(
                              color: Colors.black.withOpacity(0.15),
                              child: IconButton(
                                  onPressed: () {
                                    noImageFound = controller.text;
                                    context.read<WallpaperBloc>().add(
                                        WallpaperSearch(
                                            query: controller.text));
                                    controller.clear();
                                    FocusScope.of(context).unfocus();
                                  },
                                  icon: const Icon(
                                    Iconsax.search_zoom_out_1,
                                    color: Colors.black,
                                    size: 25,
                                  )),
                            ),
                          )),
                    ),
                  ),
                )),
            const SizedBox(height: 10),
            Expanded(
              child: BlocBuilder<WallpaperBloc, WallpaperState>(
                builder: (context, state) {
                  if (state is WallpaperLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    );
                  }
                  if (state is WallPaperSearchedResult) {
                    return state.photos.isNotEmpty
                        ? GridView.builder(
                            itemCount: state.photos.length,
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 200,
                                    childAspectRatio: 3 / 2.5,
                                    crossAxisSpacing: 15,
                                    mainAxisSpacing: 25),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ViewWallpaper(
                                              url: state.photos[index].portrait,
                                            ))),
                                child: Padding(
                                  padding: const EdgeInsets.all(0),
                                  child: Card(
                                      elevation: 10,
                                      shape: const RoundedRectangleBorder(
                                          side: BorderSide(
                                              color: Colors.white, width: 0.5),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5))),
                                      child: CachedNetworkImage(
                                        imageUrl: state.photos[index].medium,
                                        fit: BoxFit.cover,
                                      )),
                                ),
                              );
                            })
                        : Center(
                            child: Text(
                              'No Image found for $noImageFound',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                          );
                  }
                  if (state is WallpaperError) {
                    return Center(child: Text(state.error.toString()));
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
