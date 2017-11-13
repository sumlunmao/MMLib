#!/bin/bash

#打包发布脚本
## Usage 使用方法
#### step1 : 将distribute.sh文件拖入项目主目录(与.xcodeproj一个层级)
#### step2 : 打开distribute.sh文件，修改"编译目标名称"为项目名称
#### step3 : 打开终端，cd到项目文件夹
#### step4 : 输入 sh distribute.sh 命令，回车，开始执行此脚本
###

# 设置编译目标
targetName="mo9Library"

# 设置编译模式通常 Debug Release
compileMode="Release"

# 设置需要的编译架构
distribute_x86_archs=("i386" "x86_64")
distribute_arm_archs=("armv7" "armv7s" "arm64")

# 设置需要的sdk
iOS_iPhoneSimulator_sdk="iphonesimulator"
iOS_iPhoneOS_sdk="iphoneos"


# 设置各种版本编译后的目录
target_distribution_sdk="distribution_sdk"

# 设置发布的SDK名称
target_sdk_name="${targetName}.framework"

#编译各种arch版本的库文件
if [ -d "${target_distribution_sdk}" ]  
then  
rm -rf "${target_distribution_sdk}"  
fi

#清理build文件
if [ -d "build" ]  
then  
rm -rf "build"  
fi

#删除老的framework
if [ -d "${target_sdk_name}" ]  
then  
rm -rf "${target_sdk_name}"  
fi

mkdir "${target_distribution_sdk}"

for distribute_arch in ${distribute_x86_archs[@]};do
	xcodebuild -target "$targetName" -configuration "${compileMode}"  -sdk "${iOS_iPhoneSimulator_sdk}" -arch "${distribute_arch}" build
	mkdir "${target_distribution_sdk}/${distribute_arch}"
	mv "build/${compileMode}-iphonesimulator/${target_sdk_name}" "${target_distribution_sdk}/${distribute_arch}/${target_sdk_name}"
	rm -rf "build" 
done

for distribute_arch in ${distribute_arm_archs[@]};do
	xcodebuild -target "$targetName" -configuration "${compileMode}"  -sdk "${iOS_iPhoneOS_sdk}" -arch "${distribute_arch}" build
	mkdir "${target_distribution_sdk}/${distribute_arch}"
	mv "build/${compileMode}-iphoneos/${target_sdk_name}" "${target_distribution_sdk}/${distribute_arch}/${target_sdk_name}"
	rm -rf "build" 
done


if [ -d "distribution_target" ]  
then  
rm -rf "distribution_target"  
fi
mkdir "distribution_target"

mkdir "./distribution_target/${target_sdk_name}"
cp -R "${target_distribution_sdk}/arm64/${target_sdk_name}" "./distribution_target"
rm -rf "./distribution_target/${target_sdk_name}/${targetName}"

lipo -create "${target_distribution_sdk}/i386/${target_sdk_name}/${targetName}" "${target_distribution_sdk}/x86_64/${target_sdk_name}/${targetName}" "${target_distribution_sdk}/armv7/${target_sdk_name}/${targetName}" "${target_distribution_sdk}/armv7s/${target_sdk_name}/${targetName}" "${target_distribution_sdk}/arm64/${target_sdk_name}/${targetName}" -output "distribution_target/${target_sdk_name}/${targetName}"


# 清理文件夹
rm -rf "${target_distribution_sdk}"
#rm -rf "distribution_target"

echo "构建完成"

















