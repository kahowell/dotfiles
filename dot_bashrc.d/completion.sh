COMMANDS="
crc
"
for command in $COMMANDS; do
  if [ -n "$(command -v $command)" ]; then
    source <($command completion bash)
  fi
done
COMMANDS="
quarkus
"
for command in $COMMANDS; do
  if [ -n "$(command -v $command)" ]; then
    source <($command completion)
  fi
done
