import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_dorm/water_queue/bloc/water_event.dart';
import 'package:smart_dorm/water_queue/bloc/water_state.dart';

import '../../auth/models/user.dart';
import '../dto/queue_item.dart';
import '../dto/water_bring_counter.dart';
import '../resources/hive_storage.dart';
import '../resources/repository.dart';
import 'generate_queue.dart';

class WaterBloc extends Bloc<WaterEvent, WaterState> {
  final WaterQueueRepository repository;
  final HiveStorage hiveStorage;

  WaterBloc(this.repository, this.hiveStorage) : super(WaterEmptyState()) {
    on<IncrementWaterCountEvent>((event, emit) async {
      emit(IncrementingCountState());
      try {
        await hiveStorage
            .incrementWaterCountCache(event.userId)
            .then((value) => emit(SuccessfullySavedLocally(data: value)));
        await repository
            .incrementWaterCounter(event.userId)
            .then((value) => emit(SuccessfullySavedGlobally(data: value)));
      } on FailedSaveLocallyState catch (e) {
        emit(e);
      } on FailedSaveGloballyState catch (e) {
        emit(e);
      }
    });

    on<RemindBringWaterEvent>((event, emit) async {
      emit(SuccessfullyRemindPersonState());
    });

    on<UpdateQueueEvent>((event, emit) async {
      try {
        // final queue = hiveStorage.getQueueCache();
        // emit(SuccessfullySavedLocally(data: queue));
        // print("local queue");
        // print(queue);
        await repository
            .getQueue()
            .then((value) {
          print("global queue");
          print(value);
          emit(SuccessfullySavedGlobally(data: value));
        });

      } on FailedSaveLocallyState catch (e) {
        emit(e);
      } on FailedSaveGloballyState catch (e) {
        emit(e);
      }
    });
  }

  Future<List<DisplayQueueItem>> getQueue() async {
    List list = await Future.wait(
        [repository.getWaterEntries(), repository.getAllUsers()]);

    List<WaterSupplyItem> waterCount = list[0] as List<WaterSupplyItem>;
    List<User> users = list[1] as List<User>;

    List<DisplayQueueItem> items = generateQueue(waterCount, users);

    return items;
  }
}
