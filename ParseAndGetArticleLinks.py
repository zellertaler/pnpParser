from bs4 import BeautifulSoup

import sys
#-- getting html (if with file io or via request)
#- this will be replaced with python request https://plus.pnp.de/lokales/viechtach
with open(sys.argv[1]) as fp:
    soup = BeautifulSoup(fp, 'html.parser')
# hints: https://gist.github.com/bradmontgomery/1872970

#--- get meta-data, e.g. "Viechtach am 06.03.2018"
t_section_header = soup.find("h1","section-title")
s_section_header = t_section_header.get_text()

#-- get relevant articles on this day
t_section = soup.find("section", id="main")

#- get all articles' links
l_as = t_section.find_all('a')

l_artcls_hrefs = []    
for a in l_as: 
    l_class_ident = a.get('class')
    if l_class_ident: 
        s_class_ident = l_class_ident[0]
        if  s_class_ident == 'relative': 
            l_artcls_hrefs.append(a.get('href'))
                        
print(l_artcls_hrefs)
