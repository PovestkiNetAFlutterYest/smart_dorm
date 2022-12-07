import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../auth/resources/local_storage_repository.dart';
import '../../dto/shower_timeslot.dart';
import '../../resources/repository.dart';
import 'add_shower_slot_event.dart';
import 'add_shower_slot_state.dart';

class AddShowerSlotsBloc extends Bloc<AddShowerSlotsEvent, AddShowerSlotState> {
  final ShowerSlotsRepository repository;
  final LocalStorageRepository localRepo;

  AddShowerSlotsBloc(this.repository, this.localRepo) : super(AddShowerSlotEmptyState()) {

    on<GetShowerSlotForCurrentUser>((event, emit) async {
      try {
        ShowerTimeSlot timeSlot = await repository.fetchShowerTimeslotByUser(localRepo.getCurrentUser());
        emit(AddShowerSlotSuccessState(
            timeSlotData: timeSlot
        ));
      } on FirebaseException catch (_) {
        emit(AddShowerSlotsFailedState());
      }
    });
  }
}
