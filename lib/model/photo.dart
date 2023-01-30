class Photos {
  final String portrait;
  final String medium;

  Photos({
    required this.portrait,
    required this.medium,
  });

  factory Photos.fromJson(Map<String, dynamic> json) {
    return Photos(
      portrait: json['src']['portrait'],
      medium: json['src']['medium'],
    );
  }
}
