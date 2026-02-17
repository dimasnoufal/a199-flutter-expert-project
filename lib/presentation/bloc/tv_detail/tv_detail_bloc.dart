import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_recommendations.dart';
import 'package:ditonton/domain/usecases/get_tv_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_tv_watchlist.dart';
import 'package:ditonton/domain/usecases/save_tv_watchlist.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tv_detail_event.dart';
part 'tv_detail_state.dart';

class TvDetailBloc extends Bloc<TvDetailEvent, TvDetailState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTvDetail getTvDetail;
  final GetTvRecommendations getTvRecommendations;
  final GetTvWatchListStatus getTvWatchListStatus;
  final SaveTvWatchlist saveTvWatchlist;
  final RemoveTvWatchlist removeTvWatchlist;

  TvDetailBloc({
    required this.getTvDetail,
    required this.getTvRecommendations,
    required this.getTvWatchListStatus,
    required this.saveTvWatchlist,
    required this.removeTvWatchlist,
  }) : super(const TvDetailState()) {
    on<FetchTvDetail>(_onFetchTvDetail);
    on<AddTvToWatchlist>(_onAddWatchlist);
    on<RemoveTvFromWatchlist>(_onRemoveWatchlist);
    on<LoadTvWatchlistStatus>(_onLoadWatchlistStatus);
  }

  Future<void> _onFetchTvDetail(
    FetchTvDetail event,
    Emitter<TvDetailState> emit,
  ) async {
    emit(state.copyWith(tvState: RequestState.Loading));
    final detailResult = await getTvDetail.execute(event.id);
    final recommendationResult = await getTvRecommendations.execute(event.id);
    detailResult.fold(
      (failure) {
        emit(
          state.copyWith(tvState: RequestState.Error, message: failure.message),
        );
      },
      (tv) {
        emit(
          state.copyWith(
            tv: tv,
            tvState: RequestState.Loaded,
            recommendationState: RequestState.Loading,
          ),
        );
        recommendationResult.fold(
          (failure) {
            emit(
              state.copyWith(
                recommendationState: RequestState.Error,
                message: failure.message,
              ),
            );
          },
          (tvs) {
            emit(
              state.copyWith(
                recommendationState: RequestState.Loaded,
                tvRecommendations: tvs,
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _onAddWatchlist(
    AddTvToWatchlist event,
    Emitter<TvDetailState> emit,
  ) async {
    final result = await saveTvWatchlist.execute(event.tv);
    await result.fold(
      (failure) async {
        emit(state.copyWith(watchlistMessage: failure.message));
      },
      (successMessage) async {
        emit(state.copyWith(watchlistMessage: successMessage));
      },
    );
    add(LoadTvWatchlistStatus(event.tv.id));
  }

  Future<void> _onRemoveWatchlist(
    RemoveTvFromWatchlist event,
    Emitter<TvDetailState> emit,
  ) async {
    final result = await removeTvWatchlist.execute(event.tv);
    await result.fold(
      (failure) async {
        emit(state.copyWith(watchlistMessage: failure.message));
      },
      (successMessage) async {
        emit(state.copyWith(watchlistMessage: successMessage));
      },
    );
    add(LoadTvWatchlistStatus(event.tv.id));
  }

  Future<void> _onLoadWatchlistStatus(
    LoadTvWatchlistStatus event,
    Emitter<TvDetailState> emit,
  ) async {
    final result = await getTvWatchListStatus.execute(event.id);
    emit(state.copyWith(isAddedToWatchlist: result));
  }
}
