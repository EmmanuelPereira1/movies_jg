const getMovies = require('../services/getMovies');
const getMovieByTitle = require('../services/getMovieByTitle');

const resolvers = {
  Query: {
    movies: () => getMovies(),
    movie: (_, { title }) => getMovieByTitle(title),
  },
};

module.exports = resolvers;
