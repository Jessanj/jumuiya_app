class Group {
  late final int  id;
  late final String group_name;
  late final String? group_type;
  late final String? group_location;
  late final String? members;
  late final String? description;
  late final String group_number;
  late final String created_at;
  late final String updated_at;
  late final int created_by;

  Group({
    required this.id,
    required this.group_name,
    required this.group_number,
    required this.created_at,
    required this.created_by,
    required this.updated_at,
    this.group_type,
    this.description,
    this.group_location,
    this.members,
  });

  factory Group.fromJson(Map<String, dynamic> json) => Group(
      id: json['id'],
      group_name: json['group_name'].toString(),
      group_number: json['group_number'].toString(),
      group_location: json['group_location'].toString(),
      group_type: json['group_type'].toString(),
      members: json['members'].toString(),
      description: json['description'].toString(),
      created_at:  json['created_at'].toString(),
      created_by: json['created_by'],
      updated_at: json['updated_at'].toString(),
    );

}