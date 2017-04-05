command -v hxselect >/dev/null 2>&1 || { echo >&2 "You need to have installed html-xml-utils to run this script. 
Please visit https://www.w3.org/Tools/HTML-XML-utils/  Aborting."; exit 1; }

download_link=$(wget -qO- https://downloads.joomla.org | hxselect '#latest' | hxwls)
downloaded_file="${download_link##*/}"

if [ ! -f "$downloaded_file" ]; then
	wget "https://downloads.joomla.org"$download_link
fi

	echo "Enter Name of folder where you want to extract Joomla zip file:"
	read joomla_folder

	if [ -d "$joomla_folder" ]; then

		if [ "$(ls -A $joomla_folder)" ]; then
			echo "Folder exist and it's not empty!"
			echo "You are at $(pwd)"
			echo "Overwrite (O) Abort (A)"
			read next_step

			if [ $next_step = 'A' ]; then
				exit 1;

			elif [ $next_step = "O" ]
			then
				mv $downloaded_file $joomla_folder
				cd $joomla_folder
				unzip $downloaded_file
			else
				echo "Wrong command. Aborting"
			fi
		else
			mv $downloaded_file $joomla_folder
			cd $joomla_folder
			unzip $downloaded_file
		fi

		else
			mkdir -p $joomla_folder
			cd $joomla_folder
			unzip $downloaded_file
	fi

