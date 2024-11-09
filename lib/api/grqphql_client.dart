import 'package:graphql_flutter/graphql_flutter.dart';

final HttpLink httpLink = HttpLink(const String.fromEnvironment('GRAPHQL_URL',
    defaultValue: 'https://junction.rabbithole.carrotly.tech/graphql'));

final GraphQLClient client = GraphQLClient(
  link: httpLink,
  cache: GraphQLCache(),
  defaultPolicies: DefaultPolicies(
    query: Policies(
        cacheReread: CacheRereadPolicy.ignoreAll,
        fetch: FetchPolicy.noCache,
        error: ErrorPolicy.all),
  ),
);
