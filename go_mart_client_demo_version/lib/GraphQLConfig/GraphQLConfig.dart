import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';


class GraphQLConfiguration {

  static HttpLink httpLink = HttpLink(
    'https://gomartdevdatabase.hasura.app/v1/graphql',
      defaultHeaders: {
     'x-hasura-admin-secret':'CMUnPHPjAMnYu0Os06EX48wSy7nRmG5fdWlakddMlxhhYdogd5lgnh1E08Kof4ID'
   }
  );





  static Link link = httpLink as Link;


    static ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      cache: GraphQLCache(),
      link: link,
    ),
  );

  static ValueNotifier<GraphQLClient> clientToQuery() {
    return client;
  }


  }










