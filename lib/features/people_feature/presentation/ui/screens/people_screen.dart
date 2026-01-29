import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/people_feature/date/models/popular_response_model.dart';
import 'package:movie_app/features/people_feature/date/people_service.dart';
import 'package:movie_app/features/people_feature/presentation/bloc/people_bloc.dart';
import 'package:movie_app/features/people_feature/presentation/bloc/people_states.dart';
import 'package:movie_app/features/people_feature/presentation/ui/widgets/people_card.dart';

class PeopleScreen extends StatefulWidget {
  const PeopleScreen({super.key});

  @override
  State<PeopleScreen> createState() => _PeopleScreenState();
}

class _PeopleScreenState extends State<PeopleScreen> {
  final PeopleCubit _cubit = PeopleCubit(PeopleInitialState());

  _getPeople() async {
    _cubit.getPeople(1);
  }

  @override
  void initState() {
    _getPeople();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => _cubit,
        child: BlocConsumer(
          bloc: _cubit,
          builder: (context, state) {
            if(state is PeopleLoading){
              return Center(child: CircularProgressIndicator.adaptive(),);
            }else if (state is PeopleSuccess){
              return _buildUI(context, state.response);
            }else if (state is PeopleFailure){
              return Center(child: Text(state.errorMessage),);
            }else {
              return SizedBox();
            }
          },
          listener: (context, state) {
            if (state is PeopleFailure){
              Scaffold.of(context).showBottomSheet((context){
                return SizedBox();
              });
            }
          },
        ),
      ),
    );
  }

  _buildUI(context, List<Result> people) {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: EdgeInsetsGeometry.all(9),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50),
              Text('PEOPLE', style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              SizedBox(
                height: MediaQuery.of(context).size.height / 1.25,
                width: double.infinity,
                child: ListView.builder(
                  itemCount: (people.length / 2).toInt(),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    final firstIndex = index * 2;
                    final secondIndex = index * 2 + 1;
                    return Padding(
                      padding: EdgeInsetsGeometry.all(10),
                      child: SizedBox(
                        height: 240,
                        width: 200,
                        child: Row(
                          children: [
                            PeopleCard(
                              onClick: (index) {},
                              index: firstIndex,
                              print: () {},
                              imageUrl:
                                  '${PeopleService.imageBaseUrl}${people[firstIndex].profilePath}',
                              actorName: people[firstIndex].name ?? 'No Name',
                            ),
                            SizedBox(width: 4),
                            PeopleCard(
                              onClick: (index) {},
                              index: secondIndex,
                              print: () {},
                              imageUrl:
                                  '${PeopleService.imageBaseUrl}${people[secondIndex].profilePath}',
                              actorName: people[secondIndex].name ?? 'No Name',
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
