class CounterRepo {
  //increment
  int increment({required int counter}) {
    return counter + 1;
  }

  //decrement
  int decrement({required int counter}) {
    return counter - 1;
  }
}
