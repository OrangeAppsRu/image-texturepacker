#!/usr/bin/env sh
set -e

echo agree | TexturePacker --version

if [ $# -ge 1 ]
then
    exec /usr/bin/java -jar /usr/local/bin/swarm-client.jar $@
else
    exec /usr/bin/java -jar /usr/local/bin/swarm-client.jar -name ${NAME} -master ${JENKINS_URL} -executors ${EXECUTORS} -password ${TOKEN} -username ${USERNAME} -mode ${MODE} -labels ${LABELS} -fsroot ${FSROOT}
fi
