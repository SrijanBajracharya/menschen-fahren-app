class AircraftType {
  final String acReg;
  final String acType;
  final DateTime? departureDateTime;

  /* warnLevel:
    0: Dark Gray "normal"
    1: Yellow/Amber "Warn"
    2: Red "AOG"
   */
  final int warnLevel;
  final bool aog;

  /* melDueLevel:
    0: no MEL
    1: gray MEL
    2: yellow/amber MEL
    3: red MEL
   */
  final int melDueLevel;
  final bool ops;

  final bool melCatA;
  final bool melCatB;
  final bool melCatC;
  final bool melCatD;

  AircraftType({
    required this.acReg,
    required this.acType,
    this.departureDateTime,
    required this.warnLevel,
    required this.aog,
    required this.melDueLevel,
    required this.ops,
    required this.melCatA,
    required this.melCatB,
    required this.melCatC,
    required this.melCatD,
  });

  factory AircraftType.fromJson(Map<String, dynamic> json) {
    return AircraftType(
      acReg: json['acReg'] as String,
      acType: json['acType'] as String,
      departureDateTime: (json['departureDateTime'] != null)
          ? DateTime.parse(json['departureDateTime'] as String)
          : null,
      warnLevel: json['warnLevel'] as int,
      aog: json['aog'] as bool,
      melDueLevel: json['melDueLevel'] as int,
      ops: json['ops'] as bool,
      melCatA: json['melCatA'] as bool,
      melCatB: json['melCatB'] as bool,
      melCatC: json['melCatB'] as bool,
      melCatD: json['melCatD'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['acReg'] = this.acReg;
    data['acType'] = this.acType;
    data['departureDateTime'] = this.departureDateTime;
    return data;
  }
}
