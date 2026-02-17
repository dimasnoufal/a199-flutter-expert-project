import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_on_the_air_tv.dart';
import 'package:ditonton/domain/usecases/get_popular_tv.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tv_list_event.dart';
part 'tv_list_state.dart';

class TvListBloc extends Bloc<TvListEvent, TvListState> {
  final GetOnTheAirTv getOnTheAirTv;
  final GetPopularTv getPopularTv;
  final GetTopRatedTv getTopRatedTv;

  TvListBloc({
    required this.getOnTheAirTv,
    required this.getPopularTv,
    required this.getTopRatedTv,
  }) : super(const TvListState()) {
    on<FetchOnTheAirTv>(_onFetchOnTheAirTv);
    on<FetchPopularTv>(_onFetchPopularTv);
    on<FetchTopRatedTv>(_onFetchTopRatedTv);
  }

  Future<void> _onFetchOnTheAirTv(
    FetchOnTheAirTv event,
    Emitter<TvListState> emit,
  ) async {
    emit(state.copyWith(onTheAirState: RequestState.Loading));
    final result = await getOnTheAirTv.execute();
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            onTheAirState: RequestState.Error,
            message: failure.message,
          ),
        );
      },
      (tvData) {
        emit(
          state.copyWith(
            onTheAirState: RequestState.Loaded,
            onTheAirTv: tvData,
          ),
        );
      },
    );
  }

  Future<void> _onFetchPopularTv(
    FetchPopularTv event,
    Emitter<TvListState> emit,
  ) async {
    emit(state.copyWith(popularTvState: RequestState.Loading));
    final result = await getPopularTv.execute();
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            popularTvState: RequestState.Error,
            message: failure.message,
          ),
        );
      },
      (tvData) {
        emit(
          state.copyWith(
            popularTvState: RequestState.Loaded,
            popularTv: tvData,
          ),
        );
      },
    );
  }

  Future<void> _onFetchTopRatedTv(
    FetchTopRatedTv event,
    Emitter<TvListState> emit,
  ) async {
    emit(state.copyWith(topRatedTvState: RequestState.Loading));
    final result = await getTopRatedTv.execute();
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            topRatedTvState: RequestState.Error,
            message: failure.message,
          ),
        );
      },
      (tvData) {
        emit(
          state.copyWith(
            topRatedTvState: RequestState.Loaded,
            topRatedTv: tvData,
          ),
        );
      },
    );
  }
}
