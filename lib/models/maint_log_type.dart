/*
// TODO: Substructure for Deferral?

/// Datatype for MaintLog/Workorder/Complaint including current Deferral if applicable
class MaintLogType {

  final String id;

  final String recordName;

  final DateTime entryDateTime;

  /// Free text fault description
  final String description;

  /// ATA Number, max length 8
  final String? ataNum;

  /// Type of MaintLog as FAULT = Fault Report, WORK = Work Order, INFO = Information Entry
  final String typeOfMaintLog;

  // ---- Deferral Info, actually comming from MaintAction ----

  // TODO: sorting inti  Categories already in data sent by Server? Also Breifingcards
  /// Status as PEND= Maintenance Required Item, DFRL= Deferred Item, CLSD = Closed Item
  final String status;

  /// MEL Reference etc. only usd for [status] = DFRL
  final String? deferralAuthorityRef;

  /// Type of Deferral as M= MEL, C= CDL, O= Other / Deferrable Defect / MEL 9.5
  final String? typeOfDeferral;

  /// Mel Category as A B C D X only used for [typeOfDeferral] = M
  final String? melCategory;

  final DateTime? expirationDate;
  final int? expirationFlightCycles;
  final int? expirationFlightHours;

  // ??? Ops Limits? Boolean?, Text?

  // --- Extension ---

  /// Warning level > 0 will result in Warning Indicator 1=yellow (due warning) 2= red (AOG, over due)
  final int warningLevel;

  MaintLogType(
      {required this.id,
      required this.recordName,
      required this.entryDateTime,
      required this.description,
      this.ataNum,
      required this.typeOfMaintLog,
      required this.status,
      this.deferralAuthorityRef,
      this.typeOfDeferral,
      this.melCategory,
      this.expirationDate,
      this.expirationFlightCycles,
      this.expirationFlightHours,
      required this.warningLevel});

  factory MaintLogType.fromJson(Map<String, dynamic> json) {
    return MaintLogType(
        id: json['id'] as String,
        recordName: json['recordName'] as String,
        entryDateTime: DateTime.parse(json['entryDateTime'] as String),
        description: json['description'] as String,
        ataNum: (json['ataNum'] != null) ? json['ataNum'] as String : null,
        typeOfMaintLog: json['typeOfMaintLog'] as String,
        status: json['status'] as String,
        deferralAuthorityRef: (json['deferralAuthorityRef'] != null)
            ? json['deferralAuthorityRef'] as String
            : null,
        typeOfDeferral: (json['typeOfDeferral'] != null)
            ? json['typeOfDeferral'] as String
            : null,
        melCategory: (json['melCategory'] != null)
            ? json['melCategory'] as String
            : null,
        expirationDate: (json['expirationDate'] != null)
            ? DateTime.parse(json['expirationDate'] as String)
            : null,
        expirationFlightCycles: (json['expirationFlightCycles'] != null)
            ? json['expirationFlightCycles'] as int
            : null,
        expirationFlightHours: (json['expirationFlightHours'] != null)
            ? json['expirationFlightHours'] as int
            : null,
        warningLevel: json['warningLevel'] as int);
  }
}
*/
