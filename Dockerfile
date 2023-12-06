# 도커 이미지를 생성할 기본 운영체제 이미지
FROM ubuntu:20.04

# 도커 이미지에 패키지를 업데이트하고 파이썬 설치
RUN apt-get update && apt-get install -y python3 python3-pip curl

# 도커 이미지를 실행할 폴더
WORKDIR /app

# 도커 이미지에 필요한 파일을 복사
COPY * /app/

# 파이썬 패키지 설치
RUN pip3 install -r requirements.txt

# 컨테이너가 정상적으로 실행되고 있는지 확인하는 명령어
HEALTHCHECK --interval=5s --timeout=3s \
  CMD curl -f http://localhost:8000/

# 도커 이미지를 실행할 명령어
CMD ["uvicorn", "main:app", "--host", "0.0.0.0" ]
