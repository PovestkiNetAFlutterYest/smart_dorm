import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_dorm/water_queue/bloc/water_event.dart';
import 'package:smart_dorm/water_queue/bloc/water_state.dart';

import '../../auth/models/user.dart';
import '../dto/queue_item.dart';
import '../dto/water_bring_counter.dart';
import '../resources/repository.dart';
import 'generate_queue.dart';

class WaterBloc extends Bloc<WaterEvent, WaterState> {
  final WaterQueueRepository repository;

  WaterBloc(this.repository) : super(WaterEmptyState()) {
    on<IncrementWaterCountEvent>((event, emit) async {
      emit(IncrementingWaterCountState());
      try {
        repository.incrementWaterCounter(event.userId);
        emit(SuccessfullyIncrementWaterCountState());
      } catch (_) {
        emit(FailedIncrementWaterCountState());
      }
    });

    on<RemindBringWaterEvent>((event, emit) async {
      emit(SuccessfullyRemindPersonState());
    });

    on<UpdateQueueEvent>((event, emit) async {
      try {
        List list = await Future.wait(
            [repository.getWaterEntries(), repository.getAllUsers()]);

        List<WaterSupplyItem> waterCount = list[0] as List<WaterSupplyItem>;
        List<User> users = list[1] as List<User>;

        List<DisplayQueueItem> items = generateQueue(waterCount, users);
        emit(SuccessfullyFetchQueueState(data: items));
      } catch (_) {
        emit(FailedFetchQueueState());
      }
    });
  }
}
