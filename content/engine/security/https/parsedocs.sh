#!/bin/sh

echo "#!/bin/sh"
cat ../protect-access.md | awk '{if (sub(/\\$/,"")) printf "%s", $0; else print $0}' \
        | grep '   $ ' \
        | sed 's/    $ //g' \
        | sed 's/2375/7777/g' \
        | sed 's/2376/7778/g' \
        | sed 's/^iechor/# iechor/g' \
        | sed 's/^curl/# curl/g'
