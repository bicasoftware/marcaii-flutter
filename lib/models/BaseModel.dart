abstract class BaseModel {
  String getTableName();
  List<String> getColums();
  String getCreateSQL();

}