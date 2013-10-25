#! /bin/bash

JAR_FILE="target/grep.jar"
LOG_FILE="/home/dilip/fulldumplog.log"

#command prefixes
JAVA_EXECUTION="java -jar $JAR_FILE"
GREP_EXECUTION="grep"

#different search key words for testing performance
KEY_WORDS=('EOFException' 'readUsingTempSelector')

#count of the keywords. For iterating keywords
KEY_WORDS_COUNT=${#KEY_WORDS[@]}

#implementation details for searcher.
SEARCHER_IMPLS=('-c')

#count of searcher implementaion count
SEARCHER_IMPLS_COUNT=${#SEARCHER_IMPLS[@]}

#Grep command details
grep_details=()

# executes the command and returns the time of execution.
function_getExcecTime() {
	local startTime=`date "+%s"`
	$1
	local endTime=`date "+%s"`
	local timeTaken=$(($endTime-$startTime))
	return $timeTaken
}

# returns the command to execute grep command
function_getCommand() {
	local command=''
	if [[ -z $4 ]]; then
		#statements
		command="$1 $2 $3"
	else
		command="$1 $2 $3 $4"
	fi
	return command
}

#returns the test results of grep command
function_testGrep() {
	local keyword_i=0
	local com=""
	while [[ $keyword_i -lt $KEY_WORDS_COUNT ]]; do
		#function_doReturnExcecutionTime "echo ${KEY_WORDS[$i]}"
		com="$function_getCommand $GREP_EXECUTION ${KEY_WORDS[$keyword_i]} $LOG_FILE"
		function_getExcecTime "$com"
		grep_details=("${grep_details[@]}" $?)
		#grep_details[$(($keyword_i+1))]=function_getExcecTime $com
		keyword_i=$(($keyword_i+1))
	done
}

#prints the grep execution details
function_printGrepDetails() {
	local grep_count=${#grep_details[@]}
	local i=0
	echo "-----------------------"
	echo "Time Taken to execute Grep commands"
	while [[ $i -lt $grep_count ]]; do
		#statements
		echo "${KEY_WORDS[$i]} :: ${grep_details[$i]} seconds"

		i=$(($i+1))

	done
}

#return the test results of java application
function_testJava() {
	local keyword_i=0
	while [[ $keyword_i -lt $KEY_WORDS_COUNT ]]; do
		#function_doReturnExcecutionTime "echo ${KEY_WORDS[$i]}"
		com="$function_getCommand $JAVA_EXECUTION -c ${KEY_WORDS[$keyword_i]} $LOG_FILE"
		function_getExcecTime "$com"
		java_details=("${java_details[@]}" $?)
		keyword_i=$(($keyword_i+1))
		echo $com
	done
}

#prints the java test details
function_printJavaDetails() {
	local java_count=${#java_details[@]}
	local i=0
	echo "-----------------------"
	echo "Time Taken to execute Java commands"
	while [[ $i -lt $java_count ]]; do
		#statements
		echo "${KEY_WORDS[$i]} :: ${java_details[$i]} seconds"

		i=$(($i+1))

	done
}


# Testing whether jar file is there or not. If not running <mvn install> to generate jar file
if [ ! -f $JAR_FILE ] ; 
	then
		mvn clean install
		# again testing if created successfully or not
		if [ ! -f $JAR_FILE ] ; 
			then
				echo "error in <mvn install>"
				# exiting the application
				exit
		fi
		echo "successfully completed <mvn install> command"
fi
function_testGrep
function_testJava
echo "-----------------------"
echo "Time Taken to execute commands"
function_printGrepDetails
function_printJavaDetails
