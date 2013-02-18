#!/bin/bash

# Checks to see if you're SSH'ing to a production server, and changes your terminal background to red.
# Requires you be running Roxterm http://roxterm.sourceforge.net
# Create a local alias for SSH to this script eg: alias ssh='/home/arboeglin/scripts/checkprod.sh'

# Location of text file containing hostnames for prod servers
prodservers=/home/arboeglin/scripts/prodservers.txt

# trap ctrl-c and call ctrl_c()
trap ctrl_c INT

function ctrl_c() {
	/usr/bin/dbus-send --session /net/sf/roxterm/Options net.sf.roxterm.Options.SetColourScheme string:$ROXTERM_ID string:GTK
}

for i in $*
do
        sshopts="$sshopts $i"

	if echo $i | grep -q "@"
	then
		i=$(echo "$i" | cut -d "@" -f2)
	fi

	if egrep -q "^$i" $prodservers	
	then
		/usr/bin/dbus-send --session /net/sf/roxterm/Options net.sf.roxterm.Options.SetColourScheme string:$ROXTERM_ID string:Prod
	fi

done 

/usr/bin/ssh $sshopts

/usr/bin/dbus-send --session /net/sf/roxterm/Options net.sf.roxterm.Options.SetColourScheme string:$ROXTERM_ID string:GTK
