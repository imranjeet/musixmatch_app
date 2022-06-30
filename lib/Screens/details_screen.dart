import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../BLoC/music_cubit_states.dart';
import '../BLoC/music_cubits.dart';
import '../services/api_provider.dart';
import '../widgets/app_text.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Container(
            height: 60,
            color: Colors.white,
            child: AppBar(
              elevation: 3.0,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () {
                        BlocProvider.of<MusicCubits>(context).goHome();
                      },
                      icon: const Icon(Icons.arrow_back_ios,
                          color: Colors.black)),
                  AppText(
                    text: "Track Details",
                    size: 22,
                    isBold: true,
                  ),
                ],
              ),
              backgroundColor: Colors.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 60.0),
            child: BlocBuilder<MusicCubits, CubitStates>(
              builder: (context, state) {
                DetailState detail = state as DetailState;
                // var lyrics = state.lyrics;
                return Container(
                  margin: const EdgeInsets.all(20),
                  height: double.maxFinite,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(text: "Name", size: 20, isBold: true),
                        const SizedBox(height: 5),
                        AppText(text: detail.track.track_name ?? ""),
                        const SizedBox(height: 10),
                        AppText(text: "Artist", size: 20, isBold: true),
                        const SizedBox(height: 5),
                        AppText(text: detail.track.artist_name ?? ""),
                        const SizedBox(height: 10),
                        AppText(text: "Album Name", size: 20, isBold: true),
                        const SizedBox(height: 5),
                        AppText(text: detail.track.album_name ?? ""),
                        const SizedBox(height: 10),
                        AppText(text: "Explicit", size: 20, isBold: true),
                        const SizedBox(height: 5),
                        AppText(text: detail.track.explicit.toString()),
                        const SizedBox(height: 10),
                        AppText(text: "Rating", size: 20, isBold: true),
                        const SizedBox(height: 5),
                        AppText(text: detail.track.track_rating.toString()),
                        const SizedBox(height: 20),
                        AppText(text: "Lyrics", size: 24, isBold: true),
                        const SizedBox(height: 10),
                        FutureBuilder(
                            future: DataServices()
                                .fetchLyrics(detail.track.track_id!),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return AppText(text: snapshot.data.toString());
                              } else {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                            })
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
