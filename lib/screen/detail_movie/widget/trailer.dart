import 'package:bloc_project/bloc/movie_detail_bloc/movie_detail_bloc.dart';
import 'package:bloc_project/data/model/trailer_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Trailer extends StatelessWidget {
  const Trailer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailBloc, MovieDetailState>(builder: (context, state) {
      switch (state.status) {
        case MovieDetailStatus.initial:
          return const Center(child: CupertinoActivityIndicator());
        case MovieDetailStatus.success:
          return _detail(trailerList: state.trailerList!);
        case MovieDetailStatus.failure:
          return const Center(child: Text('failed to fetch posts'));
      }
    });
  }

  Widget _detail({required List<TrailerModel> trailerList}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Text(
            'Трейлер',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(
          height: 250,
          child: PageView.builder(
              itemCount: trailerList.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 7, vertical: 7),
                  width: MediaQuery.of(context).size.width * 0.97,
                  child: _videoTrailer(
                    trailer: trailerList[index],
                  ),
                );
              }),
        ),
      ],
    );
  }

  Widget _videoTrailer({required TrailerModel trailer}) {
    return Scaffold(
      body: YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: YoutubePlayerController(
            initialVideoId: trailer.key,
            flags: const YoutubePlayerFlags(
              autoPlay: false,
              mute: false,
            ),
          ),
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.amber,
          progressColors: const ProgressBarColors(
            playedColor: Colors.amber,
            handleColor: Colors.amberAccent,
          ),
        ),
        builder: (context, player) => player,
      ),
    );
  }
}
