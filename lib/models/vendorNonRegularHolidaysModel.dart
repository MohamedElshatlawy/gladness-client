class NonRegularHolidatTime {
  String from;
  String to;
  NonRegularHolidatTime(this.from, this.to);
  toMap() => {"to": this.to, "from": this.from};
}
