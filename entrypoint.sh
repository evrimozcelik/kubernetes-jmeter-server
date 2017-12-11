#!/bin/bash
# Inspired from https://github.com/justb4/docker-jmeter
#
# This script expects the standdard JMeter command parameters.
#

set -e
freeMem=`awk '/MemFree/ { print int($2/1024) }' /proc/meminfo`
s=$(($freeMem/10*8))
x=$(($freeMem/10*8))
n=$(($freeMem/10*2))
export JVM_ARGS="-Xmn${n}m -Xms${s}m -Xmx${x}m"

echo "START Running Jmeter on `date`"
echo "JVM_ARGS=${JVM_ARGS}"
echo "jmeter args=$@"
echo "SERVER_PORT=${SERVER_PORT}"

# Keep entrypoint simple: we must pass the standard JMeter arguments
jmeter-server $@

echo "END Running Jmeter Server on `date`"
