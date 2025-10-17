part of 'call_cubit.dart';

@immutable
sealed class CallState extends Equatable{}

final class CallInitial extends CallState {
  @override
  List<Object?> get props => [];

}
final class CallInitialised extends CallState{
  final int version;
  final String roomId;
  final String stateText;

  CallInitialised({required this.version, required this.roomId, required this.stateText});
  
  @override
  List<Object?> get props => [version,roomId];
}
final class CallFailed extends CallState{
  final String error;

  CallFailed({required this.error});
  @override
  List<Object?> get props => [];
  
}

