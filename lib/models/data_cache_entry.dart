/* Single entry in the cache service. */
class DataCacheEntry {

  /* The ID of the entity. */
  String id;

  /* The ID of the tenant this entry is for. */
  String tenantId;

  /* Time the data was last modified. */
  DateTime lastModifiedTimestamp;

  /* Type of the entry. Defines what the payload contains. */
  String entryTypeCode;

  /* The filter to search for this entry.*/
  String filterCriteria;

  /* The payload with the Json encoded data. */
  String payload;

  DataCacheEntry({required this.id, required this.tenantId, required this.lastModifiedTimestamp, required this.entryTypeCode, required this.filterCriteria, required this.payload});

  /* Build an entity from the given json data. */
  factory DataCacheEntry.fromJson(Map<String,dynamic> json) {

    return DataCacheEntry(
      id : json['id'],
      tenantId: json['tenantId'],
      lastModifiedTimestamp: DateTime.parse(json['lastModifiedTimestamp']),
      entryTypeCode: json['entryTypeCode'],
      filterCriteria: json['filterCriteria'],
      payload: json['payload'],
    );
  }

  /* Convenience method to translate a Json list of Approval. */
  static List<DataCacheEntry> listFromJson(List<dynamic> json) {
    return json.map((value) => DataCacheEntry.fromJson(value)).toList();
  }
}