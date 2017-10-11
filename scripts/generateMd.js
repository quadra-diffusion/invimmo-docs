var Parser = require('../node_modules/jsonschema-markdown/lib/parser');
var schema = require('../patrimoine.schema.json');

var generator = new Parser(schema, { });
generator.addSchema(schema.properties.Baux.items);
generator.addSchema(schema.properties.Baux.items.properties.Compteurs.items);
generator.addSchema(schema.properties.Baux.items.properties.Locataires.items);
generator.addSchema(schema.properties.Proprietaire);

var markdown = generator.generateMarkdown();

console.log (markdown);
