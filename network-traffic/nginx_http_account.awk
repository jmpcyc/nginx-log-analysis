##
#
#     Nginx log file analysis.
#
#     @author smtppop3@outlook.com
#     @history 2014-12-24
#
#     My nginx log_format
#     log_format mylog '%ra - %ru [%tl] "%req" ' '%sta %bbs %bs %req_len ' '"%agent" ' '%req_time' ' host:%h';
#	 
#     %ra = $remote_addr
#	  %ru = $remote_user
#	  %tl = $time_local
#	  %req = $request
#     %sta = $status
#     %bbs = $body_bytes_sent
#     %bs = $bytes_sent
#     %req_len = $request_length
#     %agent = $http_user_agent
#     %req_time = $request_time
#     %h = $host
#     
#     log file row:
#     xxx.23x.xx7.4x - - [25/Dec/2014:14:42:22 +0800] "GET /api/ HTTP/1.1" 444 0 0 211 "Dalvik/1.6.0 (Linux; U; Android 4.2.1; Android TV on Tcl 901 Build/JOP40D)" 0.000 host:www.hostname.com 
#    
#     output format:
#     17-14:45,0.206,0
#
###

BEGIN {
        interval = 5;      
}

{
        time = substr($4, 2);
       	idx = dateIndexHash(time);
        inputdata[idx]+=$12;
        outputdata[idx]+=$11; 
}

END {
	  interval = interval * 60 * 1024;
	  for(y in inputdata){
          print y","(inputdata[y] / interval)","(outputdata[y] /interval);
      }
}

function dateIndexHash(time) {
	
	split(time, arr, ":");
	split(arr[1], daytimearr, "/");
	day = daytimearr[1];
	month = daytimearr[2];
	
	
	if (day < 10) {
		day = "0"day;
	}
	hour = arr[2];
	minute = arr[3];
	idx = minute / interval;
	
	if (minute > 55) {
		minute = "00";
		hour += 1;
		if (hour < 10) {
			hour = "0"hour;
		} 
	} else if ((minute % interval) != 0) {
		
		split(idx, minArr, ".");
		idx = minArr[1];
		minute = (idx + 1) * interval;
		if (minute < 10) {
			minute = "0"minute;
		}
	}
	 
	return day"-"hour":"minute;
}