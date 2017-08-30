#!/bin/sh

git clone --branch gh-pages https://github.com/openfisca/openfisca.org.git
mv _book doc
rm --recursive --force openfisca.org/doc
mv doc openfisca.org/doc
cd openfisca.org
git add .
git config --global user.name "OpenFisca-Bot"
git config --global user.email "contact@openfisca.fr"
git commit --message="Push from openfisca doc"
git push https://github.com/openfisca/openfisca.org.git gh-pages
if git status --untracked-files=no ; then
	echo "There was an issue pushing to openfisca.org"
fi
# the following line removes all files in the branch exept the doc file.
git filter-branch --tree-filter 'rm --recursive --force $(git ls-files | grep --invert-match doc)' -- --all
# the following lines keep the context while changing branch.
git checkout --detach
git reset --soft doc-html
git checkout doc-html
git add .
git commit --message="Push from openfisca doc"
git push https://github.com/openfisca/openfisca.org.git gh-pages:doc-html