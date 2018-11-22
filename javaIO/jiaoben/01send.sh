#设置日期
MYDT=`date +%Y%m%d`
n=-1
m=-21
nMonthsAgo=`date -d "${MYDT}  $n months $m days  " +%Y%m%d`
echo ${nMonthsAgo}

cd /upsql/history/
unzip  ${nMonthsAgo}.zip

#执行sql
/upsql/upsql-2.1.0/bin/mysql -uupsql -p******** -h10.194.131.** upsql << EOF 2>/upsql/01/send.logs
load data local infile '/upsql/history/${nMonthsAgo}/message_send.txt' ignore into table message_${nMonthsAgo}send character set gbk  fields terminated by '\\\\@\\\\$' escaped by '\\~'  (ID,SENDTIME,SP,CARRIER,PHONE);
commit;
exit;
EOF

cd /upsql/history/
rm -rf ${nMonthsAgo}
