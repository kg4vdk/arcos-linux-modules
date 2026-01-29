#!/bin/bash

if [ -f ../arcOS-Field-Manual.html ]; then
	rm ../arcOS-Field-Manual.html
fi

if [ -f ../README.md ]; then
	rm ../README.md
fi

cat <<EOF > ../arcOS-Field-Manual.html
<head>
<style>
body {
	font-family: monospace;
	font-size: 1.5em;
}
h1,h2 {
	padding: 5px 10px;
	background-color: #000000;
	color: #ffffff;
}

h3 {
	padding: 5px 10px;
	background-color: #505050;
	color: #ffffff;
}

blockquote {
	padding: 5px 10px;
	background-color: #e0e0e0;
}

@media print {
	body {
		font-size: 1em !important;
	}
}
</style>
</head>

EOF


for md in ../markdown/*.md; do
	cat $md >> ../README.md
	markdown --html4tags $md >> ../arcOS-Field-Manual.html
done

sed -i "s/YYYY-MM-DD/$(date +'%FT%H%M%Z')/" ../arcOS-Field-Manual.html
sed -i "s/YYYY-MM-DD/$(date +'%FT%H%M%Z')/" ../README.md
