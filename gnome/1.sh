sed -i -r '/^#/d' *.po
sed -i -r '/^msgctxt/d' *.po
for file in $(ls | grep '.po$'); do msguniq --use-first $file -o ${file/.po/edited.po}; done
msgcat --use-first *edited.po -o all.po
rm -rf *edited.po
