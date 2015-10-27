#!/bin/bash

git pull

drupal_directory=/opt/drupal7/revisiones.seguridad.unam.mx/sites/default/modules/
git_directory=`pwd`

echo -n "Modulo que quieres actualizar: "
read module

cp ${drupal_directory}$module $git_directory

git add ${module}*

echo -n "git commit -m: "
read commit

git commit -m $commit

git push
