class GenericData<D, E>{
  D? data;
  E? error;
  Status status;

  bool get hasError => error != null;

  GenericData.loading({this.data, this.error, this.status = Status.loading});
  GenericData.success({this.data, this.error, this.status = Status.success});
  GenericData.failed({this.data, this.error, this.status = Status.failed}); 
  }
  enum Status { loading, failed, success }