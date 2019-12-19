class EntityTypeMissing extends Error {
  EntityTypeMissing();
  String toString() =>
      "Entity type was not specified. The query builder can not identity witch table to search";
}

class UpdateNotExistingEntityError extends Error {
  final Type entityType;
  UpdateNotExistingEntityError(this.entityType);
  String toString() =>
      "Can not update a ${entityType.toString()} without id. Insert it first.";
}
