This is contailer build for Tid Project

1) Copy your project all root file in 'public_html'.
2) Copy database (.sql) into 'mysql-dump' folder.
4) copy your project setting.php outside public_html folder and update database details :
    Username = tiduser
    Password = tidpass 
    Database = tid_db
    Host = tid-mysql
5) copy your project sites.php outside public_html folder and update domain detail :
   $sites['docker.tid.com'] = 'tradeandindustrydev.com';
3) Run  ./buid.sh if you are running first time build or modify any changes in docker file.
OR
Run ./runscript if you want restart docker.

4) Make host entry on your local machoine.
 172.18.0.1    docker.tid.com
5) Wait for few second for database import will take time. 

Website :  http://docker.tid.com:30080/
Phpmyadmin : http://localhost:8000

