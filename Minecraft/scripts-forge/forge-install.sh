#!/bin/bash
java -Djava.net.useSystemProxies=false -Dhttp.proxyHost=proxy3.nyit.edu -Dhttp.proxyPort=80 -Dhttps.proxyHost=proxy4.nyit.edu -Dhttps.proxyPort=80 -Dftp.proxyHost=proxy5.nyit.edu -Dftp.proxyPort=80 -jar forge-1.12.2-14.23.5.2768-installer.jar --installServer

#/usr/lib/jvm/java-8-openjdk-amd64/bin/java -jar forge-1.12.2-14.23.5.2768-universal.jar
