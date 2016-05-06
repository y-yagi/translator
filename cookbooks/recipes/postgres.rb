execute "rpm -Uvh http://yum.postgresql.org/9.5/redhat/rhel-6-x86_64/pgdg-redhat95-9.5-2.noarch.rpm"
package "postgresql95-server"
package "postgresql95"
execute "/usr/pgsql-9.5/bin/initdb"
