class Attendance {
   int id;
   String username;
   String? first_name;
   String? middle_name;
   String? last_name;
   String status;
   int event_id;

  Attendance({
    required this.id,
    this.first_name,
    this.middle_name,
    this.last_name,
    required this.username,
    required this.status,
    required this.event_id,
  });

}