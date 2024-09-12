# from flask import Flask, jsonify
# from flask_graphql import GraphQLView
# from app import schema  # Replace 'your_module' with the name of the Python file containing your schema
# import mysql.connector as mysql

# # Initialize Flask app
# app = Flask(__name__)

# # GraphQL endpoint
# app.add_url_rule(
#     '/graphql',
#     view_func=GraphQLView.as_view(
#         'graphql',
#         schema=schema,
#         graphiql=True  # Enable GraphiQL for testing
#     )
# )

# # Health check endpoint
# @app.route('/health', methods=['GET'])
# def health_check():
#     try:
#         # Create a test connection to check database health
#         db = mysql.connect(
#             host="localhost",
#             database="mdb",
#             user="root",
#             passwd="new_password",
#             auth_plugin='mysql_native_password'
#         )
#         cursor = db.cursor()
#         cursor.execute("SELECT 1")  # Simple query to check if DB is alive
#         return jsonify({"status": "healthy"}), 200
#     except Exception as e:
#         return jsonify({"status": "unhealthy", "error": str(e)}), 500

# if __name__ == "__main__":
#     app.run(debug=True)


from flask import Flask, jsonify, request
from graphene import ObjectType, String, Schema
from graphene import Field

app = Flask(__name__)

# Sample GraphQL schema
class Query(ObjectType):
    hello = String(name=String(default_value="World"))

    def resolve_hello(root, info, name):
        return f'Hello, {name}!'

schema = Schema(query=Query)

@app.route("/graphql", methods=["POST"])
def graphql_server():
    data = request.get_json()
    result = schema.execute(data.get('query'))
    return jsonify(result.data)

# Health check endpoint
@app.route('/health', methods=['GET'])
def health_check():
    return jsonify({"status": "healthy"}), 200

if __name__ == "__main__":
    app.run(debug=True)

