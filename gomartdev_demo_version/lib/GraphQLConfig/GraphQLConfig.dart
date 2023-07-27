import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';


class GraphQLConfiguration {

  static HttpLink httpLink = HttpLink(
    'https://gomartdatabase.hasura.app/v1/graphql',
      defaultHeaders: {
      'x-hasura-admin-secret':'qWZMxSvDMzrzFbph5pTLedb2vIH3BRamuR3P6lehrDuCS1oyIrgehZPrCktrb3Gg'
   }
  );

  //static Future<String>? token = FirebaseAuth.instance.currentUser?.getIdToken();



  static Link link = httpLink as Link;
  /*static AuthLink authLink =AuthLink(
      getToken: () async => "Bearer $token"
  );*/

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










