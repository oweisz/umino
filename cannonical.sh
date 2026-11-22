#/bin/bash

shopt -s globstar nullglob

for f in **/*.html; do
  # Vynechá ověřovací soubor Google Search Console a případnou 404
  [[ "$f" == "google5343079f12428526.html" || "$f" == "404.html" ]] && continue

  if [[ "$f" == "index.html" ]]; then
    url="https://uminogurio.netlify.app/"
  elif [[ "$f" == */index.html ]]; then
    url="https://netlify.app{f%index.html}"
  else
    url="https://netlify.app{f}"
  fi

  # Vloží canonical tag před </head> (pokud tam ještě není)
  grep -qi 'rel="canonical"' "$f" || sed -i "s|</head>|  <link rel=\"canonical\" href=\"${url}\" />\n</head>|I" "$f"
done

