#!/bin/bash

REPOSITORY=//apps/hanghaePlus/test
PROJECT_NAME=calculator

echo ">>> Build 파일 복사"

cp $REPOSITORY/deploy/*.war $REPOSITORY/

echo ">>> 현재 구동중인 애플리케이션 pid 확인"

CURRENT_PID=$(pgrep -fl calculator | grep java | awk '{print $1}')

echo ">> PID : " $CURRENT_PID

if [ -z "$CURRENT_PID" ]; then
  echo "구동중인 애플리케이션 없음."
else
  echo ">>> kill -15 $CURRENT_PID"
  kill -15 $CURRENT_PID
  sleep 10
fi

echo ">>> 애플리케이션 배포"

WAR_NAME=$(ls -tr $REPOSITORY/*.war | tail -n 1)

echo ">>> WAR NAME : WAR_NAME"

chmod +x $WAR_NAME

echo ">>> $JAR_NAME 실행"

nohup java -jar \
    -Dspring.config.location=classpath:/application.properties \
    $WAR_NAME > $REPOSITORY/nohup.out 2>&1 &