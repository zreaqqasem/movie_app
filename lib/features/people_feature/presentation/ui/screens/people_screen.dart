// People Screen - Single Responsibility Principle (SRP)
// Only responsible for UI rendering and user interaction
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/config/api_config.dart';
import 'package:movie_app/core/di/injection_container.dart';
import 'package:movie_app/features/people_feature/presentation/cubit/people_cubit.dart';
import 'package:movie_app/features/people_feature/presentation/cubit/people_state.dart';
import 'package:movie_app/features/people_feature/presentation/ui/widgets/people_card.dart';

class PeopleScreen extends StatelessWidget {
  const PeopleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<PeopleCubit>()..loadPeople(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('PEOPLE'),
          elevation: 2,
        ),
        body: BlocBuilder<PeopleCubit, PeopleState>(
          builder: (context, state) {
            if (state is PeopleLoadingState) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            } else if (state is PeopleLoadedState) {
              return _buildPeopleGrid(context, state);
            } else if (state is PeopleErrorState) {
              return _buildErrorWidget(context, state.message);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildPeopleGrid(BuildContext context, PeopleLoadedState state) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: state.people.length,
      itemBuilder: (context, index) {
        final person = state.people[index];
        return PeopleCard(
          imageUrl: person.profilePath != null
              ? '${ApiConfig.imageBaseUrl}${person.profilePath}'
              : '',
          actorName: person.name,
          onClick: (index) {
            // Handle click
          },
          print: () {
            // Handle print
          },
          index: index,
        );
      },
    );
  }

  Widget _buildErrorWidget(BuildContext context, String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 60,
          ),
          const SizedBox(height: 16),
          Text(
            'Error',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              context.read<PeopleCubit>().loadPeople();
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
