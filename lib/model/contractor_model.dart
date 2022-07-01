class ContractorModel {
  String idContractor, nameContractor;

  ContractorModel({this.idContractor, this.nameContractor});
}

class CordinatorModel {
  String idCordinator, nameCordinator;
  List<String> job;

  CordinatorModel({this.idCordinator, this.nameCordinator, this.job});
}
