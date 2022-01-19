#!/bin/sh  
clear
ejecutar=0 # Entramos en el menu
while [ ${ejecutar} -eq 0 ]
do
	echo "Seleccione una opcion:"
	echo "1) Reiniciar Apache"
	echo "2) Activar modo bloqueo ModSecurity"
	echo "3) Activar modo filtrado ModSecurity"
	echo "4) Activar Paranoia Level 1"
	echo "5) Activar Paranoia Level 2"
	echo "6) Personalizar regla REQUEST-949-BLOCKING-EVALUATION"
	echo "7) Cargar configuracion por defecto de reglas CRS"
	echo "8) Ver modulos cargados por Apache"
	echo "9) Ver logs ModSecurity"
	echo "10) Ver logs ModEvasive"
	echo "q) Salir"
	echo
	read -p "Opcion seleccionada: " opcion
	case ${opcion} in

	 1)
		clear
		echo "Reiniciando Apache"
		service httpd restart
		;;
	 2)
		clear
		cd /etc/httpd/conf.d
		rm -rf mod_security.conf
		cp /home/dit/Downloads/Ficheros/Ficheros_Configuracion/mod_security_On.conf /etc/httpd/conf.d/mod_security.conf
		;;
	 3)
		clear
		cd /etc/httpd/conf.d
		rm -rf mod_security.conf
		cp /home/dit/Downloads/Ficheros/Ficheros_Configuracion/mod_security_DetectionOnly.conf /etc/httpd/conf.d/mod_security.conf
		;;
	 4)
		clear
		cd /etc/httpd/ModSecurity-2.9.2
		rm -rf crs-setup.conf
		cp /home/dit/Downloads/Ficheros/Ficheros_Configuracion/crs-setup-PL1.conf /etc/httpd/ModSecurity-2.9.2/crs-setup.conf
		;;
	 5)
		clear
		cd /etc/httpd/ModSecurity-2.9.2
		rm -rf crs-setup.conf
		cp /home/dit/Downloads/Ficheros/Ficheros_Configuracion/crs-setup-PL2.conf /etc/httpd/ModSecurity-2.9.2/crs-setup.conf
		;;
	 6)
		clear
		cd /etc/httpd/ModSecurity-2.9.2/rules
		rm -rf REQUEST-949-BLOCKING-EVALUATION.conf
		cp /home/dit/Downloads/Ficheros/Otros/REQUEST-949-BLOCKING-EVALUATION_MODIFICADO.conf /etc/httpd/ModSecurity-2.9.2/rules/REQUEST-949-BLOCKING-EVALUATION.conf
		;;
	 7)
		clear
		cd /etc/httpd/ModSecurity-2.9.2
		rm -rf rules
		cd /etc/httpd/coreruleset-3.4-dev
		cp -r rules /etc/httpd/ModSecurity-2.9.2
		;;
	 8)	
		clear
		httpd -M
		;;
 	 9)
		clear
		cd /etc/httpd/logs
		tail -30 error_log
		;;	 

     10)
		clear
		cd /etc/httpd/logs
		tail -100 error_log | grep 'client denied by server configuration'
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