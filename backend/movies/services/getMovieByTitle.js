const driver = require('../neo4j/driver');

async function getMovieByTitle(title) {
  const session = driver.session();
  const result = await session.run(`
    MATCH (m:Movie {title: $title})
    OPTIONAL MATCH (m)<-[:ACTED_IN]-(a:Person)
    OPTIONAL MATCH (m)<-[:DIRECTED]-(d:Person)
    RETURN m, collect(DISTINCT a) AS actors, collect(DISTINCT d) AS directors
  `, { title });

  await session.close();

  if (result.records.length === 0) return null;

  const m = result.records[0].get('m');
  const actors = result.records[0].get('actors').map(p => ({
    name: p.properties.name,
    born: parseInt(p.properties.born, 10),
  }));
  const directors = result.records[0].get('directors').map(p => ({
    name: p.properties.name,
    born: parseInt(p.properties.born, 10),
  }));

  return {
    identity: m.identity.toString(),
    labels: m.labels,
    properties: {
      title: m.properties.title,
      tagline: m.properties.tagline,
      released: parseInt(m.properties.released, 10),
    },
    elementId: m.elementId,
    actors,
    directors,
  };
}

module.exports = getMovieByTitle;
