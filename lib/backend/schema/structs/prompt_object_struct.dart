// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class PromptObjectStruct extends FFFirebaseStruct {
  PromptObjectStruct({
    String? title,
    String? content,
    DateTime? createdAt,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _title = title,
        _content = content,
        _createdAt = createdAt,
        super(firestoreUtilData);

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  set title(String? val) => _title = val;

  bool hasTitle() => _title != null;

  // "content" field.
  String? _content;
  String get content => _content ?? '';
  set content(String? val) => _content = val;

  bool hasContent() => _content != null;

  // "createdAt" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  set createdAt(DateTime? val) => _createdAt = val;

  bool hasCreatedAt() => _createdAt != null;

  static PromptObjectStruct fromMap(Map<String, dynamic> data) =>
      PromptObjectStruct(
        title: data['title'] as String?,
        content: data['content'] as String?,
        createdAt: data['createdAt'] as DateTime?,
      );

  static PromptObjectStruct? maybeFromMap(dynamic data) => data is Map
      ? PromptObjectStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'title': _title,
        'content': _content,
        'createdAt': _createdAt,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'title': serializeParam(
          _title,
          ParamType.String,
        ),
        'content': serializeParam(
          _content,
          ParamType.String,
        ),
        'createdAt': serializeParam(
          _createdAt,
          ParamType.DateTime,
        ),
      }.withoutNulls;

  static PromptObjectStruct fromSerializableMap(Map<String, dynamic> data) =>
      PromptObjectStruct(
        title: deserializeParam(
          data['title'],
          ParamType.String,
          false,
        ),
        content: deserializeParam(
          data['content'],
          ParamType.String,
          false,
        ),
        createdAt: deserializeParam(
          data['createdAt'],
          ParamType.DateTime,
          false,
        ),
      );

  @override
  String toString() => 'PromptObjectStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is PromptObjectStruct &&
        title == other.title &&
        content == other.content &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode => const ListEquality().hash([title, content, createdAt]);
}

PromptObjectStruct createPromptObjectStruct({
  String? title,
  String? content,
  DateTime? createdAt,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    PromptObjectStruct(
      title: title,
      content: content,
      createdAt: createdAt,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

PromptObjectStruct? updatePromptObjectStruct(
  PromptObjectStruct? promptObject, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    promptObject
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addPromptObjectStructData(
  Map<String, dynamic> firestoreData,
  PromptObjectStruct? promptObject,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (promptObject == null) {
    return;
  }
  if (promptObject.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && promptObject.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final promptObjectData =
      getPromptObjectFirestoreData(promptObject, forFieldValue);
  final nestedData =
      promptObjectData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = promptObject.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getPromptObjectFirestoreData(
  PromptObjectStruct? promptObject, [
  bool forFieldValue = false,
]) {
  if (promptObject == null) {
    return {};
  }
  final firestoreData = mapToFirestore(promptObject.toMap());

  // Add any Firestore field values
  promptObject.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getPromptObjectListFirestoreData(
  List<PromptObjectStruct>? promptObjects,
) =>
    promptObjects?.map((e) => getPromptObjectFirestoreData(e, true)).toList() ??
    [];
