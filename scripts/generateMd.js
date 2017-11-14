var Parser = require('jsonschema-markdown');
var fs = require('fs');
var schema = require('../patrimoine.schema.json');
var schemaPlanification = require('../planification.schema.json');

var generator = new Parser(schema, { });
generator.addSchema(schema.items);
generator.addSchema(schema.items.properties.Baux.items);
generator.addSchema(schema.items.properties.Baux.items.properties.Compteurs.items);
generator.addSchema(schema.items.properties.Baux.items.properties.Locataires.items);
generator.addSchema(schema.items.properties.Proprietaire);

var generatorPlanification = new Parser(schemaPlanification, { });
generatorPlanification.addSchema(schemaPlanification.items);

var markdown = generator.generateMarkdown();
var markdownPlanification = generatorPlanification.generateMarkdown();

fs.writeFile("connecteur_patrimoine.md", markdown, function(err) {
    if(err) {
        return console.log(err);
    }

    console.log("The pat md file was saved!");
});
fs.writeFile("connecteur_planification.md", markdownPlanification, function(err) {
    if(err) {
        return console.log(err);
    }

    console.log("The plan md file was saved!");
});


