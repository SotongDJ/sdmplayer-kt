#!/mnt/us/python/bin/python2.6
#coding=UTF8
## This py script was made to make sure the whole script set are using unique variable
import sys
import os
## =======================================================================
## -----------Change it if different---------
global configfile,sdmdir
configfile='/mnt/us/extensions/sdmplayer/settings/sdmplayer.conf'
sdmdir='/mnt/us/extensions/sdmplayer'
## =======================================================================
## ---------------Argument---------------------------------
def argv(value,type):
    b=''
    for a in sys.argv:
        if type == 'boolean':
            if a == '--'+value:
                return 'true'
        if type == 'dtm':
            if value in a:
                return 'true'
        if type == 'acrdtm':
            if a == value:
                return 'true'
        if type == 'selection':
            if '--'+value+'=' in a:
                b=a.replace('--'+value+'=','')
                return b
## -----------value---------
#### -----------check value---------
def chkvlue(file):
    status=os.system('touch '+file)
    if open(file).read().splitlines() == []:
        return 'false'
    elif open(file).read().splitlines() != []:
        return 'true'
#### -----------read value---------
def rdvalue(file):
    lib={}
    for line in open(file).read().splitlines():
        if open(file).read().splitlines() != []:
            if len(line.split("=")) == 2:
                lib.update({line.split("=")[0]:line.split("=")[1]})
    return lib
#### -----------edit value---------
def edvalue(key,value,lib,path):
    lib.update({key:value})
    file=open(path,'w')
    for yek in lib:
        file.write(yek+'='+lib.get(yek)+'\n')
    file.close()
## -----------Determine---------
def viewvalue(key,defaultvalue,confpath):
    ## old name:determine()
    if chkvlue(confpath) == 'true':
        if rdvalue(confpath).get(key):
            return rdvalue(confpath).get(key)
        else:
            edvalue(key,defaultvalue,rdvalue(confpath),confpath)
            return defaultvalue
    elif chkvlue(confpath) == 'false':
        edvalue(key,defaultvalue,rdvalue(confpath),confpath)
        return defaultvalue
## =======================================================================
temp="/tmp/filelisttemp"
playlist="/tmp/mplayer.playlist"
def mpenv(): 
    select=viewvalue('lang','english',configfile)
    notepaddir=sdmdir+"/lists"
    nonselectstate="-!"
    nss='\n'+nonselectstate
    splitnum=10
    return {'notepaddir':notepaddir,'nonselectstate':nonselectstate,'nss':nss,'splitnum':splitnum}
## ---------------words-------------------------------
def words(thing):
    nonselectstate="-!"
    select=viewvalue('lang','english',configfile)
    if select == 'chinese':
        word01="## 你可以用Leafpad打开其他文本文件\n## 选择你要播放的歌曲\n##\n## 去掉选项前的“no”即可开启之，反之亦然。\n## 【no全部播放】 【no随机播放】\n##（注：重复模式默认开启，目前仍不能选择关闭。）"
        selword01="\n##\n## m3u 控制选项：\n## 【nom3u】\n## （需不需要支持m3u播放列表播放。）\n## 注：\n##   当您同时选择开启m3u和随机播放时，\n##	  m3u列表里的所有歌曲会和其他歌曲一起乱序播放。\n"##\n## 【不要pl2m3u:NAME】\n## （需不需要把您要播放的媒体编成m3u播放列表,\n##  以NAME.m3u为名，如未更改NAME，将自动以时间日期命名）\n"
        word02="## 移除“"+nonselectstate+"”以选择您要播放的媒体（如歌曲及录音）。\n"
        word03="## 移除“"+nonselectstate+"”以选择您要播放的播放列表。\n"
    elif select == 'english':
        word01="## You can start select the song\n## by open other playlist(text file) using Leafpad\n##\n## Select the mode below by remove \'no\', vice versa\n## (repeat mode is enabled by default)\n## :noplayall: :noshuffle:"
        selword01="\n##\n## m3u Control Section:\n## :nom3u: (m3u Playlist support)\n## (If you enable Shuffle and m3u at same time,\n##	 the songs in m3u will be arrange ramdomly)\n##\n"## :!pl2m3u:NAME: \n## (turn your choice(s) into a m3u playlist\n##  which name is \"NAME.m3u\", if \"NAME\" remain,\n## the name will be \"yymmddhhmm.m3u\")"
        word02="##Select the"+thing+"(s) you want to play by remove \'"+nonselectstate+"\'\n"
        word03="##Select the m3u playlist(s) you want to play by remove \'"+nonselectstate+"\'\n"
    return {'word01':word01,'selword01':selword01,'word02':word02,'word03':word03}
## ---------------source folder-------------------------------
musicdir="/mnt/us/music"
## ---------------list file head-------------------------------
forpledit=mpenv().get('notepaddir')+"/01-Playlist"
## ---------------Order---------------------------------
def oder():
    select=viewvalue('lang','english',configfile)
    if select == 'chinese':
        ordplayall="【全部播放】"
        ordshuffle="【随机播放】"
        ordm3u="【m3u】"
        ordpl2m3u="【pl2m3u】"
    elif select == 'english':
        ordplayall=':playall:'
        ordshuffle=':shuffle:'
        ordm3u=':m3u:'
        ordpl2m3u=':pl2m3u:'
    return {'ordplayall':ordplayall,'ordshuffle':ordshuffle,'ordm3u':ordm3u,'ordpl2m3u':ordpl2m3u}
## =======================================================================
if argv('config.py','dtm') == 'true':
    if argv('key','selection') == 'test':
        print mpenv()
        print words('~wahahaha~')
        print source()
        print head()
        print oder()
    if argv('key','selection') == 'dtmtest':
        print viewvalue('lang','english',configfile)
    elif '--help' in sys.argv:
        print "Sorry, this section neeed to be Rewrite."
        print "=================================="
        print "config.py: Strings Configuration"
        print "Usage: python config.py { --key=[KEY] --value=[VALUE]|--help }"
        print "\nKEY:\n        `test` for Debug Usage\n         `change` for Change Language and Editor which MyMplayer rely"
        print "\nVALUE:\n        `notepad` for Notepad (7 Dragons)\n         `kindlenote` for KindleNote (proDOOMman)\n         `chinese` for KindleNote (proDOOMman) and the Kindle has PinYin IME rely"
