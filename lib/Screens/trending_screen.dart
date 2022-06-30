// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musixmatch_app/BLoC/internet_bloc/internet_bloc.dart';
import 'package:musixmatch_app/BLoC/internet_bloc/internet_state.dart';
import 'package:musixmatch_app/widgets/app_text.dart';

import '../BLoC/music_cubit_states.dart';
import '../BLoC/music_cubits.dart';
import 'details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<InternetBloc, InternetState>(
        listener: ((context, state) {
          if (state is InternetLostState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: AppText(
                    text: "Internet not connected!",
                    color: Colors.white,
                    size: 18),
                backgroundColor: Colors.red,
              ),
            );
          }
        }),
        builder: (context, state) {
          if (state is InternetLostState) {
            return Center(child: Text("No Internet Connection.."));
          } else if (state is InternetGainedState) {
            return MainScreen();
          } else {
            return Center(child: Text("Loading.."));
          }
        },
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MusicCubits, CubitStates>(
      builder: (context, state) {
        if (state is LoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is LoadedState) {
          return const TrendingScreen();
        }
        if (state is DetailState) {
          return DetailsScreen();
        } else {
          return Center(child: Text("Something went to wrong."));
        }
      },
    );
  }
}

class TrendingScreen extends StatelessWidget {
  const TrendingScreen({Key? key}) : super(key: key);

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
              centerTitle: true,
              title: AppText(
                text: "Trending",
                size: 22,
                isBold: true,
              ),
              backgroundColor: Colors.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 60.0),
            child: BlocBuilder<MusicCubits, CubitStates>(
              builder: (context, state) {
                if (state is LoadedState) {
                  var info = state.tracks;
                  return ListView.builder(
                      itemCount: info.length.toInt(),
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            BlocProvider.of<MusicCubits>(context)
                                .detailScreen(info[index]);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 20, left: 10, right: 10),
                            child: Container(
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    blurRadius: 3.0,
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.library_music,
                                      color: Colors.brown,
                                      size: 40,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                          width: 180,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AppText(
                                                text: info[index].track_name ??
                                                    "Running up That Hill",
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              AppText(
                                                  text:
                                                      info[index].album_name ??
                                                          "Hounds of Love",
                                                  size: 12),
                                            ],
                                          )),
                                      Container(
                                          width: 80,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AppText(
                                                  text:
                                                      info[index].artist_name ??
                                                          "Hounds of Love",
                                                  size: 14),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              AppText(
                                                  text:
                                                      "Rating: ${info[index].track_rating.toString()}",
                                                  size: 14),
                                            ],
                                          )),
                                      SizedBox(
                                        width: 5,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                } else {
                  return Center(
                      child: Text(
                    "Something is wrong...",
                  ));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

