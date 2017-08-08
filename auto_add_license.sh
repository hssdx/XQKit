function filtCodeFile()
{
	#if ["${filename##*.}" = ""]; then
		#statements
	#fi
	filename="$1"
	#returnValue=0
	#echo ${filename##*.}
	if [ "${filename##*.}" = "h" -o "${filename##*.}" == "m" ]; then
		#echo $1
		echo "start add license [$1]"
		#[[ $str =~ "this" ]] && echo "\$str contains this" 
		if [ `grep "error" file.txt  &>> error.txt` ] ;then
			cat file.txt
		else
			echo 'no error find in file.txt'
		fi
	fi
	
	#echo "null"
}

function listFiles()
{
	#1st param, the dir name
	#2nd param, the aligning space
	for file in `ls $1`;
	do
		if [ -d "$1/$file" ]; then
			filtCodeFile $file
			#echo $?
			#echo result
			#if [ $file == *.h$ -o $file == *.m$ ]; then
			#	echo "$2$file"
			#fi
			#echo "$2$file"
			listFiles "$1/$file" "   $2"
		else
			#if [[ $file == *.h$ -or $file == *.m$]]; then
			#	echo "$2$file"
			#fi
			filtCodeFile $file
			#echo $?
			#echo result
		fi
	done
}

listFiles $1 ""
