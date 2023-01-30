import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:wallper_chnager/blocs/bloc/gallery_logic_bloc.dart';
import 'package:wallper_chnager/constant.dart';
import 'package:wallper_chnager/presentation/core/icon_button.dart';
import 'package:wallper_chnager/presentation/core/snackbar.dart';

class ViewWallpaper extends StatelessWidget {
  final String url;
  const ViewWallpaper({super.key, required this.url});
  @override
  Widget build(BuildContext context) {
    return BlocListener<GalleryLogicBloc, GalleryLogicState>(
        listener: (context, state) {
          if (state is WallpaperAppliedFailure) {
            ShowSnackBar()
                .showAlert(context: context, message: 'Failed !', error: true);
          }
          if (state is DownloadSuccess) {
            ShowSnackBar().showAlert(
                context: context,
                message: 'Downloaded Successfully !',
                error: false);
          }
          if (state is DownloadFailure) {
            ShowSnackBar()
                .showAlert(context: context, message: ' Failed !', error: true);
          }
          if (state is WallpaperShareFailure) {
            ShowSnackBar().showAlert(
                context: context, message: state.error.toString(), error: true);
          }
        },
        child: Scaffold(
          backgroundColor: ConstantColors.scaffoldColor,
          body: Column(
            children: [
              SizedBox(
                height: 100,
                child: Padding(
                  padding: const EdgeInsets.only(top: 40, left: 5),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            border: Border.all(
                                color: Colors.white.withOpacity(0.30),
                                strokeAlign: BorderSide.strokeAlignOutside),
                            borderRadius: BorderRadius.circular(12)),
                        child: IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(
                              Iconsax.arrow_left_2,
                              color: Colors.white,
                              size: 30,
                            )),
                      )),
                ),
              ),
              Stack(
                children: [
                  SizedBox(
                    child: CachedNetworkImage(
                      imageUrl: url,
                      fadeOutCurve: Curves.bounceIn,
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high,
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconBut(
                              ontap: () {
                                context
                                    .read<GalleryLogicBloc>()
                                    .add(ApplyWallpaperEvent(url: url));
                              },
                              icon: Iconsax.paintbucket,
                              description: 'Apply'),
                          const SizedBox(width: 50),
                          IconBut(
                              ontap: () {
                                context
                                    .read<GalleryLogicBloc>()
                                    .add(ShareWallpaperEvent(url: url));
                              },
                              icon: Iconsax.share4,
                              description: 'Share'),
                          const SizedBox(width: 50),
                          IconBut(
                              ontap: () {
                                context
                                    .read<GalleryLogicBloc>()
                                    .add(DownloadWallpaperEvent(url: url));
                              },
                              icon: Iconsax.document_download,
                              description: 'Download'),
                        ],
                      )),
                ),
              ),
            ],
          ),
        ));
  }
}
