#!/usr/bin/python
# -*- coding: utf-8 -*-
import xml.dom.minidom
import urllib
import random

x = urllib.urlopen("http://news.in.gr/feed/news/")
f = x.read()

doc = xml.dom.minidom.parseString(f)
titles = doc.getElementsByTagName("title")
links = doc.getElementsByTagName("link")

titles.pop(0)
links.pop(0)

r = random.randrange(0, len(titles))
t = titles[r].firstChild.nodeValue.encode('utf-8')
l = links[r].firstChild.nodeValue.encode('utf-8')

short = urllib.urlopen("http://www.tinyurl.com/api-create.php?url=%s" % (l)).read()
print("%s:\n%s" % (t, short))

#for (t, l) in zip(titles, links):
#    print("%s\n%s" % (t.firstChild.nodeValue, l.firstChild.nodeValue))

