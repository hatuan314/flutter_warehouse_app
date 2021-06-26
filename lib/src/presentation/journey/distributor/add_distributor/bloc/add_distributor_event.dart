abstract class AddDistributorEvent {}

class PopAddDistributorEvent extends AddDistributorEvent {
  final String name;
  final String firstPhone;
  final String secondPhone;
  final String firstEmail;
  final String secondEmail;

  PopAddDistributorEvent({
    this.name,
    this.firstPhone,
    this.secondPhone,
    this.firstEmail,
    this.secondEmail,
  });
}

class CancelPopAddDistributorEvent extends AddDistributorEvent {}

class CreateDistributorEvent extends AddDistributorEvent {
  final String name;
  final String firstPhone;
  final String secondPhone;
  final String firstEmail;
  final String secondEmail;

  CreateDistributorEvent(
      {this.name,
      this.firstPhone,
      this.secondPhone,
      this.firstEmail,
      this.secondEmail});
}
