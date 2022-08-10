FROM node:16.14.2

RUN apt update && apt install git curl

RUN touch email.txt && echo "thai@rikkeisoft.com" > email.txt 

CMD cat email.txt
