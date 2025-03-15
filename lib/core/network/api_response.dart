class ApiResponse<T> {
  LoadStatus? status;
  T? data;
  String? message;

  ApiResponse.idle(this.message) : status = LoadStatus.idle;
  ApiResponse.loading(this.message) : status = LoadStatus.loading;
  ApiResponse.loadingNextPage(this.message)
      : status = LoadStatus.loadingNextPage;
  ApiResponse.completed(this.data) : status = LoadStatus.completed;
  ApiResponse.error(this.message) : status = LoadStatus.error;
}

enum LoadStatus { idle, loading, loadingNextPage, completed, error }
