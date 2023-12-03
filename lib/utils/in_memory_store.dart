import 'package:rxdart/rxdart.dart';

class InMemoryStore<T> {
  final BehaviorSubject<T> _subject;

  InMemoryStore(T initial) : _subject = BehaviorSubject<T>.seeded(initial);

  // sera utilisé comme listener
  Stream<T> get stream => _subject.stream;

  T get value => _subject.value; // recuperer la dernière valeur

  set value(T value) => _subject.add(value); // mettre à jour la valeur

  void close() => _subject.close();
}
