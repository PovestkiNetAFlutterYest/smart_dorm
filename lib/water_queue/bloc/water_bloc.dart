import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_dorm/water_queue/bloc/water_event.dart';
import 'package:smart_dorm/water_queue/bloc/water_state.dart';
import '../dto/queue_item.dart';
import '../resources/repository.dart';

class WaterBloc extends Bloc<WaterEvent, WaterState> {
  final WaterQueueRepository repository;

  late final StreamSubscription dbSubscription;

  WaterBloc(this.repository) : super(WaterEmptyState()) {
    dbSubscription = repository.firebaseProvider.client
        .collection('water_supply')
        .snapshots()
        .listen((event) {
      add(UpdateQueueEvent());
    });
    on<IncrementWaterCountEvent>((event, emit) async {
      emit(IncrementingCountState(event.previousData));
      try {
        List<DisplayQueueItem> data =
            await repository.incrementWaterCounter(event.userId);
        emit(SuccessfullySavedState(data: data));
      } on FirebaseException catch (e) {
        if (kDebugMode) {
          print("Firebase exception at IncrementWaterCountEvent: $e");
        }
        emit(WaterFailedState());
      }
    });

    on<RemindBringWaterEvent>((event, emit) async {
      emit(SuccessfullyRemindPersonState());
    });

    on<UpdateQueueEvent>((event, emit) async {
      try {
        List<DisplayQueueItem> data = await repository.getQueue();
        emit(SuccessfullySavedState(data: data));
      } on FirebaseException catch (e) {
        if (kDebugMode) {
          print("Firebase exception at IncrementWaterCountEvent: $e");
        }
        emit(WaterFailedState());
      }
    });
  }
}
