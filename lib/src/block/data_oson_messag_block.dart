import 'package:data_oson_aptek/src/api/provider.dart';
import 'package:data_oson_aptek/src/database/database_helper.dart';
import 'package:data_oson_aptek/src/model/oson_aptek_messag_model.dart';
import 'package:rxdart/subjects.dart';

class DataOsonAptekBlock {
  DatabaseHelper databaseHelper = DatabaseHelper();
  AppProvider appProvider = AppProvider();

  final _fetchOsonData = PublishSubject<List<OsonAptekMessageModel>>();
  final _fetchDatabase = PublishSubject<List<OsonAptekMessageModel>>();

  Stream<List<OsonAptekMessageModel>> get getOsonAptek => _fetchOsonData.stream;

  Stream<List<OsonAptekMessageModel>> get getDatabase => _fetchDatabase.stream;

  List<OsonAptekMessageModel> data = [];

  allOsonAptek() async {
    data = await appProvider.getOsonAptek();
    compare(data);
  }

  allDatabase() async {
    List<OsonAptekMessageModel> database = await databaseHelper.getData();
    _fetchDatabase.sink.add(database);
  }

  compare(List<OsonAptekMessageModel> data) async {
    List<OsonAptekMessageModel> database = await databaseHelper.getData();
    for (int i = 0; i < data.length; i++) {
      data[i].liked = false;
      for (int j = 0; j < database.length; j++) {
        if (data[i].id == database[j].id) {
          data[i].liked = true;
          break;
        }
      }
    }
    _fetchOsonData.sink.add(data);
  }

  Future<int> saveData(OsonAptekMessageModel saqla) async {
    int id = await databaseHelper.saveData(saqla);
    compare(data);
    return id;
  }

  Future<int> updateDate(OsonAptekMessageModel yangilash) async {
    int id = await databaseHelper.updateData(yangilash);
    allOsonAptek();
    return id;
  }

  Future<int> deleteDate(int idisi) async {
    int id = await databaseHelper.deleteData(idisi);
    allDatabase();
    return id;
  }
}

final dataOsonAptekBlock = DataOsonAptekBlock();
