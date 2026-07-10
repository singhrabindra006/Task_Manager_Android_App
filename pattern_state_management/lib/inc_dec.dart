import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pattern_state_management/bloc/counter_bloc.dart';
//import 'package:pattern_state_management/cubit/counter_cubit.dart';

class IncDec extends StatelessWidget {
  const IncDec({super.key});

  @override
  Widget build(BuildContext context) {
    final counterBloc = BlocProvider.of<CounterBloc>(context);
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,

        children: [
          FloatingActionButton(
            heroTag: 'incrementFab',
            onPressed: () {
              counterBloc.add(CounterIncremented());
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
            heroTag: 'decrementFab',
            onPressed: () {
              counterBloc.add(CounterDecremented());
            },
            tooltip: 'Decreament',
            child: const Icon(Icons.minimize),
          ),
        ],
      ),
    );
  }
}
