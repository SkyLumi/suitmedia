abstract class RemoteUserEvent {
  const RemoteUserEvent();
}

class GetUsers extends RemoteUserEvent {
  final int page;
  final bool isRefresh;
  
  const GetUsers({this.page = 1, this.isRefresh = false});
}