echo -e "                        .                         "
echo -e "                        ;'                        "
echo -e "                       'cl.                       "
echo -e "                      .cccl                       "
echo -e "                      :cccl:                      "
echo -e "                     ,cccccl'                     "
echo -e "                    .lllcccco.                    "
echo -e "                   .lllllllcll                    "
echo -e "                   cllllllllloc                   "
echo -e "                  . :oolllllllo;                  "
echo -e "                 ;oc..:ooolllllo'                 "
echo -e "                'ddooo::loooollod.                "
echo -e "               .ddddddoooooooooooo.               "
echo -e "              .ddddddddddoooooooooo               "
echo -e "             .dddddddolllcccccllllol              "
echo -e "             odddolccccccccccccccccc:             "
echo -e "            odlcccccccccccccccccccccc;            "
echo -e "           :cccccccccc,....:cccccccccc,           "
echo -e "          ;cccccccccc.      'cccccccccc'          "
echo -e "         ,cccccccccc.        'cccccccccc.         "
echo -e "        ,cccccccccc;          :cccccccccc.        "
echo -e "       'ccccccccccc.          ,cccccc:;;cc.       "
echo -e "      .cccccccccccc.          .cccccccc:...       "
echo -e "     .ccccccccccccc.          'ccccccccccc'       "
echo -e "    .cccccccccc:;'.           ..,;cccccccccc,     "
echo -e "   .ccccccc;'.                      .,:cccccc:    "
echo -e "  .cccc:'.                              .,cccc:   "
echo -e " .cc;.                                     .':c:  "
echo -e ".,.                                            ., "
echo -e "                                                  "

echo -e "\n";
echo -e "\033[1;33m Willkommen auf $(uname -n) \033[0m";
echo -e "\n";
echo -e "=============================================================================================="
echo -e "\033[1;33m Systemzeit:      \033[0m" `date | awk '{print $4}'`
echo -e "\033[1;33m Online seit:     \033[0m" `uptime | awk '{print $3}'` "Stunden"
echo -e "\033[1;33m Speichernutzung: \033[0m" `cat /proc/meminfo|grep 'MemF'| awk '{print $2}'` "kB von" `cat /proc/meminfo|grep 'MemT'| awk '{print $2}'` "kB frei"
if [ -f /sys/class/thermal/thermal_zone0/temp ]; then
echo -e "\033[1;33m CPU-Temp:        \033[0m" `cat /sys/class/thermal/thermal_zone0/temp| awk '{print $1/1000}'` "°C"
fi
echo -e "\033[1;33m IPs:             \033[0m" `ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1`
echo -e "\033[1;33m Macs:            \033[0m" `ip link | grep ether`
echo -e "\033[1;33m Hostname:        \033[0m" `hostname`
echo -e "\033[1;33m Benutzer:        \033[0m" `whoami`
echo -e "\033[1;33m Grafikkarte:     \033[0m" `lspci | grep -e VGA -e 3D -m 1`
echo -e "\033[1;33m Öffentliche IP:  \033[0m" `wget -qO- ipv4.icanhazip.com || echo "Gescheitert"`
