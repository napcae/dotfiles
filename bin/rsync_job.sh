#!/bin/bash
#--bwlimit=250
rsync -avzP --delete --exclude=.DS_Store /Users/napcae/Music/iTunes/iTunes\ Media/Music/. napcae@twix.ctnguyen.net:/media/Music
rsync -avzP --exclude=.DS_Store /Users/napcae/Music/iTunes/iTunes\ Library* /Users/napcae/Music/iTunes/iTunes\ Music\ Library.xml napcae@twix.ctnguyen.net:~/iTunes
