VERSION = 9.0.89
SHA512 = "c2e8e45a98cd30764b507bb997c7cf1b8e337be9c6d1833bb5f916a5d86d96cb095f430884d0a248cdc3b510beb11e227cc160f8402ba5b2e3952399a44461d1 *apache-tomcat-9.0.89-src.tar.gz"

.DEFAULT_GOAL := rpm


download:   
	if [ ! -f ./apache-tomcat-${VERSION}.tar.gz ]; then wget https://downloads.apache.org/tomcat/tomcat-9/v${VERSION}/bin/apache-tomcat-${VERSION}.tar.gz; fi
	echo "${SHA512}" > checksum.txt
	sha512sum -c checksum.txt
	
rpm: download
	docker build --tag rpmbuild .
	docker run -v `pwd`:/root/rpmbuild/RPMS/noarch rpmbuild

solaris: download
	./build_solaris_pkg.sh "apache-tomcat-${VERSION}.tar.gz"



	

clean_solaris:
	rm -rf solaris_pkg

test:
	docker run -it -v `pwd`:/rpms nimmis/java-centos:openjdk-8-jdk
