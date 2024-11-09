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
