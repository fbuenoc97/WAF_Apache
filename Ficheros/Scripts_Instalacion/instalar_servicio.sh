#!/bin/sh  
clear
ejecutar=0 # Entramos en el menu
while [ ${ejecutar} -eq 0 ]
do
	echo "Seleccione una opcion:"
	echo "1) Desinstalacion Apache"
	echo "2) Instalacion Apache"
 	echo "3) Instalacion ModSecurity con OWASP-CRS"
	echo "4) Desinstalacion ModSecurity"
	echo "5) Instalacion ModEvasive"
	echo "6) Desinstalacion ModEvasive"
	echo "7) Reiniciar Apache"
	echo "q) Salir"
	echo
	read -p "Opcion seleccionada: " opcion
	case ${opcion} in
		1)
		clear
		echo "Desinstalando Apache"
		yum remove httpd
		cd /usr/local/
		rm -rf modsecurity
		cd /etc/
		rm -rf httpd
		echo "Desinstalacion completada con exito"
		;;
	    2)
		clear
		echo "Instalando Apache"
		yum install httpd
		yum install httpd-devel
		cp /home/dit/Downloads/Ficheros/Otros/index.html /var/www/html
		cd /etc/httpd/conf.d
		rm -rf welcome.conf
		echo "Instalacion completada con exito"
		;;

	    3)
		clear
		cd /etc/httpd
		wget https://github.com/SpiderLabs/ModSecurity/archive/v2.9.2.tar.gz
		tar xvzf v2.9.2.tar.gz
		cd ModSecurity-2.9.2/
		yum install gcc 
		yum install make
		yum install libcurl
		yum install libxml2 
		yum install pcre-devel 
		yum install libxml2-devel 
		yum install curl-devel 
		yum install git
		yum install flex bison yajl yajl-devel curl GeoIP-devel doxygen zlib-devel
		yum install epel-release yum-utils
		yum install libtool
		./autogen.sh
		./configure
		gmake
		gmake install
		cp modsecurity.conf-recommended /etc/httpd/conf.d/mod_security.conf
		cp /etc/httpd/ModSecurity-2.9.2/unicode.mapping /etc/httpd/conf.d
		cd ..
		wget https://github.com/coreruleset/coreruleset/archive/v3.4/dev.zip
		unzip dev.zip 
		cp coreruleset-3.4-dev/crs-setup.conf.example /etc/httpd/ModSecurity-2.9.2/crs-setup.conf
		cp -r coreruleset-3.4-dev/rules /etc/httpd/ModSecurity-2.9.2
		cd conf
		rm -rf httpd.conf
		cp /home/dit/Downloads/Ficheros/Ficheros_Configuracion/httpd_modsec.conf /etc/httpd/conf/httpd.conf
		;;
	    4)
		clear
		echo "Desinstalando ModSecurity"
		cd /etc/httpd/ModSecurity-2.9.2
		gmake uninstall
		cd ..
		rm -rf ModSecurity-2.9.2
		rm -rf coreruleset-3.4-dev
		rm -rf dev.zip 
		rm -rf v2.9.2.tar.gz 
		cd modules
		rm -rf mod_security2.so
		cd ..
		cd conf.d
		rm -rf mod_security.conf
		cd /usr/local/
		rm -rf modsecurity
		cd /etc/httpd/conf
		rm -rf httpd.conf
		cp /home/dit/Downloads/Ficheros/Ficheros_Configuracion/httpd.conf /etc/httpd/conf/httpd.conf
		echo "Desinstalacion completada con exito"
  		;;
	 5)
		clear
		echo "Instalando ModEvasive"
		yum install mod_evasive
		echo "Instalacion completada con exito"
		;;
	 6)
		clear
		echo "Desinstalando ModEvasive"
		yum remove mod_evasive
		echo "Desinstalacion completada con exito"
		;;
	 7)
		clear
		echo "Reiniciando Apache"
		service httpd restart
		;;
	q)
		ejecutar=1
		;;
	*)
		ejecutar=0
		clear
		echo
		echo -e "Opcion no valida"
		echo
		;;
		esac
done
