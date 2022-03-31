#!/bin/bash

########################
# include the magic
########################
dir="${0%/*}"
. $dir/demo-magic.sh


########################
# Configure the options
########################

#
# speed at which to simulate typing. bigger num = faster
#
TYPE_SPEED=100

#
# custom prompt
#
# see http://www.tldp.org/HOWTO/Bash-Prompt-HOWTO/bash-prompt-escape-sequences.html for escape sequences
#
DEMO_PROMPT="${GREEN}➜ ${CYAN}\W "

# hide the evidence
cd $dir
clear


pe "component-cli ca remote get \
	ghcr.io/vasu1124/ocm \
	github.com/vasu1124/app-introspect 1.0.0"

p "component-cli ca signature sign rsa \
	ghcr.io/vasu1124/ocm \
	github.com/vasu1124/app-introspect 1.0.0 \
	--upload-base-url ghcr.io/vasu1124/ocmsigned \
	--recursive --signature-name vasu1124 --private-key my.key"
echo "signed (simulated)"

p "component-cli ca remote copy \
	github.com/vasu1124/app-introspect 1.0.0 \
	--from=ghcr.io/vasu1124/ocmsigned \
	--to=private.cloud/vasu1124/ocmsigned \
	--copy-by-value –recursive"
echo "transported (simulated)"


p "component-cli ca remote get \
	private.cloud/vasu1124/ocmsigned \
	github.com/vasu1124/app-introspect 1.0.0"
component-cli ca remote get \
	ghcr.io/vasu1124/ocmtest \
	github.com/vasu1124/app-introspect 1.0.0
