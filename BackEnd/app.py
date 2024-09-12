import sys
import graphene
import mysql.connector as mysql
import json

# Connect to MySQL database

db = mysql.connect(
    host="localhost",
    database="mdb",
    user="root",
    passwd="new_password",
    auth_plugin='mysql_native_password'
)

# Create cursor to execute queries

cursor = db.cursor()

# Class having utility functions
class Utilities:
    def replace_expression(self, string):
        return str(string).replace(",", " and").replace(".", " or ").replace(":", "(").replace(";", ")")

Utilities.replace_expression = classmethod(Utilities.replace_expression)


##MODELS


# Bookmark Model

class Bookmark(graphene.ObjectType):
    bname = graphene.String()
    bookmark = graphene.String()

# Domain Model

class Domain(graphene.ObjectType):
    domain_name = graphene.String()

# Result Model

class Result(graphene.ObjectType):
    name = graphene.String()
    url = graphene.String()

# ProperDetail Model

class PropertyDetail(graphene.ObjectType):
    allowed_value = graphene.String()
    allowed_value_code = graphene.Int()

# Property Model

class Property(graphene.ObjectType):
    property_name = graphene.String()
    property_question = graphene.String()
    property_display_type = graphene.String()
    property_details = graphene.List(PropertyDetail)


##QUERIES


# Define all Queries
class Queries(graphene.ObjectType):
    bookmarks = graphene.List(Bookmark, domain_name=graphene.String(), user_id=graphene.String())
    bookmark_results = graphene.List(Result, bookmark_name=graphene.String(), domain_name=graphene.String(), user_id=graphene.String())
    domains = graphene.List(Domain)
    results = graphene.List(Result, domain_name=graphene.String(), query_params=graphene.String())
    properties = graphene.List(Property, domain_name=graphene.String(), offset=graphene.Int(), limit=graphene.Int())

    # bookmarks resolver

    def resolve_bookmarks(self, _, user_id, domain_name):
        query = "select bname, bookmark from userBookmark where userid='"+user_id+"' and domainName='"+domain_name+"'"
        cursor.execute(query)
        data = cursor.fetchall()
        bookmarks = []
        for item in data:
            bname, bookmark = item
            bookmarks.append(Bookmark(bname=bname,bookmark=bookmark))
        return bookmarks

    # bookmark results resolver

    def resolve_bookmark_results(self, _, user_id, domain_name, bookmark_name):
        query = "select bookmark from userBookmark where userid='"+user_id+"' and domainName='"+domain_name+"' and bname='"+bookmark_name+"'"
        cursor.execute(query)
        data = cursor.fetchall()
        query_params = Utilities.replace_expression(data[0][0])
        table_name = "collegeFactTable" if domain_name == "Colleges" else "autoFactTable"
        query = "select name, url from " + table_name + " where " + query_params
        cursor.execute(query)
        data = cursor.fetchall()
        bookmark_results = []
        for item in data:
            name, url = item
            bookmark_results.append(Result(name=name,url=url))
        bookmark_results.append(Result(name="query", url=query))
        return bookmark_results

    # domains resolver
    def resolve_domains(self, _):
        query = "select domainName from domain"
        cursor.execute(query)
        data = cursor.fetchall()
        domains = []
        for item in data:
            domains.append(Domain(domain_name=item[0]))
        return domains

    # results resolver

    def resolve_results(self, _, domain_name, query_params):
        query_params = Utilities.replace_expression(query_params)
        table_name = "collegeFactTable" if domain_name == "Colleges" else "autoFactTable"
        query = "select name, url from " + table_name
        if(len(str(query_params)) > 0):
            query += " where " + query_params
        cursor.execute(query)
        data = cursor.fetchall()
        results = []
        for item in data:
            name, url = item
            results.append(Result(name=name,url=url))
        results.append(Result(name="query", url=query))
        return results
    
    # properties resolver

    def resolve_properties(self, _, domain_name, offset=0, limit=3):
        query = "select JSON_ARRAYAGG(json_object('allowedValue', pd.allowedValue, 'allowedValueCode', pd.allowedValueCode)) as propertyDetails, p.propertyName, p.propertyQuestion, p.propertyDisplayType from mdb.property p join mdb.propertyDetail pd on p.domainName = pd.domainName and p.propertyName=pd.propertyName where p.domainName='" + domain_name + "' group by p.propertyName order by p.displayorder limit " + str(offset)+ ", " + str(limit)
        print(query)
        cursor.execute(query)
        data = cursor.fetchall()
        properties = []
        for item in data:
            print(item)
            property_details, property_name, property_question, property_display_type = item
            details = []
            for detail in json.loads(property_details):
                details.append(PropertyDetail(allowed_value=detail['allowedValue'], allowed_value_code=detail['allowedValueCode']))
            properties.append(Property(property_name=property_name, property_question=property_question, property_display_type=property_display_type, property_details=details))
        return properties


 ## MUTATIONS 


class CreateBookmark(graphene.Mutation):
    is_success = graphene.Boolean()
    class Arguments:
        bname = graphene.String()
        bookmark = graphene.String()
        domain_name = graphene.String()
        user_id = graphene.String()
    def mutate(self, _, bname, bookmark, domain_name, user_id):
        sql = "insert into userBookmark values ('"+user_id+"','"+domain_name+"','"+bname+"','"+bookmark+"')"
        print(sql)
        try:
            cursor.execute(sql)
            db.commit()
            return CreateBookmark(is_success=True)
        except Exception as e:
            print(e)
            db.rollback()
            return CreateBookmark(is_success=False)

class DeleteBookmark(graphene.Mutation):
    is_success = graphene.Boolean()
    class Arguments:
        user_id = graphene.String()
        domain_name = graphene.String()
        bname = graphene.String()
    def mutate(self, _, bname, domain_name, user_id):
        sql = "delete from userBookmark where userid='"+user_id+"' and domainName='"+domain_name+"' and bname='"+bname+"'"
        try:
            cursor.execute(sql)
            db.commit()
            return DeleteBookmark(is_success=True)
        except Exception as e:
            print(e)
            db.rollback()
            return DeleteBookmark(is_success=False)

class Mutations(graphene.ObjectType):
    create_bookmark = CreateBookmark.Field()
    delete_bookmark = DeleteBookmark.Field()

schema = graphene.Schema(query=Queries,mutation=Mutations)
