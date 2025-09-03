import 'dart:convert';
import 'package:bodoni/features/checklist/data/models/checklist_model.dart';
import 'package:shared_preferences/shared_preferences.dart';


abstract class ChecklistLocalDataSource {
  Future<List<ChecklistItemModel>> getChecklist();
  Future<void> saveChecklist(List<ChecklistItemModel> items);
  Future<void> addChecklistItem(ChecklistItemModel item);
  Future<void> updateChecklistItem(ChecklistItemModel item);
  Future<void> deleteChecklistItem(String id);
}

class ChecklistLocalDataSourceImpl implements ChecklistLocalDataSource {
  final SharedPreferences sharedPreferences;
  static const String checklistKey = 'CHECKLIST_ITEMS';

  ChecklistLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<List<ChecklistItemModel>> getChecklist() async {
    final jsonString = sharedPreferences.getString(checklistKey);
    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.map((json) => ChecklistItemModel.fromJson(json)).toList();
    }
    
    // Return default checklist if none exists
    final defaultItems = _getDefaultChecklist();
    await saveChecklist(defaultItems);
    return defaultItems;
  }

  @override
  Future<void> saveChecklist(List<ChecklistItemModel> items) async {
    final jsonString = json.encode(items.map((item) => item.toJson()).toList());
    await sharedPreferences.setString(checklistKey, jsonString);
  }

  @override
  Future<void> addChecklistItem(ChecklistItemModel item) async {
    final items = await getChecklist();
    items.add(item);
    await saveChecklist(items);
  }

  @override
  Future<void> updateChecklistItem(ChecklistItemModel item) async {
    final items = await getChecklist();
    final index = items.indexWhere((i) => i.id == item.id);
    if (index != -1) {
      items[index] = item;
      await saveChecklist(items);
    }
  }

  @override
  Future<void> deleteChecklistItem(String id) async {
    final items = await getChecklist();
    items.removeWhere((item) => item.id == id);
    await saveChecklist(items);
  }

  List<ChecklistItemModel> _getDefaultChecklist() {
    return [
      ChecklistItemModel(
        id: '1',
        title: 'Venue Booking',
        description: 'Book the perfect venue for your special day',
        isCompleted: false,
        createdAt: DateTime.now(),
      ),
      ChecklistItemModel(
        id: '2',
        title: 'Photography',
        description: 'Hire a professional photographer',
        isCompleted: false,
        createdAt: DateTime.now(),
      ),
      ChecklistItemModel(
        id: '3',
        title: 'Catering',
        description: 'Arrange delicious food for guests',
        isCompleted: false,
        createdAt: DateTime.now(),
      ),
      ChecklistItemModel(
        id: '4',
        title: 'Mehendi Ceremony',
        description: 'Plan and organize mehendi function',
        isCompleted: false,
        createdAt: DateTime.now(),
      ),
      ChecklistItemModel(
        id: '5',
        title: 'Sangeet',
        description: 'Organize music and dance ceremony',
        isCompleted: false,
        createdAt: DateTime.now(),
      ),
      ChecklistItemModel(
        id: '6',
        title: 'Honeymoon Booking',
        description: 'Book romantic honeymoon destination',
        isCompleted: false,
        createdAt: DateTime.now(),
      ),
    ];
  }
}