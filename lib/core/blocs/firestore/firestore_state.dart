part of 'firestore_bloc.dart';

abstract class FirestoreState extends Equatable {
  const FirestoreState();
  
  @override
  List<Object> get props => [];
}

class FirestoreInitial extends FirestoreState {}
