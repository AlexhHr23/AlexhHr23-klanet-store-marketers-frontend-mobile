class Balance {
  final int balance;
  final TimeZoneServer timeZone;

  Balance({required this.balance, required this.timeZone});

  /// Constructor vacío
  factory Balance.empty() =>
      Balance(balance: 0, timeZone: TimeZoneServer.empty());
}

class TimeZoneServer {
  final String time;
  final String tzServer;

  TimeZoneServer({required this.time, required this.tzServer});

  /// Constructor vacío
  factory TimeZoneServer.empty() => TimeZoneServer(time: '', tzServer: '');
}
