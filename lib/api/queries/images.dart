typedef Query = String;

const Query uploadImageQuery = r"""
mutation ClassifyObject($file: Upload!) {
  classifyObject(input: {
    file: $file
  }) {
    properties {
      field
      value
    }
  }
}
""";

const Query upsertInventoryQuery = r"""
mutation UpsertInventory($input: InventoryUpsertInput!) {
  upsertInventory(input: $input) {
    id,
    files,
    properties {
      field
      value
    }
    comments
  }
}
""";
