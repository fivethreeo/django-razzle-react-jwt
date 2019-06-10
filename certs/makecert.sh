#!/bin/bash
#
# ARG_OPTIONAL_SINGLE([common-name],[c],[set common name],[localhost])
# ARG_OPTIONAL_REPEATED([dns],[d],[add dns host entry to serverAltName])
# ARG_OPTIONAL_REPEATED([ip],[i],[add ip host entry to serverAltName])
# ARG_OPTIONAL_BOOLEAN([passphrase],[p],[use passphrase])
# ARG_OPTIONAL_BOOLEAN([https],[s],[make https certificate])
# ARG_OPTIONAL_SINGLE([dn-c],[],[set distinguished name C country code, e.g. US, ES])
# ARG_OPTIONAL_SINGLE([dn-st],[],[set distinguished name ST state/region, e.g. TX, Catalonia])
# ARG_OPTIONAL_SINGLE([dn-l],[],[set distinguished name L location/city, e.g. Washington, Barcelona])
# ARG_OPTIONAL_SINGLE([dn-o],[],[set distinguished name O organization name e.g. Goldman Sachs, Partit dels Socialistes de Catalunya])
# ARG_OPTIONAL_SINGLE([dn-ou],[],[set distinguished name OU organization unit name e.g. Development, Revolution])
# ARG_OPTIONAL_SINGLE([dn-email],[],[set distinguished name emailAdress wontreadcomplaints@gms.com, cantcomplain@pdsdc.es])
# ARG_HELP([If basename_<scheme>_ca_key.pem exists already new certificates will be made using this ca\nexample: makecert.sh --dn-c "NO" --dn-st "Trøndelag" --dn-l "Levanger" --dn-o "Private" --dn-ou "Home" --dn-email "oyvind.saltvik@gmail.com" \ \n--common-name "localhost" --dns "localhost" --ip "127.0.0.1" --https])
# ARGBASH_GO()
# needed because of Argbash --> m4_ignore([
### START OF CODE GENERATED BY Argbash v2.6.1 one line above ###
# Argbash is a bash code generator used to get arguments parsing right.
# Argbash is FREE SOFTWARE, see https://argbash.io for more info
# Generated online by https://argbash.io/generate

die()
{
  local _ret=$2
  test -n "$_ret" || _ret=1
  test "$_PRINT_HELP" = yes && print_help >&2
  echo "$1" >&2
  exit ${_ret}
}

begins_with_short_option()
{
  local first_option all_short_options
  all_short_options='bcdipsh'
  first_option="${1:0:1}"
  test "$all_short_options" = "${all_short_options/$first_option/}" && return 1 || return 0
}



# THE DEFAULTS INITIALIZATION - OPTIONALS
_arg_common_name="localhost"
_arg_dns=()
_arg_ip=()
_arg_passphrase="off"
_arg_https="off"
_arg_dn_c=
_arg_dn_st=
_arg_dn_l=
_arg_dn_o=
_arg_dn_ou=
_arg_dn_email=

