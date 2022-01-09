import 'package:project_menschen_fahren/models/event_edit_request.dart';

class EventCreateRequest extends EventEditRequest {
  EventCreateRequest(
      {userId,
      name,
      location,
      countryCode,
      description,
      ageGroup,
      startDate,
      endDate,
      numberOfParticipants,
      isPrivate,
      eventTypeId})
      : super(
            userId: userId,
            name: name,
            location: location,
            countryCode: countryCode,
            description: description,
            ageGroup: ageGroup,
            startDate: startDate,
            endDate: endDate,
            numberOfParticipants: numberOfParticipants,
            isPrivate: isPrivate,
            eventTypeId: eventTypeId);
}
