class GenericResponse<G, E>{
  G? data;
  E? error;
  int statusCode;

  GenericResponse({this.data,this.error, required this.statusCode});
}