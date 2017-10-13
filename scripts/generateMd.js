var Parser = require('jsonschema-markdown');
var fs = require('fs');
var schema = require('../patrimoine.schema.json');

var generator = new Parser(schema, { });
generator.addSchema(schema.properties.Baux.items);
generator.addSchema(schema.properties.Baux.items.properties.Compteurs.items);
generator.addSchema(schema.properties.Baux.items.properties.Locataires.items);
generator.addSchema(schema.properties.Proprietaire);

var markdown = generator.generateMarkdown();

fs.writeFile("connecteur_patrimoine.md", markdown, function(err) {
    if(err) {
        return console.log(err);
    }

    console.log("The md file was saved!");
});


