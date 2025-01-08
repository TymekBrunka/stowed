#for code select
c.hints.selectors["code"] = [
    # Selects all code tags whose direct parent is not a pre tag
    ":not(pre) > code",
    "pre"
]

#userscripts
config.bind(',od', 'spawn --userscript open-download')
config.bind(',lh', 'spawn --userscript localhost')
# config.bind(',sa', 'spawn --userscript qbfsync')
# config.bind(',sd', 'spawn --userscript qbfsync-del')
config.bind(',cc', 'spawn --userscript cookie-cleaner.sh')
config.bind(',cw', 'spawn --userscript cookie-wl.sh')
config.bind(',cr', 'spawn --userscript rm-cookie.sh')
config.bind(',uas', 'spawn --userscript user-agent-switch.sh')
config.bind('<ctrl-`>', 'hint code userscript code-select.py')
