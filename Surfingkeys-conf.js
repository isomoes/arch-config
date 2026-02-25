// an example to replace `T` with `gt`, click `Default mappings` to see how `T` works.
api.map("gt", "T");

api.map("H", "S"); // backword browser history
api.map("L", "D"); // forward browser history

// use J/K instead of R/E for tab switching
api.map("J", "R");
api.map("K", "E");

// an example to remove mapkey `Ctrl-i`
api.unmap("<ctrl-i>");

// set the block website.
settings.blocklistPattern =
  /((calendar).google|udemy|member.bilibili).com|.*follow.is/i;

// set theme
settings.theme = `
.sk_theme {
    font-family: Input Sans Condensed, Charcoal, sans-serif;
    font-size: 10pt;
    background: #24272e;
    color: #abb2bf;
}
.sk_theme tbody {
    color: #fff;
}
.sk_theme input {
    color: #d0d0d0;
}
.sk_theme .url {
    color: #61afef;
}
.sk_theme .annotation {
    color: #56b6c2;
}
.sk_theme .omnibar_highlight {
    color: #528bff;
}
.sk_theme .omnibar_timestamp {
    color: #e5c07b;
}
.sk_theme .omnibar_visitcount {
    color: #98c379;
}
.sk_theme #sk_omnibarSearchResult ul li:nth-child(odd) {
    background: #303030;
}
.sk_theme #sk_omnibarSearchResult ul li.focused {
    background: #3e4452;
}
#sk_status, #sk_find {
    font-size: 20pt;
}`;
