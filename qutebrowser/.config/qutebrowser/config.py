autoconfig = {
    config.load_autoconfig()
} 

config.source('./themes/nord.py')
# c.url.start_pages = ['file:///home/tymek/.config/qutebrowser/homepage/index.html']
# c.content.user_stylesheets = ['./homepage/css/main_min.css']
config.source('./bindings.py')
c.colors.webpage.preferred_color_scheme = 'dark'

#from https://github.com/hicolour/awesome-qutebrowser
c.url.searchengines['a'] = 'https://wiki.archlinux.org/?search={}'
c.url.searchengines['y'] = 'https://www.youtube.com/results?search_query={}'
c.url.searchengines['gh'] = 'https://github.com/search?q={}&type=Code'
