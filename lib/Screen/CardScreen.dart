import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import '../Cubit/CardCubit.dart';
import '../Cubit/CardState.dart';
import 'Content.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({Key? key}) : super(key: key);

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  late List<bool> click;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final Cubit = context.read<CardCubit>().getEvents();
      click = List.generate(100, (index) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CardCubit, CardState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is FetchState) {
            return GridView.builder(

              shrinkWrap: true,
              physics: ScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 240,
                  childAspectRatio: 1,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10),
              itemCount: state.model.data.length,
              itemBuilder: (context, index) {
                if (state.model.data[index].eventHasDetail == true) {
                  return SizedBox();
                } else {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        click[index] = !click[index];
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: click[index] ? Colors.red : Colors.blue,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Content(
                        name: state.model.data[index].name.toString(),
                        id: state.model.data[index].id.toString(),
                        startDate: state
                            .model.data[index].airedDetail.startDateTime
                            .toString(),
                        image: state.model.data[index].eventPhoto,
                        status: state.model.data[index].status.toString(),
                      ),
                    ),
                  );
                }
              },
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
