import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:updetecteurpoid/logic/bloc/app_bloc.dart';
import 'package:updetecteurpoid/logic/bloc/app_event.dart';
import 'package:updetecteurpoid/logic/bloc/app_state.dart';
import 'package:updetecteurpoid/logic/models/historic.dart';
import 'package:updetecteurpoid/screens/app/parametter.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    context.read<Appbloc>().add(
          GetHistoric(),
        );
    super.initState();
  }

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 500), () {
      context.read<Appbloc>().add(GetHistoric());
    });
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 10,
          shadowColor: Theme.of(context).shadowColor.withOpacity(.3),
          centerTitle: true,
          title: const Text(
            "Bridge app",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  Setting.routeName,
                );
              },
              icon: const Icon(
                Icons.settings,
                color: Colors.grey,
              ),
            )
          ],
        ),
        body: BlocBuilder<Appbloc, AppState>(builder: (context, state) {
          if (state is HistoricFound) {
            List<Historic> historics = state.historics!;
            return SmartRefresher(
              controller: _refreshController,
              onRefresh: _onRefresh,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    if (historics.isNotEmpty)
                      RealTimeView(
                        historic: historics.first,
                      ),
                    ...List.generate(
                      historics.length,
                      (index) => index == 0
                          ? Container()
                          : HistoricView(
                              historic: historics[index],
                            ),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is LoadingState) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.pink,
              ),
            );
          } else {
            return Container();
          }
        }),
      ),
    );
  }
}

class RealTimeView extends StatelessWidget {
  final Historic historic;
  const RealTimeView({Key? key, required this.historic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.parse(historic.heuredate!);
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(.05),
            offset: const Offset(0, 3),
            blurRadius: 3,
          ),
        ],
        gradient: const LinearGradient(
          colors: <Color>[
            Colors.pink,
            Colors.pinkAccent,
          ],
        ),
        color: Colors.pink,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text.rich(
              TextSpan(
                text: historic.poids.toString(),
                style: const TextStyle(
                  fontSize: 50,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                children: const <TextSpan>[
                  TextSpan(
                    text: "kg",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                historic.decision != "non" ? "Validate" : "Refusé",
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                "${date.day}-${date.month}-${date.year} à ${date.hour}:${date.minute}",
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class HistoricView extends StatelessWidget {
  final Historic historic;
  const HistoricView({Key? key, required this.historic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.parse(historic.heuredate!);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(.05),
            offset: const Offset(0, 3),
            blurRadius: 3,
          ),
        ],
        color: Colors.white,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text.rich(
              TextSpan(
                text: historic.poids.toString(),
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
                children: const <TextSpan>[
                  TextSpan(
                    text: "kg",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                historic.decision != "non" ? "Validate" : "Refusé",
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                "${date.day}-${date.month}-${date.year} à ${date.hour}:${date.minute}",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
