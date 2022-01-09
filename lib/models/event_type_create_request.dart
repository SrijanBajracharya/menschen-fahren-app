import 'package:project_menschen_fahren/models/event_type_edit_request.dart';

class EventTypeCreateRequest extends EventTypeEditRequest {
  EventTypeCreateRequest({description, name, voided})
      : super(description: description, name: name, voided: voided);
}
