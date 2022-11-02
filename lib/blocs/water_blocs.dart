import 'package:rxdart/rxdart.dart';
import 'package:smart_dorm/blocs/generate_queue.dart';
import 'package:smart_dorm/models/water_bring_counter.dart';

import '../models/user.dart';
import '../resources/repository.dart';

class MoviesBloc {
  final _repository = Repository();
  final _waterFetcher = PublishSubject<List<DisplayQueueItem>>();

  Stream<List<DisplayQueueItem>> get allWater => _waterFetcher.stream;

  fetchAllWater() async {
    List<WaterSupplyItem> waterCount = await _repository.fetchWaterCount();
    List<User> users = await _repository.fetchAllUsers();

    List<DisplayQueueItem> items = generateQueue(waterCount, users);

    _waterFetcher.sink.add(items);
  }

  userBringWater(String userId) async {
    _repository.incrementNumberWater(userId);
  }

  dispose() {
    _waterFetcher.close();
  }
}

final bloc = MoviesBloc();