print_help ()
{
  printf '%s\n' 'If <common-name>_<scheme>_ca[_key].pem exists already new certificates will be made using this ca

examples:

makecert.sh --dn-c "US" --dn-st "TX" --dn-l "Houston" \
  --dn-o "Your organization" --dn-ou "Your department" \
  --dn-email "your@email.com" \
  --common-name "localhost" --dns "localhost" --ip "127.0.0.1" --https

makecert.sh --dn-c "US" --dn-st "TX" --dn-l "Houston" \
  --dn-o "Your organization" --dn-ou "Your department" \
  --dn-email "your@email.com" \
  --common-name "example.com" --dns "example.com" --dns "www.example.com" --dns "admin.example.com" --https

Tls server and client certificates for docker

makecert.sh --dn-c "US" --dn-st "TX" --dn-l "Houston" \
  --dn-o "Your organization" --dn-ou "Your department" \
  --dn-email "your@email.com" \
  --common-name "docker" --ip "192.168.0.2" 
    '
  printf 'Usage: %s [-c|--common-name <arg>] [-d|--dns <arg>] [-i|--ip <arg>] [-p|--(no-)passphrase] [-s|--(no-)https] [--dn-c <arg>] [--dn-st <arg>] [--dn-l <arg>] [--dn-o <arg>] [--dn-ou <arg>] [--dn-email <arg>] [-h|--help]\n' "$0"
  printf '\t%s\n' "-c,--common-name: set common name (default: 'localhost')"
  printf '\t%s\n' "-d,--dns: add dns host entry to serverAltName (empty by default)"
  printf '\t%s\n' "-i,--ip: add ip host entry to serverAltName (empty by default)"
  printf '\t%s\n' "-p,--passphrase,--no-passphrase: use passphrase (off by default)"
  printf '\t%s\n' "-s,--https,--no-https: make https certificate (off by default)"
  printf '\t%s\n' "--dn-c: set distinguished name C country code, e.g. US, ES (no default)"
  printf '\t%s\n' "--dn-st: set distinguished name ST state/region, e.g. TX, Catalonia (no default)"
  printf '\t%s\n' "--dn-l: set distinguished name L location/city, e.g. Washington, Barcelona (no default)"
  printf '\t%s\n' "--dn-o: set distinguished name O organization name e.g. Goldman Sachs, Partit dels Socialistes de Catalunya (no default)"
  printf '\t%s\n' "--dn-ou: set distinguished name OU organization unit name e.g. Development, Revolution (no default)"
  printf '\t%s\n' "--dn-email: set distinguished name emailAdress wontreadcomplaints@gms.com, cantcomplain@pdsdc.es (no default)"
  printf '\t%s\n' "-h,--help: Prints help"
}

parse_commandline ()
{
  while test $# -gt 0
  do
    _key="$1"
    case "$_key" in
      -c|--common-name)
        test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
        _arg_common_name="$2"
        shift
        ;;
      --common-name=*)
        _arg_common_name="${_key##--common-name=}"
        ;;
      -c*)
        _arg_common_name="${_key##-c}"
        ;;
      -d|--dns)
        test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
        _arg_dns+=("$2")
        shift
        ;;
      --dns=*)
        _arg_dns+=("${_key##--dns=}")
        ;;
      -d*)
        _arg_dns+=("${_key##-d}")
        ;;
      -i|--ip)
        test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
        _arg_ip+=("$2")
        shift
        ;;
      --ip=*)
        _arg_ip+=("${_key##--ip=}")
        ;;
      -i*)
        _arg_ip+=("${_key##-i}")
        ;;
      -p|--no-passphrase|--passphrase)
        _arg_passphrase="on"
        test "${1:0:5}" = "--no-" && _arg_passphrase="off"
        ;;
      -p*)
        _arg_passphrase="on"
        _next="${_key##-p}"
        if test -n "$_next" -a "$_next" != "$_key"
        then
          begins_with_short_option "$_next" && shift && set -- "-p" "-${_next}" "$@" || die "The short option '$_key' can't be decomposed to ${_key:0:2} and -${_key:2}, because ${_key:0:2} doesn't accept value and '-${_key:2:1}' doesn't correspond to a short option."
        fi
        ;;
      -s|--no-https|--https)
        _arg_https="on"
        test "${1:0:5}" = "--no-" && _arg_https="off"
        ;;
      -s*)
        _arg_https="on"
        _next="${_key##-s}"
        if test -n "$_next" -a "$_next" != "$_key"
        then
          begins_with_short_option "$_next" && shift && set -- "-s" "-${_next}" "$@" || die "The short option '$_key' can't be decomposed to ${_key:0:2} and -${_key:2}, because ${_key:0:2} doesn't accept value and '-${_key:2:1}' doesn't correspond to a short option."
        fi
        ;;
      --dn-c)
        test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
        _arg_dn_c="$2"
        shift
        ;;
      --dn-c=*)
        _arg_dn_c="${_key##--dn-c=}"
        ;;
      --dn-st)
        test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
        _arg_dn_st="$2"
        shift
        ;;
      --dn-st=*)
        _arg_dn_st="${_key##--dn-st=}"
        ;;
      --dn-l)
        test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
        _arg_dn_l="$2"
        shift
        ;;
      --dn-l=*)
        _arg_dn_l="${_key##--dn-l=}"
        ;;
      --dn-o)
        test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
        _arg_dn_o="$2"
        shift
        ;;
      --dn-o=*)
        _arg_dn_o="${_key##--dn-o=}"
        ;;
      --dn-ou)
        test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
        _arg_dn_ou="$2"
        shift
        ;;
      --dn-ou=*)
        _arg_dn_ou="${_key##--dn-ou=}"
        ;;
      --dn-email)
        test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
        _arg_dn_email="$2"
        shift
        ;;
      --dn-email=*)
        _arg_dn_email="${_key##--dn-email=}"
        ;;
      -h|--help)
        print_help
        exit 0
        ;;
      -h*)
        print_help
        exit 0
        ;;
      *)
        _PRINT_HELP=yes die "FATAL ERROR: Got an unexpected argument '$1'" 1
        ;;
    esac
    shift
  done
}

