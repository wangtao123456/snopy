#设置日期
MYDT=`date +%Y%m%d`
n=-1
m=-21
nMonthsAgo=`date -d "${MYDT}  $n months $m days " +%Y%m%d`
echo ${nMonthsAgo}

cd /upsql/history/
unzip  ${nMonthsAgo}.zip

#执行sql
/upsql/upsql-2.1.0/bin/mysql -uupsql -p******* -h10.194.131.** upsql << EOF 2>/upsql/01/message.logs
load data local infile '/upsql/history/${nMonthsAgo}/message.txt'   ignore into table message_${nMonthsAgo}     character set utf8  fields terminated by '\\\\@\\\\$' escaped by '\\~'  (ID,PRIORITY,PHONENUMBER,TEXTMSG,BANKNO,SOURCE,RECEIVETIME,INPUTTIME,FAILREASON);
commit;
exit;
EOF

cd /upsql/history/
rm -rf ${nMonthsAgo}
