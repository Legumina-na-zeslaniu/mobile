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
mutation ui($properties: [PropertiesInput!], $comments: String!){
  upsertInventory(input: {
    properties: $properties
    comments: $comments
  }) {
    id
    comments
    properties {
      field
      value
    }
  }
}
""";
