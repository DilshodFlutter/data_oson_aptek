import 'package:data_oson_aptek/src/block/data_oson_messag_block.dart';
import 'package:data_oson_aptek/src/model/oson_aptek_messag_model.dart';
import 'package:flutter/material.dart';

class DataOsonAptekMessage extends StatefulWidget {
  const DataOsonAptekMessage({Key? key}) : super(key: key);

  @override
  State<DataOsonAptekMessage> createState() => _DataOsonAptekMessageState();
}

class _DataOsonAptekMessageState extends State<DataOsonAptekMessage> {
  @override
  void initState() {
    super.initState();
    dataOsonAptekBlock.allOsonAptek();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("qwer"),
      ),
      body: ListView(
        children: [
          Container(
            height: 300,
            width: 70,
            color: Colors.red,
          ),
          StreamBuilder<List<OsonAptekMessageModel>>(
              stream: dataOsonAptekBlock.getOsonAptek,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<OsonAptekMessageModel> data = snapshot.data!;
                  return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Text(
                              data[index].name,
                              style: const TextStyle(
                                fontSize: 30,
                                color: Colors.black45,
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            Text(data[index].id.toString()),
                          ],
                        );
                      });
                }
                return Container();
              })
        ],
      ),
    );
  }
}
