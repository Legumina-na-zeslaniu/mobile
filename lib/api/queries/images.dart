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
mutation ui($files: [Upload!], $properties: [PropertiesInput!], ){
  upsertInventory(input: {
    properties: $properties,
    files: $files
  }) {
    id
    comments
    properties {
      field
      value
    }
      files
  }
}
""";
