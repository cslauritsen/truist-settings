#!/bin/bash
# Usage: tmrsync host path-on-host-to-backup-to
logfile=/tmp/tmrsync.log

ts() {
	 date '+%Y-%m-%d %H:%M:%S'
}

log() {
	if [ "$#" -gt 0 ] 
	then
		echo $(ts) "$@" | tee -a $logfile
	else
		cat | while read ln
		do
			echo $(ts) $ln | tee -a $logfile
		done
		ts | tee -a $logfile
		cat | tee -a $logfile
	fi
}

#sz=$(stat -c '%s' $logfile)
#if [[ "$sz" -gt $((1024*1024*2)) ]]
#then
#	t=$(date '+%Y-%m-%d_%H-%M-%S')
#	mv $logfile ${logfile}.${t}
#	gzip ${logfile}.${t}
#	# clean up old logs
#	echo cleaning up old logs
#	find $(dirname $logfile) -type f -name '*.gz' -mtime +14 | grep $(basename $logfile .log) | xargs rm -f
#fi

log ===============================
log Starting $0


[ -f $HOME/.rsync/exclude ] || {
  # Skip certain filenames always
  mkdir ~/.rsync
  cat <<'%' > ~/.rsync/exclude
*~
.*.swp
.*.swo
.git
~*
%
}

host=$1
shift
timemachine=$1
shift

test -n "$host" && test -n $timemachine || {
  echo "usage: $0 host backup-dir"
}

# Try cygwin, else linux/mac `cd` should suffice
cd /cygdrive/c/Users/$USER/ >/dev/null 2>&1 || cd 

if ssh -o 'ConnectTimeout 20' $host echo $host lives
then
	log rsyncing all Documents to $host
	dt=$(date "+%Y/%m/%d")
	tm=$(date "+%H_%M_%S")
	tgt=incomplete_back-$(uuidgen)
	if rsync -aP \
		--delete-excluded \
		--exclude-from=$HOME/.rsync/exclude \
		--link-dest=../current/\
		--rsync-path="mkdir -p $timemachine/$dt && rsync" \
		Documents \
		$host:$timemachine/$tgt \
	       && ssh $host \
       	       "mv $timemachine/$tgt $timemachine/$dt/$tm \
	       && rm -f $timemachine/current \
	       && ln -s $dt/$tm $timemachine/current" 2>&1 | tee -a $logfile
	then
		log rsync completed successfully
	else
	  rc=$?
		log rsync exited with return code $rc
		exit $rc
	fi
else
	log Could not connect to any rsync hosts
	exit 1
fi