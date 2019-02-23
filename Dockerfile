FROM centos
RUN yum -y install httpd
CMD ["httpd","-DFOREGROUND"]
