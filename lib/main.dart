import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallper_chnager/blocs/bloc/gallery_logic_bloc.dart';
import 'package:wallper_chnager/blocs/bloc/wallpaper_bloc.dart';
import 'package:wallper_chnager/data/local_data_source/local_storage.dart';
import 'package:wallper_chnager/presentation/home/home.dart';

import 'package:wallper_chnager/repository/wallpaper_logics.dart';

import 'data/remote_data_source/wallpaper_api.dart';

LocalStorage localStorage = LocalStorage();
String? lastSearchWord;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  lastSearchWord = (await localStorage.getlastSearchedWord());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WallpaperBloc>(
          create: (context) => WallpaperBloc(LocalStorage(),WallpaperApi())
            ..add(WallpaperSearch(query: lastSearchWord ?? 'Birds')),
        ),
        BlocProvider<GalleryLogicBloc>(
          create: (context) => GalleryLogicBloc(SetWallpaperLogics()),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Wallpaper Pro',
        theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
        home: const HomePage(),
      ),
    );
  }
}
