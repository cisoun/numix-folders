#!/bin/bash

# Script for changing Numix base folder style

# Copyright (C) 2014
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License (version 3+) as
# published by the Free Software Foundation. You should have received
# a copy of the GNU General Public License along with this program.
# If not, see <http://www.gnu.org/licenses/>.

version="0.1"

if [ -z $1 ]
then
	: # pass
else
	case $1 in
		-h|--help)
			echo -e "Usage: ./$(basename -- $0) [OPTION]"
			echo -e "Script for changing Numix base folder style."
			echo -e ""
			echo -e "Running as root makes the change globally,"
			echo -e "otherwise it is only made locally. Run as"
			echo -e "appropriate to your Numix installation."
			echo -e ""
			echo -e "Currently supported options:"
			echo -e "  -h, --help \t\t Displays this help menu."
			echo -e "  -v, --version \t Displays program version."
			exit 0 ;;
		-v|--version)
			echo "$(basename -- $0) $version\n"
			exit 0 ;;
		*)
			echo -e "$(basename -- $0): invalid option -- '$1'"
			echo -e "Try '$(basename -- $0) --help' for more information."
	esac
fi

while true; do
	read -p "Which folder style do you want? " answer
	case $answer in
		[1]* ) style="1"; break;;
		# [2]* ) style="2"; break;;
		* ) echo "Please choose a valid style number (1-1)";;
	esac
done

if [[ $UID -ne 0 ]]
then
	if [ -d "/home/${SUDO_USER:-$USER}/.local/share/icons/Numix/" ]
	then
		cp -r "files/${style}/*" "/home/${SUDO_USER:-$USER}/.local/share/icons/Numix"
	elif [ -d "/home/${SUDO_USER:-$USER}/.icons/Numix" ]
	then
		cp -r "files/${style}/*" "/home/${SUDO_USER:-$USER}/.icons/Numix"
	else
		echo -e "You don't appear to have Numix installed locally."
		sleep 3
		exit 0
	fi
else
	if [ -d "/usr/share/icons/Numix/" ]
	then
		cp -rfv ./files/${style}/* /usr/share/icons/Numix/*
	else
		echo -e "You don't appear to have Numix installed globally."
		sleep 3
		exit 0
	fi
fi