# bash
docker login

docker build -t note:test

docker tag node:test thaidl/node:test

docker push thaidl/node:test

# test
docker run -it thaidl/node:test