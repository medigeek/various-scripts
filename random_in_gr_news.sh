#!/bin/bash
#Requires wget
x=`wget -q -O- "http://news.in.gr/feed/news/" | grep -Po '<(?:title|link)>(.*)</(?:title|link)>' | sed -e 's#<[^>]*>##g' -e '/Ειδήσεις/d' -e '/Netvolution.Site.Engine/d'`
lines=`echo "$x"|wc -l`
remainder=`echo "$lines / 2"|bc`
randline=`echo "$RANDOM % $remainder"|bc`
#randnum=$(($randline + 1))
echo "Lines $lines -- Rem $remainder -- randline $randline"
news=`echo "$x"|head -n $randline|tail -n 2`
echo "$news"

