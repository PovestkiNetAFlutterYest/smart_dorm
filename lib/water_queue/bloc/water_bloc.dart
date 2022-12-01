import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_dorm/auth/resources/local_storage_repository.dart';
import 'package:smart_dorm/water_queue/bloc/water_event.dart';
import 'package:smart_dorm/water_queue/bloc/water_state.dart';
import '../dto/queue_item.dart';
import '../resources/repository.dart';

class WaterBloc extends Bloc<WaterEvent, WaterState> {
  final WaterQueueRepository waterRepo;
  final LocalStorageRepository localRepo;

  late final StreamSubscription dbSubscription;

  WaterBloc(this.waterRepo, this.localRepo) : super(WaterEmptyState()) {
    dbSubscription = waterRepo.firebaseProvider.client
        .collection('water_supply')
        .snapshots()
        .listen((event) {
      add(UpdateQueueEvent());
    });
    on<IncrementWaterCountEvent>((event, emit) async {
      try {
        List<DisplayQueueItem> data =
            await waterRepo.incrementWaterCounter(localRepo.getCurrentUser());
        emit(WaterSuccessState(data: data));
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
        List<DisplayQueueItem> data = await waterRepo.getQueue(localRepo.getCurrentUser());
        emit(WaterSuccessState(data: data));
      } on FirebaseException catch (e) {
        if (kDebugMode) {
          print("Firebase exception at IncrementWaterCountEvent: $e");
        }
        emit(WaterFailedState());
      }
    });

  }
}
