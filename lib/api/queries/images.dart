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
mutation ui($properties: [PropertiesInput!], $comments: String!, $buildingId: String!, $localization: LocalizationInput!) {
  upsertInventory(input: {
    properties: $properties
    comments: $comments
    buildingId: $buildingId
    localization: $localization
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

const Query getInventoryQuery = r"""
query Query {
  getAllInventory {
    id
    buildingId
    comments
    files
    localization {
      x
      y
      z
    }
    properties {
      field
      value
    }
  }
}
""";
