#
# This script creates and populates at set of CentOS and Debian pulp repositories
#
# Pre-requisites:
#   'pulp-admin login -u <admin> -p <pass>' must have been executed
#
#=============================================================================

function create_centos_repos()
{
orig_version="$1"
pub_version="$2"

arch=x86_64


for repo in os centosplus extras updates ; do
  id="centos-${pub_version}-${repo}"
  src="http://mirror.centos.org/centos/${orig_version}/${repo}/${arch}/"
  url="centos/${pub_version}/${repo}"
  pulp-admin rpm repo create --repo-id "$id" --feed "$src" --relative-url "$url"
  pulp-admin rpm repo sync run --repo-id "$id"
done

# Register schedule to sync the 'updates' repo every night

pulp-admin rpm repo sync schedules create --schedule "04:00/P1D" --repo-id "$id"
}

#-----

function create_debian_repos()
{
version="$1"
components="$2"
architectures="$3"

id="debian-${pub_version}"
src="http://ftp.fr.debian.org/debian"
releases="Debian$version"
url="debian/${pub_version}"

pulp-admin deb repo create --repo-id "$id" --feed "$src" --releases "$releases" \
  --architectures "$architectures" --components "$components" --relative-url "$url"

pulp-admin rpm repo sync run --repo-id "$id"

# Refresh every night

pulp-admin rpm repo sync schedules create --schedule "04:00/P1D" --repo-id "$id"
}

#-----
