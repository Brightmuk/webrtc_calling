part of 'call_cubit.dart';

@immutable
sealed class CallState {}

final class CallInitial extends CallState {}
final class CallInProgress extends CallState {}
