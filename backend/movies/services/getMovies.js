const driver = require('../neo4j/driver');

async function getMovies() {
  const session = driver.session();
  const result = await session.run(`
    MATCH (m:Movie)
    OPTIONAL MATCH (m)<-[:ACTED_IN]-(a:Person)
    OPTIONAL MATCH (m)<-[:DIRECTED]-(d:Person)
    RETURN m, collect(DISTINCT a) AS actors, collect(DISTINCT d) AS directors
    LIMIT 171
  `);
  await session.close();

  return result.records.map(record => {
    const m = record.get('m');
    const actors = record.get('actors').map(p => ({
      name: p.properties.name,
      born: parseInt(p.properties.born, 10)
    }));
    const directors = record.get('directors').map(p => ({
      name: p.properties.name,
      born: parseInt(p.properties.born, 10)
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
  });
}

module.exports = getMovies;
