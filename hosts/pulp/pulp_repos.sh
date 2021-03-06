#
# This script creates and populates at set of CentOS and Debian pulp repositories
#
# Pre-requisites:
#   'pulp-admin login -u <admin> -p <pass>' must have been executed
#
#=============================================================================

function proxy_string()
{
local str

str=''

[ -n "$PROXY_URL" ] && str="--proxy-host=$PROXY_URL"
[ -n "$PROXY_PORT" ] && str="$str --proxy-port=$PROXY_PORT"

echo $str
}

#-----

function create_centos_repos()
{
orig_version="$1"
pub_version="$2"

arch=x86_64
repos="os centosplus extras updates"

for repo in $repos ; do
  id="centos-${pub_version}-${repo}"
  src="http://mirror.centos.org/centos/${orig_version}/${repo}/${arch}/"
  url="centos/${pub_version}/${repo}"
  proxy=`proxy_string`
  pulp-admin rpm repo create --repo-id "$id" --feed "$src" $proxy \
    --relative-url "$url"
  pulp-admin rpm repo sync run --repo-id "$id"
done

# Register schedule to sync the 'updates' repo every night

pulp-admin rpm repo sync schedules create --schedule "2019-01-01T04:00:00Z/P1D" \
  --repo-id "$id"
}

#-----

function create_debian_repos()
{
version="$1"
component="$2"
architectures="$3"
releases="$4"

id="debian-${version}-${component}"
src="http://ftp.debian.org/debian"
url="debian/${version}/${component}"
proxy=`proxy_string`
pulp-admin deb repo create --repo-id "$id" --feed "$src" $proxy \
  --releases "$releases" --architectures "$architectures" \
  --components "$component" --relative-url "$url"
pulp-admin deb repo sync run --repo-id "$id"

# Refresh every night

pulp-admin deb repo sync schedules create --schedule "2019-01-01T04:00:00Z/P1D" \
  --repo-id "$id"
}

#-----
