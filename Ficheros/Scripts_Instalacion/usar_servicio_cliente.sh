#!/bin/sh 
IP_SERVIDOR="192.168.1.66"
clear
ejecutar=0 # Entramos en el menu
while [ ${ejecutar} -eq 0 ]
do
	echo "Seleccione una opcion:"
	echo "1) Realizar ataque Remote Code Execution"
	echo "2) Realizar ataque XSS"
	echo "3) Realizar ataque DoS"
	echo "4) Realizar ataque personalizado"
	echo "q) Salir"
	echo
	read -p "Opcion seleccionada: " opcion
	case ${opcion} in

	 1)
		clear
		echo "Realizando ataque Remote Code Execution"
		curl http://$IP_SERVIDOR/index.html?exec=/bin/bash
		;;
	 2)
		clear
		echo "Realizando ataque XSS"
		curl http://$IP_SERVIDOR/index.html?'<script>alert</script>'
		;;
	 3)
		clear
		echo "Realizando ataque DoS"
		cd /home/dit/Downloads/Ficheros/Otros
		perl test.pl
		;;
	 4)
		clear
		echo "Realizando ataque de Inyección personalizado"
		curl http://$IP_SERVIDOR/index.html?testparam=test
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