command -v hxselect >/dev/null 2>&1 || { echo >&2 "You need to have installed html-xml-utils to run this script.
Please visit https://www.w3.org/Tools/HTML-XML-utils/  Aborting."; exit 1; }

download_link=$(wget -qO- https://downloads.joomla.org | hxselect '#latest' | hxwls)
downloaded_file="${download_link##*/}"
echo "---------------------------------------------------------------"
echo "Enter Name of folder where you want to extract Joomla zip file:"
echo "(relative to current folder $(pwd))"
echo "---------------------------------------------------------------"
read joomla_folder

if [ -d "$joomla_folder" ]
then

	if [ "$(ls -A $joomla_folder)" ]
	then
		echo "Folder exist and it's not empty!"
		echo "You are at $(pwd)"
		echo "-----------------------------------------------------"
		echo "Still continue(y) No. Stop Script(N) (Default is No):"
		echo "-----------------------------------------------------"
		read next_step

		if [ -z "$next_step" ]; then
		next_step='N'
		fi

		if [ ${next_step} = "N" ]
		then
			echo 'Aborting'; exit 1
		elif [ ${next_step} = "y" ]
		then
			cd ${joomla_folder}

			if [ ! -f "$downloaded_file" ]; then
				wget "https://downloads.joomla.org"$download_link
			fi
			unzip ${downloaded_file}
		fi
	else
		cd $joomla_folder
		if [ ! -f "$downloaded_file" ]; then
			wget "https://downloads.joomla.org"$download_link
		fi
		unzip ${downloaded_file}
	fi

else
	mkdir -p $joomla_folder
	cd $joomla_folder
	if [ ! -f "$downloaded_file" ]
	then
		wget "https://downloads.joomla.org"$download_link
	fi
	unzip ${downloaded_file}
fi
