#! /bin/bash

#############################
# usage: push2blog.sh category blog
# category:文章的分类
# blog: 文章的路径
##############################


function print_usage()
{
echo "#############################"
echo "#usage: push2blog.sh category blog"
echo "#############################"
}

POST_CATEGORY="$1"
POST_PATH="$2"

# check arg
if [ -z "$1" -o -z "$2" ]; then
    print_usage
    exit -101
fi


APP_PATH="/var/mobile/Applications/06033C5E-7EBE-408B-8A44-EFB2B48526A9"
GIT_REPO_PATH="${APP_PATH}/Library/git/blog"
mkdir -p ${GIT_REPO_PATH}
GIT_REPO_CLONE_PATH="git@github.com:nonstriater/nonstriater.github.com.git"
BLOG_PATH="${GIT_REPO_PATH}/nonstriater.github.com"


# check repo if exist
if [ ! -e ${BLOG_PATH}/index.md ]; then
    echo "blog repo not exist,begin clone..."
    cd "${GIT_REPO_PATH}"
    rm -rf "${BLOG_PATH}"
    env GIT_SSL_NO_VERIFY=true git clone "${GIT_REPO_CLONE_PATH}"
fi
if [ "$?" != 0 ]; then
    echo "git clone fail..."
    exit 1
fi


# pull before push
cd "${BLOG_PATH}"
env GIT_SSL_NO_VERIFY=true git pull
if [ "$?" != 0 ]; then
    echo "git pull fail..."
    exit 2
fi


BLOG_POSTS_PATH="${BLOG_PATH}/_posts"
BLOG_POST_STORE_PATH="${BLOG_POSTS_PATH}/${POST_CATEGORY}"
mkdir -p "${BLOG_POST_STORE_PATH}"


# copy the markdown post to post
if [ ! -e "${POST_PATH}" ]; then
    echo "post path wrong,check the arg：$2"
    print_usage
    exit 3
fi

# cp
echo "COPY ${POST_PATH} To ${BLOG_POST_STORE_PATH}"
cp "${POST_PATH}" "${BLOG_POST_STORE_PATH}"
if [ "$?" != 0 ]; then
    echo "copy file fail..."
    exit 4
fi


# push
echo "begin to add/commit/push,please be patient..."
cd "${BLOG_PATH}"
git commit -a -m "new post:$2"
if [ "$?" != 0 ]; then
    echo "GIT error:commit post fail..."
    exit 6
fi

env GIT_SSL_NO_VERIFY=true git push origin master
if [ "$?" != 0 ]; then
    echo "GIT error:push post fail..."
    exit 7
fi
echo "push finished!"








