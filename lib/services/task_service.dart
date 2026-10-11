import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_task_manager/core/app_exception.dart';
import 'package:firebase_task_manager/models/task_model.dart';


/// firestore tasks user/uid/tasks/taskId
class TaskService {
  TaskService(this._firestore, this._auth);

  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  CollectionReference<Map<String, dynamic>> get _tasks {
    final uid = _auth.currentUser?.uid;
    if (uid == null) throw const AppException('You are not signed in.');
    return _firestore.collection('users').doc(uid).collection('tasks');
  }

  Stream<List<TaskModel>> watchTasks() => _tasks
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((snap) => snap.docs.map(TaskModel.fromDoc).toList());

  Future<TaskModel?> getTask(String id) async {
    final doc = await _tasks.doc(id).get();
    return doc.exists ? TaskModel.fromDoc(doc) : null;
  }

  Future<TaskModel> addTask(TaskModel task) async {
    final ref = await _tasks.add(task.toMap());
    return task.copyWith(id: ref.id);
  }

  Future<void> updateTask(TaskModel task) =>
      _tasks.doc(task.id).update(task.toMap());

  Future<void> deleteTask(String id) => _tasks.doc(id).delete();

  Future<void> setCompleted(String id, {required bool completed}) =>
      _tasks.doc(id).update({'isCompleted': completed});
}
