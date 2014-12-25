##
#  
#   @Author smtppop3@outlook.com
#   @History 2014-12-24
#
##

### input and output ##

##single gziped log file

1.zcat /var/log/nginx/access.log-20141130.gz | awk -f nginx_http_account_input.awk | sort -n > result.log 

or

2.awk -f nginx_http_account.awk <(zcat /var/log/nginx/access.log-20141218.gz) | sort -n > result.log 



##multi gziped log files

awk -f nginx_http_account.awk <(zcat file1.gz) <(zcat file2.gz) | sort -n >> result.log 


