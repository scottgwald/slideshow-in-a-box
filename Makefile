# Set up your browser slideshow, complete with thumbnail gallery
#
# `make' creates thumbnails and json for gallery
#
# requires helper.bash in the same directory
#

default: js/img.json

js/img.json: 
	echo "Running helper.bash"
	./helper.bash

clean:
	echo "removing js/img.json"
	rm js/img.json

# next try putting it in the js subdirectory
# and see if everything still works
