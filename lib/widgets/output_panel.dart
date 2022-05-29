import 'package:flutter/material.dart';
import 'package:flutter_dio_example/extensions/extensions.dart';
import 'package:flutter_dio_example/models/models.dart';

class OutputPanel extends StatelessWidget {
  const OutputPanel({
    Key? key,
    this.user,
    this.showLoading = false,
  }) : super(key: key);
  final User? user;
  final bool showLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 195.0,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('Output Log').fontSize(15.0).bold(),
          const SizedBox(height: 16.0),
          showLoading
              ? const Center(child: CircularProgressIndicator())
              : user == null
                  ? const Center(child: Text('No output log to show'))
                  : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Column(
                        children: [
                          UserData(
                            dataKey: 'id',
                            dataValue: user!.id!.toString(),
                          ),
                          UserData(dataKey: 'name', dataValue: user!.name),
                          UserData(dataKey: 'email', dataValue: user!.email),
                          UserData(
                            dataKey: 'gender',
                            dataValue: user!.gender.toString(),
                          ),
                          UserData(
                            dataKey: 'status',
                            dataValue: user!.status.toString(),
                          ),
                        ],
                      ),
                  ),
        ],
      ),
    );
  }
}

class UserData extends StatelessWidget {
  const UserData({
    Key? key,
    required this.dataKey,
    required this.dataValue,
  }) : super(key: key);
  final String dataKey;
  final String dataValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        children: [
          Expanded(flex: 1, child: Text('$dataKey: ').fontSize(15.0).bold()),
          Expanded(flex: 3, child: Text(dataValue).fontSize(15.0)),
        ],
      ),
    );
  }
}
