class Notification {
  // Data members
  String description;
  int id;

  // Constructor
  Notification()
      : description = '',
        id = DateTime.now().millisecondsSinceEpoch;

  Notification.parameterized({
    required this.description,
  })  : id = DateTime.now().millisecondsSinceEpoch;

  // Setters
  void setDescription(String description) {
    this.description = description;
  }

  // Getters
  String getDescription() {
    return description;
  }
}