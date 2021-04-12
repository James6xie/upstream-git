## get list from upstream
# we now get two namespace from centos git repo 'rpms' and 'modules'
centos.git.repolist.py --namespace rpms |tee centos.git.rpms.repolist.origin
centos.git.repolist.py --namespace modules |tee centos.git.modules.repolist.origin

## replace https://git.centos.org/
sed 's/https:\/\/git.centos.org\///g' centos.git.rpms.repolist.origin |tee centos.git.rpms.repolist.origin.stage1
sed 's/https:\/\/git.centos.org\///g' centos.git.modules.repolist.origin |tee centos.git.modules.repolist.origin.stage1

sed -i 's/^/\<project path="/g' centos.git.rpms.repolist.origin.stage1
sed -i 's/$/"/g' centos.git.modules.repolist.origin.stage1

# insert name=" ahead
sed  's/^/name="/g' centos.git.rpms.repolist.origin |tee centos.git.rpms.repolist.origin.stage2
sed  's/^/name="/g' centos.git.modules.repolist.origin |tee centos.git.modules.repolist.origin.stage2

#instert " /> behide
sed -i 's/$/" \/>/g' centos.git.rpms.repolist.origin.stage2
sed -i 's/$/" \/>/g' centos.git.modules.repolist.origin.stage2

#merge to a complete manifest file
echo "merge to manifest"
paste  centos.git.rpms.repolist.origin.stage1 centos.git.rpms.repolist.origin.stage2 |tee manifesti.rpms.xml
paste  centos.git.modules.repolist.origin.stage1  centos.git.modules.repolist.origin.stage2 |tee manifesti.modules.xml