parse_commandline "$@"

# OTHER STUFF GENERATED BY Argbash

### END OF CODE GENERATED BY Argbash (sortof) ### ])
# [ <-- needed because of Argbash

#

passin=""
passout=""
if [ $_arg_passphrase != "off" ]
then
  read -s -p "Enter passphrase: "  passphrase
  if [ -z $passphrase ]
  then
    echo
    echo "Passphrase required"
    exit 0
  fi
  passin="-passin pass:$passphrase"
  passout="-des3 -passout pass:$passphrase"
fi

mkdir /tmp/scert 2>/dev/null
rm -r /tmp/scert/* 2>/dev/null

echo ""

prefix=$_arg_common_name

if [ $_arg_https == "on" ]
then
  prefix="${prefix}_https"
else
  prefix="${prefix}_tls"
fi

ca_key=/tmp/scert/tmp.pass.key.pem
new_ca_key=""
if [ -f "${prefix}_ca-key.pem" ]
then
  echo Using existing ca key: ${prefix}_ca_key.pem
  ca_key="${prefix}_ca-key.pem"
else
  new_ca_key="$ca_key"
  openssl genrsa $passout -out "$ca_key" 2048
fi

ca_key_nopass="$ca_key"
if [ $_arg_passphrase == "on" ]
then
  ca_key_nopass="/tmp/scert/tmp.key.pem"
  openssl rsa $passin -in "$ca_key" -out "$ca_key_nopass"
fi

echo "[req]" > /tmp/scert/tmp.cnf
echo "default_bits = 2048" >> /tmp/scert/tmp.cnf
echo "prompt = no" >> /tmp/scert/tmp.cnf
echo "default_md = sha256" >> /tmp/scert/tmp.cnf
echo "distinguished_name = dn" >> /tmp/scert/tmp.cnf
echo "" >> /tmp/scert/tmp.cnf
echo "[dn]" >> /tmp/scert/tmp.cnf
echo "C=$_arg_dn_c" >> /tmp/scert/tmp.cnf
echo "ST=$_arg_dn_st" >> /tmp/scert/tmp.cnf
echo "L=$_arg_dn_l" >> /tmp/scert/tmp.cnf
echo "O=$_arg_dn_o" >> /tmp/scert/tmp.cnf
echo "OU=$_arg_dn_ou" >> /tmp/scert/tmp.cnf
echo "emailAddress=$_arg_dn_email" >> /tmp/scert/tmp.cnf
echo "CN=$_arg_common_name" >> /tmp/scert/tmp.cnf

echo "authorityKeyIdentifier=keyid,issuer" > /tmp/scert/tmp.ext
echo "basicConstraints=CA:FALSE" >> /tmp/scert/tmp.ext
echo "keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment" >> /tmp/scert/tmp.ext

if [ $_arg_https != "on" ]
then
  echo "extendedKeyUsage = serverAuth" >> /tmp/scert/tmp.ext
  echo "extendedKeyUsage = clientAuth" >> /tmp/scert/tmp-client.ext
fi

echo "subjectAltName = @alt_names" >> /tmp/scert/tmp.ext
echo "" >> /tmp/scert/tmp.ext
echo "[alt_names]" >> /tmp/scert/tmp.ext

dnslength=${#_arg_dns[@]}
for (( i=1; i<${dnslength}+1; i++ ));
do
  echo "DNS.$i = ${_arg_dns[$i-1]}" >> /tmp/scert/tmp.ext
done

iplength=${#_arg_ip[@]}
for (( i=1; i<${iplength}+1; i++ ));
do
  echo "IP.$i = ${_arg_ip[$i-1]}" >> /tmp/scert/tmp.ext
done

ca="/tmp/scert/${prefix}_ca.pem"
new_ca=""
if [ -f "${prefix}_ca.pem" ]
then
  echo Using existing ca: ${prefix}_ca.pem
  ca="${prefix}_ca.pem"
else
  new_ca="$ca"
  openssl req -x509 -new -nodes -key "$ca_key_nopass" -days 1024 -out "$ca" -config <( cat /tmp/scert/tmp.cnf ) 
fi

echo ""

servername=server
if [ ! $dnslength -eq 0 ]
then
  servername=${_arg_dns[0]//\./_}
else
  if [ ! $iplength -eq 0 ]
  then
    servername=${_arg_ip[0]//\./_}
  fi
fi

serverkeysuffix=${servername}-key.pem
servercertsuffix=${servername}.pem
if [ $_arg_https == "on" ]
then
  serverkeysuffix=${servername}.key
  servercertsuffix=${servername}.crt
fi

server_key="/tmp/scert/${prefix}_${serverkeysuffix}"
server_crt="/tmp/scert/${prefix}_${servercertsuffix}"

openssl req -new -sha256 -nodes -out /tmp/scert/tmp.csr -newkey rsa:2048 -keyout "$server_key" -config <( cat /tmp/scert/tmp.cnf )
openssl x509 -req -in /tmp/scert/tmp.csr -CA "$ca" -CAkey "$ca_key_nopass" -CAcreateserial -out "$server_crt" -days 500 -sha256 -extfile /tmp/scert/tmp.ext
  
echo ""
  
if [ ! -z $new_ca_key ]; then echo Generated ca private key: ${prefix}_ca-key.pem; cp $new_ca_key ${prefix}_ca-key.pem; fi
if [ ! -z $new_ca ]; then echo Generated ca certificate: ${prefix}_ca.pem; cp $new_ca .; fi

echo ""

echo Generated server key: ${prefix}_${serverkeysuffix}
cp $server_key .

echo Generated server certificate: ${prefix}_${servercertsuffix}
cp $server_crt .

echo ""

if [ $_arg_https != "on" ]
then

  clientkeysuffix=client-key.pem
  clientcertsuffix=client.pem

  client_key="/tmp/scert/${prefix}_${clientkeysuffix}"
  client_crt="/tmp/scert/${prefix}_${clientcertsuffix}"
  
  openssl req -subj '/CN=client' -new -sha256 -nodes -out /tmp/scert/tmp-client.csr -newkey rsa:2048 -keyout "$client_key"
  openssl x509 -req -in /tmp/scert/tmp-client.csr -CA "$ca" -CAkey "$ca_key_nopass" -CAcreateserial -out "$client_crt" -days 500 -sha256 -extfile /tmp/scert/tmp-client.ext

  echo ""

  echo Generated client key: ${prefix}_${clientkeysuffix}
  cp $client_key .

  echo Generated client certificate: ${prefix}_${clientcertsuffix}
  cp $client_crt .

fi

rm -r /tmp/scert/* 2>/dev/null

#
# ] <-- needed because of Argbash