class BaseModel<T> {
  T data;
  int errorCode;
  String errorMsg;

  BaseModel(this.data, this.errorCode, this.errorMsg);
}
