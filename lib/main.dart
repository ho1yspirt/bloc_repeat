import 'package:bloc_repeat/bloc/counter_bloc.dart';
import 'package:bloc_repeat/counter_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => CounterRepo(),
      child: BlocProvider(
        create: (context) => CounterBloc(
          repo: RepositoryProvider.of<CounterRepo>(context),
        ),
        child: MaterialApp(
          theme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.dark,
          ),
          home: const MyHomePage(),
        ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    int counter = 0;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            BlocBuilder<CounterBloc, CounterState>(
              builder: (context, state) {
                if (state is CounterLoading) {
                  return const CircularProgressIndicator.adaptive();
                }
                if (state is CounterError) {
                  return const Icon(Icons.error_outline_rounded);
                }
                if (state is CounterSuccess) {
                  counter = state.counter;
                  return Text(
                    '${state.counter}',
                    style: Theme.of(context).textTheme.headlineMedium,
                  );
                }
                return Text(
                  '$counter',
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            onPressed: () {
              BlocProvider.of<CounterBloc>(context).add(
                IncrementCounter(counter: counter),
              );
            },
            tooltip: 'Increment',
            icon: const Icon(Icons.add),
            label: const Text('Increment'),
          ),
          const SizedBox(width: 8),
          FloatingActionButton.extended(
            onPressed: () {
              BlocProvider.of<CounterBloc>(context).add(
                DecrementCounter(counter: counter),
              );
            },
            tooltip: 'Decrement',
            icon: const Icon(Icons.remove),
            label: const Text('Decrement'),
          ),
        ],
      ),
    );
  }
}
