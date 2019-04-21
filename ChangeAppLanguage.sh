#!/bin/sh

# 颜色
red='\033[0;31m'
green='\033[0;32m'
none='\033[0m'

# 传参执行
[ "$#" != "0" ] && echo -e "将软件:${green} $1 ${none}语言设置为:${green} $2 ${none}。" && defaults write "$1" AppleLanguages "($2)" && exit 1

# 未传参执行
# 输入包名
echo -e "请输入要修改默认语言的${red} 软件包名 ${none}(例: com.microsoft.Word): "
read pack
# 选择语言
echo "请选择要设置的默认语言:"
echo -e "${green}1. ${none}英语"
echo -e "${green}2. ${none}简体中文"
echo -e "${green}3. ${none}繁体中文"
echo -e "${green}4. ${none}其他语言 (手动输入语言代号，例: zh-Hans，${red}输入错误可能导致软件无法正常启动${none})"
read -p "输入数值进行选择 (默认:2): " lang
if  [ ! -n "$lang" ] ; then
    echo -e "未进行选择，默认将语言设置为:${green} 简体中文 ${none}。"
else
    while [ -n "$lang" ] && [ "$lang" != 1 ] && [ "$lang" != 2 ] && [ "$lang" != 3 ] && [ "$lang" != 4 ]
        do
	     echo -e "${red}输入错误${none}，请确认输入为${red} 1 - 4 ${none}的整数"
        read -p "请重新输入数值进行选择 (默认:2): " lang
	 [ ! -n "$pack" ] && echo -e "未进行选择，默认将语言设置为:${green} 简体中文 ${none}。" 
    done
fi
# 设置语言
if  [ "$lang" == 1 ] ; then
    echo -e "将软件:${green} $pack ${none}语言设置为:${green} 英语 ${none}。"
    defaults write "$pack" AppleLanguages '("en")'
elif [ ! -n "$lang" ] || [ "$lang" == 2 ] ; then
    echo -e "将软件:${green} $pack ${none}语言设置为:${green} 简体中文 ${none}。"
    defaults write "$pack" AppleLanguages "(zh-Hans)"
elif [ "$lang" == 3 ] ; then
    echo -e "将软件:${green} $pack ${none}语言设置为:${green} 繁体中文 ${none}。"
    defaults write "$pack" AppleLanguages "(zh-Hant)"
elif  [ "$lang" == 4 ] ; then
    read -p "请输入要设置的语言代号:" lang
    echo -e "将软件:${green} $pack ${none}语言设置为:${green} $lang ${none}。"
    defaults write "$pack" AppleLanguages "($lang)"
fi