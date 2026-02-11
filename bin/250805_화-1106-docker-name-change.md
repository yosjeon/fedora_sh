
🔥 ## 🔥 ubuntu 에서 docker 를 설치하고 여기에서 wiki.js 를 실행하고 있어.
그리고 매주 주말에는 데이터를 백업받고 있지. 그런데, 여기에서 지정한 이름들을 바꿔서 사용하려고 해. 먼저, docker-compose.yml 을 보여줄께.
```
version: "3"
services:

db:
  image: postgres:11-alpine
  environment:
    POSTGRES_DB: wiki
    POSTGRES_PASSWORD: wikijsrocks
    POSTGRES_USER: wikijs
  logging:
    driver: "none"
  restart: unless-stopped
  volumes:
    - /home/docker/pgsql:/var/lib/postgresql/data
  container_name:
    wikijsdb

wiki:
  image: requarks/wiki:2
  depends_on:
    - db
  environment:
    DB_TYPE: postgres
    DB_HOST: db
    DB_PORT: 5432
    DB_USER: wikijs
    DB_PASS: wikijsrocks
    DB_NAME: wiki
  restart: unless-stopped
  ports:
    - "5840:3000"
  container_name:
    wikijs
```
이렇게 사용하고 있는데, DB 는 postgresql 그대로 쓸거고, (1) 데이터베이스 이름 wiki -> wikidb 로 변경, (2) DB 비번 wikijsrocks -> wikipswd 로 변경, (3) DB 유저 wikijs -> wikiuser, (4) DB 컨테이너 이름 wikijsdb -> dbcon, (5) 위키 컨테이너 이름 wikijs -> wikicon 으로 바꾸려고 해. 이렣게 바꾸는 작업을 백업이 끝나고 나서 바로 하려고 하는데, 어떻게 하는지 bash 에서 실행하는 스크립트를 알려줘.

### 🔋 네, wiki.js 컨테이너의 데이터베이스 설정과 컨테이너 이름을 변경하는 스크립트를
안내해 드릴게요. 변경 작업을 백업 후에 진행한다고 하셨으니, 기존 컨테이너를 중지하고 삭제한 뒤, 새로운 설정으로 컨테이너를 다시 생성하는 방식으로 진행하면 됩니다.

아래는 변경 사항을 적용하기 위한 bash 스크립트입니다.

### 설정 변경 스크립트
먼저, 변경된 내용으로 새로운 docker-compose.yml 파일을 작성해야 합니다. 기존 파일 내용을 아래와 같이 수정하세요.

#### 새로운 docker-compose.yml 파일 내용
```YAML
version: "3"
services:

  db:
    image: postgres:11-alpine
    environment:
      POSTGRES_DB: wikidb
      POSTGRES_PASSWORD: wikipswd
      POSTGRES_USER: wikiuser
    logging:
      driver: "none"
    restart: unless-stopped
    volumes:
      - /home/docker/pgsql:/var/lib/postgresql/data
    container_name:
      dbcon

  wiki:
    image: requarks/wiki:2
    depends_on:
      - db
    environment:
      DB_TYPE: postgres
      DB_HOST: db
      DB_PORT: 5432
      DB_USER: wikiuser
      DB_PASS: wikipswd
      DB_NAME: wikidb
    restart: unless-stopped
    ports:
      - "5840:3000"
    container_name:
      wikicon
```
#### 스크립트 실행 방법
백업이 완료되었다는 가정하에, 아래 스크립트를 터미널에서 실행하시면 됩니다. 이 스크립트는 기존 컨테이너를 정지 및 삭제하고, 위에서 수정한 새로운 docker-compose.yml 파일을 사용하여 컨테이너를 다시 시작합니다.

⚠️ 주의: 아래 스크립트는 기존 컨테이너를 삭제하므로, 반드시 데이터 백업을 먼저 완료한 후에 실행해야 합니다. docker-compose.yml 파일이 스크립트가 실행되는 디렉토리에 있어야 합니다.
``` Bash
#!/bin/bash

# 기존 Wiki.js 및 DB 컨테이너 정지 및 삭제
echo "기존 Wiki.js 및 DB 컨테이너를 정지하고 삭제합니다..."
docker-compose down

# 변경된 설정으로 컨테이너 재시작
echo "변경된 설정으로 컨테이너를 재시작합니다..."
docker-compose up -d

echo "컨테이너가 성공적으로 재시작되었습니다."
echo "새로운 컨테이너 이름: dbcon, wikicon"
echo "새로운 DB 정보: 사용자 - wikiuser, 비밀번호 - wikipswd, 데이터베이스 - wikidb"
```

위 스크립트를 update_wiki.sh와 같은 파일로 저장한 후, ./update_wiki.sh 명령어로 실행하면 됩니다.
혹시 실행 권한이 없다면, chmod +x update_wiki.sh 명령어로 권한을 부여한 후 실행하세요.

### 변경 사항 확인
스크립트 실행 후, docker ps 명령어를 통해 새로운 컨테이너 이름(dbcon, wikicon)으로 컨테이너가 정상적으로 실행되고 있는지 확인하세요.
```Bash
docker ps
```
또한, Wiki.js 웹 인터페이스에 접속하여 사이트가 정상적으로 작동하는지 확인하는 것이 중요합니다. 접속이 되지 않는다면, 로그를 확인하여 문제를 해결해야 합니다.
```Bash
docker logs wikicon
```


🔥 ### 🔥 docker-compose 를 쓸때 앞에 sudo 를 붙이지 않아도 되나?
나는 습관처럼 sudo 를 붙여왔는데말야.

### 🔋 네, docker-compose를 실행할 때 sudo를 붙이지 않아도 됩니다.

sudo 없이 Docker 명령어를 실행하려면, 현재 사용자 계정을 docker 그룹에 추가하면 됩니다. 이 작업을 완료하면 더 이상 sudo를 붙이지 않아도 되어 편리합니다.

아래는 현재 사용자를 docker 그룹에 추가하는 방법과 적용하는 절차입니다.

### 1. 현재 사용자를 docker 그룹에 추가
터미널에서 아래 명령어를 실행하세요.
```Bash
sudo usermod -aG docker $USER
```
이 명령어는 현재 로그인한 사용자($USER)를 docker 그룹에 추가합니다. -aG 옵션은 사용자를 그룹에 추가(append)하고, 그룹 멤버십을 유지(group)하겠다는 의미입니다.

### 2. 변경 사항 적용
명령어를 실행한 후에는 로그아웃했다가 다시 로그인하거나, 아래 명령어를 실행하여 그룹 변경 사항을 즉시 적용해야 합니다.
```Bash
newgrp docker
```
newgrp docker 명령어는 현재 쉘의 그룹 멤버십을 docker 그룹으로 변경합니다.

### 3. 확인
위 절차를 완료한 후에는 sudo 없이 docker run hello-world와 같은 간단한 명령어를 실행하여 정상적으로 작동하는지 확인해 보세요.
```Bash
docker run hello-world
```
만약 정상적으로 실행된다면, docker-compose 명령어 역시 sudo 없이 사용할 수 있습니다.

