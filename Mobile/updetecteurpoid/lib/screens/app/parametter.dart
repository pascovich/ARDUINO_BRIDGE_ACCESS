import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:updetecteurpoid/logic/bloc/app_bloc.dart';
import 'package:updetecteurpoid/logic/bloc/app_event.dart';
import 'package:updetecteurpoid/logic/bloc/app_state.dart';

class Setting extends StatefulWidget {
  static String routeName = "/setting";
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  TextEditingController? _weight;
  Appbloc? _bloc;

  @override
  void initState() {
    _weight = TextEditingController();
    _bloc = Appbloc();
    super.initState();
  }

  void _submit() {
    if (_weight!.text.isNotEmpty) {
      _bloc!.add(
        SetParameter(
          weight: double.parse(
            _weight!.text.trim(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<Appbloc, AppState>(
      bloc: _bloc,
      listener: (context, state) {
        if (state is ParameterSet) {
          Navigator.pop(context, 'success');
        }
      },
      child: SafeArea(
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomAppBar(),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Configurez\nle poids authorisé",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey.withOpacity(.5),
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _weight,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Entrez le poids",
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text("Kg")
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: InkWell(
                  onTap: _submit,
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      gradient: const LinearGradient(
                        colors: <Color>[
                          Colors.pink,
                          Colors.pinkAccent,
                        ],
                      ),
                      color: Colors.pink,
                    ),
                    child: const Text(
                      "Appliquer",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 20,
          ),
        ),
        const Expanded(
          child: Text(
            "Paremetre",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Container(),
        ),
      ],
    );
  }
}
