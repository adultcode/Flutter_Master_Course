class ApiResponse<T> {
  Status status;
  T? data;
  int? server_code;

  ApiResponse.initial(this.server_code): status = Status.INITIAL;

  ApiResponse.loading(): status = Status.LOADING;

  ApiResponse.completed({this.data,this.server_code}): status = Status.COMPLETED;

  ApiResponse.error({this.data,this.server_code}): status = Status.ERROR;


}


enum Status { INITIAL, LOADING, COMPLETED, ERROR }