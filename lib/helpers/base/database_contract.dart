abstract class DatabaseContract {
  int getVersion();

  String getDatabaseName();

  List<String> getCreateQueries();

  List<String> getDropQueries();

  List<String> getUpdateQueries();
}
