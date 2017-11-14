#!/bin/sh
rm -Rf bad
mkdir bad
sed -e "s/1999-01-29/29\/01\/1999/" exemples/patrimoine-complet.json > bad/patrimoine-mauvais-format-date.json
sed -e 's/^\s"ReferenceExterne" : "ReferenceExternePatrimoine",//' exemples/patrimoine-complet.json > bad/patrimoine-manque-reference-patrimoine.json
sed -e '39,56d'  exemples/patrimoine-complet.json > bad/patrimoine-aucun-locataire.json
sed -e 's/59000/01234567891/' exemples/patrimoine-complet.json > bad/patrimoine-code-postal-trop-long.json
sed -e 's/"ReferenceExternePatrimoine",/"ReferenceExternePatrimoine","xx" : "yy",/' exemples/patrimoine-complet.json > bad/patrimoine-champ-additionnel-pat.json
sed -e 's/"ReferenceExternePropritaire",/"ReferenceExternePropritaire","xx" : "yy",/' exemples/patrimoine-complet.json > bad/patrimoine-champ-additionnel-pro.json
sed -e 's/"ReferenceExterneBail",/"ReferenceExterneBail","xx" : "yy",/' exemples/patrimoine-complet.json > bad/patrimoine-champ-additionnel-bail.json
sed -e 's/"ReferenceExterneLocataire",/"ReferenceExterneLocataire","xx" : "yy",/' exemples/patrimoine-complet.json > bad/patrimoine-champ-additionnel-loc.json
sed -e 's/"ReferenceExterneCompteur",/"ReferenceExterneCompteur","xx" : "yy",/' exemples/patrimoine-complet.json > bad/patrimoine-champ-additionnel-compt.json
find bad/patrimoine* -maxdepth 1 -type f -print0 | xargs -0 -I {} ajv test -s patrimoine.schema.json -d {} --invalid

sed -e 's/^\s"ReferenceExterneBail": "ReferenceExterneBail",//' exemples/planification-complet.json > bad/planification-manque-reference-bail.json
sed -e 's/^\s"Date": "2017-11-14T10:44:14+01:00",/"Date": "2017-11-14",/' exemples/planification-complet.json > bad/planification-date-et-heure-obligatoire.json
find bad/planification* -maxdepth 1 -type f -print0 | xargs -0 -I {} ajv test -s planification.schema.json -d {} --invalid
