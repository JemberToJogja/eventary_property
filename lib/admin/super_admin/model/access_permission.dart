class AccessPermission {
  bool property;
  bool propertyMap;
  bool rental;
  bool maintenance;
  bool event;
  bool finance;

  AccessPermission({
    this.property = false,
    this.propertyMap = false,
    this.rental = false,
    this.maintenance = false,
    this.event = false,
    this.finance = false,
  });
}