class TaskModel {
  int taskId;
  String text;
  String description;
  DateTime dueDate;
  int status; //0 -> To Do, 1 -> In Progress, 2 -> Done
  int? blockedBy;

  TaskModel(
    this.taskId,
    this.text,
    this.description,
    this.dueDate,
    this.status,
    this.blockedBy,
  );
}
