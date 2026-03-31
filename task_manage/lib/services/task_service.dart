import 'package:task_manage/services/api_client.dart';

class TaskService {
  final ApiClient _apiClient;

  TaskService(this._apiClient);

  Future<List<dynamic>> fetchTasks() async {
    // Look how clean this is! No manual headers required.
    final response = await _apiClient.dio.get('/tasks');
    return response.data;
  }

  // Create, Update, Delete go here...
}
