import 'package:flutter/material.dart';
import 'package:flutter_dio_example/extensions/extensions.dart';
import 'package:flutter_dio_example/models/models.dart';
import 'package:flutter_dio_example/network/network.dart';
import 'package:flutter_dio_example/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DioClient dioClient = DioClient();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dio Example'),
        centerTitle: true,
        elevation: 2.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GETMethodTile(dioClient: dioClient),
            POSTMethodTile(dioClient: dioClient),
            DELETEMethodTile(dioClient: dioClient),
          ],
        ),
      ),
    );
  }
}

class GETMethodTile extends StatefulWidget {
  const GETMethodTile({Key? key, required this.dioClient}) : super(key: key);
  final DioClient dioClient;

  @override
  State<GETMethodTile> createState() => _GETMethodTileState();
}

class _GETMethodTileState extends State<GETMethodTile> {
  final TextEditingController _idController = TextEditingController();
  int? userId;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: const Text('GET Method'),
      childrenPadding: const EdgeInsets.symmetric(horizontal: 12.0),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Enter the ID of the user:').fontSize(16),
            SizedBox(
              width: 100,
              child: DataInputField(
                controller: _idController,
                inputType: TextInputType.number,
                onSubmitted: (id) => setState(() => userId = int.parse(id)),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        userId == null
            ? const OutputPanel()
            : FutureBuilder<User?>(
                future: widget.dioClient.getUser(id: userId!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const OutputPanel(showLoading: true);
                  } else if (snapshot.hasError) {
                    return OutputError(errorMessage: snapshot.error.toString());
                  } else if (snapshot.hasData) {
                    return OutputPanel(user: snapshot.data);
                  } else {
                    return const OutputPanel();
                  }
                },
              ),
        const SizedBox(height: 10.0),
      ],
    );
  }
}

class POSTMethodTile extends StatefulWidget {
  const POSTMethodTile({Key? key, required this.dioClient}) : super(key: key);
  final DioClient dioClient;

  @override
  State<POSTMethodTile> createState() => _POSTMethodTileState();
}

class _POSTMethodTileState extends State<POSTMethodTile> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  Gender gender = Gender.male;
  Status status = Status.active;

  bool isLoading = false;
  User? createdUser;
  String? error;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: const Text('POST Method'),
      childrenPadding: const EdgeInsets.symmetric(horizontal: 12.0),
      expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(flex: 2, child: const Text('Name:').fontSize(16)),
            Expanded(
              flex: 3,
              child: DataInputField(
                controller: _nameController,
                inputType: TextInputType.text,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        Row(
          children: [
            Expanded(flex: 2, child: const Text('Email:').fontSize(16)),
            Expanded(
              flex: 3,
              child: DataInputField(
                controller: _emailController,
                inputType: TextInputType.emailAddress,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        Row(
          children: [
            Expanded(flex: 2, child: const Text('Gender:').fontSize(16)),
            Expanded(
              flex: 3,
              child: GenderRadioInputField(
                genderValue: gender,
                onChanged: (value) => setState(() => gender = value!),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        Row(
          children: [
            Expanded(flex: 2, child: const Text('Status:').fontSize(16)),
            Expanded(
              flex: 3,
              child: StatusRadioInputField(
                statusValue: status,
                onChanged: (value) => setState(() => status = value!),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        ElevatedButton(
          onPressed: () async {
            setState(() => isLoading = true);
            final user = User(
              name: _nameController.text,
              email: _emailController.text,
              gender: gender,
              status: status,
            );

            try {
              final responseUser =
                  await widget.dioClient.createUser(user: user);
              setState(() => createdUser = responseUser);
            } catch (err) {
              setState(() => error = err.toString());
            }

            setState(() => isLoading = false);
          },
          child: const Text('POST'),
        ),
        const SizedBox(height: 10.0),
        isLoading
            ? const OutputPanel(showLoading: true)
            : createdUser != null
                ? OutputPanel(user: createdUser)
                : error != null
                    ? OutputError(errorMessage: error!)
                    : const OutputPanel(),
        const SizedBox(height: 10.0),
      ],
    );
  }
}

class DELETEMethodTile extends StatefulWidget {
  const DELETEMethodTile({Key? key, required this.dioClient}) : super(key: key);
  final DioClient dioClient;

  @override
  State<DELETEMethodTile> createState() => _DELETEMethodTileState();
}

class _DELETEMethodTileState extends State<DELETEMethodTile> {
  final TextEditingController _idController = TextEditingController();
  int? userId;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: const Text('DELETE Method'),
      childrenPadding: const EdgeInsets.symmetric(horizontal: 12.0),
      expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Enter the ID of the user:').fontSize(16),
            SizedBox(
              width: 100,
              child: DataInputField(
                controller: _idController,
                inputType: TextInputType.number,
                onSubmitted: (id) => setState(() => userId = int.parse(id)),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        userId == null
            ? const OutputPanel()
            : FutureBuilder<void>(
                future: widget.dioClient.deleteUser(id: userId!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const OutputPanel(showLoading: true);
                  } else if (snapshot.hasError) {
                    return OutputError(errorMessage: snapshot.error.toString());
                  } else {
                    return const OutputSuccess(
                        successMessage: 'User deleted successfully!');
                  }
                },
              ),
        const SizedBox(height: 10.0),
      ],
    );
  }
}
