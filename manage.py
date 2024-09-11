from flask import Flask
from flask_graphql import GraphQLView
import graphene

# Your existing GraphQL schema code here

app = Flask(__name__)

# Set up the GraphQL endpoint
app.add_url_rule(
    '/graphql',
    view_func=GraphQLView.as_view(
        'graphql',
        schema=schema,
        graphiql=True  # Enable the GraphiQL interface for testing queries
    )
)

if __name__ == '__main__':
    app.run(debug=True)
