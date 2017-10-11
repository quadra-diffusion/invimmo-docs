#!/bin/sh
rm -Rf bad
mkdir bad
sed -e "s/1999-01-29/29\/01\/1999/" exemples/patrimoine-complet.json > bad/mauvais-format-date.json
sed -e 's/^\s"ReferenceExterne" : "ReferenceExternePatrimoine",//' exemples/patrimoine-complet.json > bad/manque-reference-patrimoine.json
sed -e '39,56d'  exemples/patrimoine-complet.json > bad/aucun-locataire.json
sed -e 's/59000/01234567891/' exemples/patrimoine-complet.json > bad/code-postal-trop-long.json
sed -e 's/"ReferenceExternePatrimoine",/"ReferenceExternePatrimoine","xx" : "yy",/' exemples/patrimoine-complet.json > bad/champ-additionnel-pat.json
sed -e 's/"ReferenceExternePropritaire",/"ReferenceExternePropritaire","xx" : "yy",/' exemples/patrimoine-complet.json > bad/champ-additionnel-pro.json
sed -e 's/"ReferenceExterneBail",/"ReferenceExterneBail","xx" : "yy",/' exemples/patrimoine-complet.json > bad/champ-additionnel-bail.json
sed -e 's/"ReferenceExterneLocataire",/"ReferenceExterneLocataire","xx" : "yy",/' exemples/patrimoine-complet.json > bad/champ-additionnel-loc.json
sed -e 's/"ReferenceExterneCompteur",/"ReferenceExterneCompteur","xx" : "yy",/' exemples/patrimoine-complet.json > bad/champ-additionnel-compt.json
find bad/ -maxdepth 1 -type f -print0 | xargs -0 -I {} ajv test -s patrimoine.schema.json -d {} --invalid
