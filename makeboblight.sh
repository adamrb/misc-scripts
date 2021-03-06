#!/bin/bash

# Script to generate configuration for Boblight ambient lighting setup.
# TODO: Document this more

# How far into the screen should it look
depth=13

devicename=ambilight

echo -n "How many lights on the Left side? "
read left

echo -n "How many lights on the Top? "
read top

echo -n "How many lights on the Right side? "
read right

echo -n "How many lights on the Bottom? "
read bottom

total=$(expr $left + $top + $right + $bottom)

echo "Total light: $total"

echo
echo "------- Light section starts here ------"

current=1
colorcount=1


if [ $bottom -ne 0 ]; then
	bcount=1
	brange=$(echo "scale=2; 100 / $bottom" | bc)
	bcurrent=50

	while [ $bcount -le $(expr $bottom / 2 2>/dev/null) ]; do
		btop=$(echo "scale=2; $bcurrent - $brange" | bc)

		echo
		echo "[light]"
		echo "name            bottom$bcount"

		echo "color           red     $devicename $colorcount"
		((colorcount++))

		echo "color           green   $devicename $colorcount"
		((colorcount++))

		echo "color           blue    $devicename $colorcount"
		((colorcount++))

		echo "hscan           $btop $bcurrent"
		echo "vscan           $(echo "scale=2; 100 - $depth" | bc) 100"


		bcurrent=$btop

		((bcount++))
		((current++))
	done
fi

if [ $left -ne 0 ]; then
	lcount=1
	lrange=$(echo "scale=2; 100 / $left" | bc)
	lcurrent=100

	while [ $lcount -le $left ]; do
		ltop=$(echo "scale=2; $lcurrent - $lrange" | bc)
		
		echo
		echo "[light]"
		echo "name            left$lcount"
		
		echo "color           red     $devicename $colorcount"
		((colorcount++))

		echo "color           green   $devicename $colorcount" 
		((colorcount++))

		echo "color           blue    $devicename $colorcount"
		((colorcount++))

		echo "hscan           0 $depth"
		echo "vscan           $ltop $lcurrent"

		lcurrent=$ltop

		((lcount++))
		((current++))
	done
fi


if [ $top -ne 0 ]; then
	tcount=1
	trange=$(echo "scale=2; 100 / $top" | bc)
	tcurrent=0

	while [ $tcount -le $top ]; do
		ttop=$(echo "scale=2; $tcurrent + $trange" | bc)

		echo
		echo "[light]"
		echo "name            top$tcount"

		echo "color           red     $devicename $colorcount"
		((colorcount++))

		echo "color           green   $devicename $colorcount"
		((colorcount++))

		echo "color           blue    $devicename $colorcount"
		((colorcount++))

		echo "hscan           $tcurrent $ttop"
		echo "vscan           0 $depth"


		tcurrent=$ttop

		((tcount++))
		((current++))
	done
fi

if [ $right -ne 0 ]; then
	rcount=1
	rrange=$(echo "scale=2; 100 / $right" | bc)
	rcurrent=0

	while [ $rcount -le $right ]; do
		rtop=$(echo "scale=2; $rcurrent + $rrange" | bc)

		echo
		echo "[light]"
		echo "name            right$rcount"

		echo "color           red     $devicename $colorcount"
		((colorcount++))

		echo "color           green   $devicename $colorcount"
		((colorcount++))

		echo "color           blue    $devicename $colorcount"
		((colorcount++))

		echo "hscan           $(echo "scale=2; 100 - $depth" | bc) 100"
		echo "vscan           $rcurrent $rtop"

		rcurrent=$rtop

		((rcount++))
		((current++))
	done
fi


if [ $bottom -ne 0 ]; then
	bcurrent=100

	while [ $bcount -le $bottom ]; do
		btop=$(echo "scale=2; $bcurrent - $brange" | bc)

		echo
		echo "[light]"
		echo "name            bottom$bcount"

		echo "color           red     $devicename $colorcount"
		((colorcount++))

		echo "color           green   $devicename $colorcount"
		((colorcount++))

		echo "color           blue    $devicename $colorcount"
		((colorcount++))

		echo "hscan           $btop $bcurrent"
		echo "vscan           $(echo "scale=2; 100 - $depth" | bc) 100"


		bcurrent=$btop

		((bcount++))
		((current++))
	done
fi

echo
echo "------- Light section ends here ------"
