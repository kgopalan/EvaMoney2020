//
//  testPostgreSqlAPI.h
//  Eva
//
//  Created by Poomalai on 10/21/17.
//  Copyright © 2017 Clover. All rights reserved.
//

#ifndef testPostgreSqlAPI_h
#define testPostgreSqlAPI_h

#include <stdio.h>

#endif /* testPostgreSqlAPI_h */



#include <stdio.h>
#include <stdlib.h>
#include <libpq/libpq-fe.h>
#include <string.h> // correct header


// select * from get_user_query_results (1, 'purchases by category', 'voice', 'ios')
const char *queryDBWithVoiceSearch(char *conninfo, char *queryString, char *userId) {
    
    PGconn     *conn;
    PGresult   *res;
    int         nFields;
    int         i,
    j;
    
    // Make a connection to the database
    conn = PQconnectdb(conninfo);
    
    // Check to see that the backend connection was successfully made
    if (PQstatus(conn) != CONNECTION_OK) {
        fprintf(stderr, "Connection to database failed: %s \n\n", PQerrorMessage(conn));
        return "error";
        PQfinish(conn);
        // exit(1);
    } else {
        fprintf(stderr, "Connection to database OK \n\n");
    }
    
    char SqlScript[4000] = "select * from get_user_query_results('";
    strcat(SqlScript, userId);
    strcat(SqlScript, "','");
    strcat(SqlScript, queryString);
    strcat(SqlScript, "','");
    strcat(SqlScript, "voice', 'ios')");
    
    fprintf(stderr, "SQL Query String : %s", SqlScript);
    // printf("\n\n");
    
    res = PQexec(conn, SqlScript);//"FETCH ALL in test");
    
    // res = PQexec(conn, "SELECT get_intent_as_json('test')");//"FETCH ALL in test");
    if (PQresultStatus(res) != PGRES_TUPLES_OK) {
        fprintf(stderr, "FETCH ALL failed: %s", PQerrorMessage(conn));
        return "error";
    }
    
    // first, print out the table collumn attribute names
    nFields = PQnfields(res);
    
    const char *str;
    for (i = 0; i < PQntuples(res); i++) {
        for (j = 0; j < nFields; j++) {
            str = PQgetvalue(res, i, j);
        }
    }
    PQfinish(conn);
    return str;
}

// select * from get_user_query_results (1, 'purchases by category', 'text', 'ios')
const char *queryDBWithTextSearch(char *conninfo, char *queryString, char *userId) {
    
    PGconn     *conn;
    PGresult   *res;
    int         nFields;
    int         i,
    j;
    
    // Make a connection to the database
    conn = PQconnectdb(conninfo);
    
    // Check to see that the backend connection was successfully made
    if (PQstatus(conn) != CONNECTION_OK) {
        fprintf(stderr, "Connection to database failed: %s \n\n", PQerrorMessage(conn));
        return "error";
        PQfinish(conn);
        // exit(1);
    } else {
        fprintf(stderr, "Connection to database OK \n\n");
    }
    
    char SqlScript[4000] = "select * from get_user_query_results('";
    strcat(SqlScript, userId);
    strcat(SqlScript, "','");
    strcat(SqlScript, queryString);
    strcat(SqlScript, "','");
    strcat(SqlScript, "text', 'ios')");
    
    fprintf(stderr, "SQL Query String : %s\n\n", SqlScript);
    // printf("\n\n");
    
    res = PQexec(conn, SqlScript);//"FETCH ALL in test");
    
    // res = PQexec(conn, "SELECT get_intent_as_json('test')");//"FETCH ALL in test");
    if (PQresultStatus(res) != PGRES_TUPLES_OK) {
        fprintf(stderr, "FETCH ALL failed: %s", PQerrorMessage(conn));
        return "error";
    }
    
    // first, print out the table collumn attribute names
    nFields = PQnfields(res);
    
    const char *str;
    for (i = 0; i < PQntuples(res); i++) {
        for (j = 0; j < nFields; j++) {
            str = PQgetvalue(res, i, j);
        }
    }
    fprintf(stderr, "SQL Query response : %s \n\n", str);
    PQfinish(conn);
    return str;
}


// select * from get_user_recent_searches (1)
const char *queryDBforRecentSearch(char *conninfo, char *userId) {
    
    PGconn     *conn;
    PGresult   *res;
    int         nFields;
    int         i,
    j;
    
    // Make a connection to the database
    conn = PQconnectdb(conninfo);
    
    // Check to see that the backend connection was successfully made
    if (PQstatus(conn) != CONNECTION_OK) {
        fprintf(stderr, "Connection to database failed: %s \n\n", PQerrorMessage(conn));
        return "error";
        PQfinish(conn);
        // exit(1);
    } else {
        fprintf(stderr, "Connection to database OK \n\n");
    }
    
    char SqlScript[4000] = "select * from get_user_recent_searches ('";
    strcat(SqlScript, userId);
    strcat(SqlScript, "')");
    
    fprintf(stderr, "SQL Query String : %s", SqlScript);
    // printf("\n\n");
    
    res = PQexec(conn, SqlScript);//"FETCH ALL in test");
    
    // res = PQexec(conn, "SELECT get_intent_as_json('test')");//"FETCH ALL in test");
    if (PQresultStatus(res) != PGRES_TUPLES_OK) {
        fprintf(stderr, "FETCH ALL failed: %s", PQerrorMessage(conn));
        return "error";
    }
    
    // first, print out the table collumn attribute names
    nFields = PQnfields(res);
    
    const char *str;
    for (i = 0; i < PQntuples(res); i++) {
        for (j = 0; j < nFields; j++) {
            str = PQgetvalue(res, i, j);
        }
    }
    PQfinish(conn);
    return str;
}



//select * from get_user_total_balance (1)
const char *getTotalBalance(char *conninfo, char *userId) {
    
    PGconn     *conn;
    PGresult   *res;
    int         nFields;
    int         i,
    j;
    
    // Make a connection to the database
    conn = PQconnectdb(conninfo);
    
    // Check to see that the backend connection was successfully made
    if (PQstatus(conn) != CONNECTION_OK) {
        fprintf(stderr, "Connection to database failed: %s \n\n", PQerrorMessage(conn));
        return "error";
        PQfinish(conn);
        // exit(1);
    } else {
        fprintf(stderr, "Connection to database OK \n\n");
    }
    
    char SqlScript[4000] = "select * from get_merchant_sales ('";
    strcat(SqlScript, userId);
    strcat(SqlScript, "')");
    
    fprintf(stderr, "SQL Query String : %s", SqlScript);
    // printf("\n\n");
    
    res = PQexec(conn, SqlScript);//"FETCH ALL in test");
    
    // res = PQexec(conn, "SELECT get_intent_as_json('test')");//"FETCH ALL in test");
    if (PQresultStatus(res) != PGRES_TUPLES_OK) {
        fprintf(stderr, "FETCH ALL failed: %s", PQerrorMessage(conn));
        return "error";
    }
    
    // first, print out the table collumn attribute names
    nFields = PQnfields(res);
    
    const char *str;
    for (i = 0; i < PQntuples(res); i++) {
        for (j = 0; j < nFields; j++) {
            str = PQgetvalue(res, i, j);
        }
    }
    PQfinish(conn);
    return str;
}



const char* get_c_string() {
    char s[] = "abc";
    return "abc";
}

