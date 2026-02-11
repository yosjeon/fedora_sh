#!/bin/bash

echo "#-- sudo nmcli dev wifi rescan #-- 주변 Wi-Fi 다시 검색"
sudo nmcli dev wifi rescan
echo "#-- sudo nmcli dev wifi list   #-- 검색된 리스트 보기 (SSID 항목 확인)"
sudo nmcli dev wifi list
