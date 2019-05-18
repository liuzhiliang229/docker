FROM ubuntu
RUN apt-upadte && apt -y install httpd
CMD ["httpd","-DFOREGROUND"]
