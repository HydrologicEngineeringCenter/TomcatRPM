VERSION = 9.0.41
SHA512 = "b6450e590a37c5bccf049b1176c441f0964796995e80d4c7c7d9fb74f9ad817107c303b6b83ed3d71c9251b2b8acf334b90a4abdf9deea122e338643cece0766 *apache-tomcat-9.0.41.tar.gz"

.DEFAULT_GOAL := rpm


download:   
	if [ ! -f ./apache-tomcat-${VERSION}.tar.gz ]; then wget https://downloads.apache.org/tomcat/tomcat-9/v${VERSION}/bin/apache-tomcat-${VERSION}.tar.gz; fi
	echo "${SHA512}" > checksum.txt
	sha512sum -c checksum.txt
	
rpm: download
	docker build --tag rpmbuild .
	docker run -v `pwd`:/root/rpmbuild/RPMS/noarch rpmbuild 

test:
	docker run -it -v `pwd`:/rpms nimmis/java-centos:openjdk-8-jdk
