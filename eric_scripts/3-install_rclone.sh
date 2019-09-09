curl -O https://downloads.rclone.org/rclone-current-linux-amd64.zip
unzip rclone-current-linux-amd64.zip
cd rclone-*-linux-amd64
mkdir /home/ericwallace/bin
cp rclone /home/ericwallace/bin
chmod 755 /home/ericwallace/bin/rclone
cd /home/ericwallace/jiant
mkdir -p /home/ericwallace/.config
mkdir -p /home/ericwallace/.config/rclone
cp eric_scripts/rclone.conf /home/ericwallace/.config/rclone/rclone.conf
rm rclone-current-linux-amd64.zip
rm -rf rclone-current-linux-amd64.zip
