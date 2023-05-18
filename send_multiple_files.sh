
# receive multiple images at once
# receiver side
while true; do ((i++)); netcat -l 4000 > image${i}.jpg; done
# sender
ls -1 *jpg | xargs -n 1 -d "\n" | netcat localhost 4000
