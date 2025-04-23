const { gql } = require('apollo-server');

const typeDefs = gql`
  type MovieProperties {
    title: String
    released: Int
    tagline: String
  }

  type Person {
    name: String
    born: Int
  }

  type Movie {
    identity: ID
    labels: [String]
    properties: MovieProperties
    elementId: String
    actors: [Person]
    directors: [Person]
  }

  type Query {
    movies: [Movie]
    movie(title: String!): Movie
  }
`;

module.exports = typeDefs;
