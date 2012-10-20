SotongDJ mplayer control script set for Kindle Touch Launcher
========================
sdmplayer-kt still UNDER CONSTRUCTION
========================

### 注：在做任何浏览/编辑前，请阅读许可声明[License]
### Note: Read [License] before you make any action

Introduction
-------------------------------------

SotongDJ mplayer control script set for Kindle Touch Launcher (sdmplayer-kt) is a set of script that use to extend the music playback function of Kindle Touch. sdmplayer-kt use GPL 3.0 License.
In this README, I will show you the Installation, the History, the structure, the To Do List (Future dev functions list), the Branch list and the License of sdmplayer-kt.

Installation [Under Construction]
-------------------------------------

Requirement:
* Kindle Touch Jailbreak
* Kindle Touch GUI Launcher
* Python for Kindle

Where smplayer-kt come from? (Brief History)
-------------------------------------

The source code of sdmplayer-kt was come from three part:
* [Mplayer For Kindle 0.2.0] (http://www.mobileread.com/forums/showthread.php?t=119851)
* [SotongDJ's Mplayer Playback Script Set] (https://github.com/SotongDJ/launchpad-kindle)
* [K5 MPlayer for Kindle 4 Touch] (http://www.mobileread.com/forums/showthread.php?t=170213)
* [Leafpad for Kindle Touch](http://www.fabiszewski.net/kindle-notepad/)

After I get my kindle Keyboard, I found that the music playback function is too incomplete.
Although I install Mplayer For Kindle 0.2.0, I still can not select what I want to listen.
This is why I use my own python scripts + Mplayer (and control.sh from Mplayer For Kindle 0.2.0) + Notepad (7 Dragon) to create "SotongDJ's Mplayer Playback Script Set".
In my opinion, "SotongDJ's Mplayer Playback Script Set" is the first music player which can select the music and generate playlist immediately.

When my sister lend me her Kindle Touch, I try to use the music playback func. 
I was disappointed once again.
When I look back to my launchpad-kindle repo, it was messy as I mix a lot of thing inside.
This is why I create a new repo, for new device, for new method (Launcher).

Structure
-------------------------------------
sdmplayer-kt have three part: Linux Shell Script Language(sh), Python Script Language(Python) and Binary part. 
### shell.sh (sh part)
shell.sh is base on:
* control.sh, "Mplayer For Kindle 0.2.0"
* menu.json, "K5 MPlayer for Kindle 4 Touch"
* leafpad.sh, "Leafpad for Kindle Touch"
shell.sh is use for control mplayer. 

### python part
gensl.py and genpl.py is base on the same file in "SotongDJ's Mplayer Playback Script Set".
The function of python script is:
* gensl.py generate the lists for user to select.
* genpl.py generate playlist from files created by gensl.py.

### Binary part
Contain:
* mplayer, "Mplayer For Kindle 0.2.0"
* leafpad, "Leafpad for Kindle Touch"

To Do List [Under Construction]
-------------------------------------
* Nothing to say until I finish porting

Branch [Under Construction]
-------------------------------------
* Nothing to say until I finish porting

License
-------------------------------------
    This file is part of sdmplayer-kt.

    sdmplayer-kt is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    sdmplayer-kt is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with sdmplayer-kt.  If not, see <http://www.gnu.org/licenses/>.

History (dd-mm-yyyy)
-------------------------------------
17-10-2012
* Copying code from launchpad-kindle repo
* Tweak python and shell scripts to fit Kindle Touch Launcher Environment
* Change workflow to fit Kindle Touch Launcher Environment

18-10-2012
* modify README.md
* still need test <s>but I am fixing SSH over WIFI</s>

20-10-2012
* Complete scripts
* still need test 
