#!/run/current-system/sw/bin/zsh
packwiz modrinth export --restrictDomains=false
#packwiz curseforge export 

mv htx-1.0.0.mrpack modrinth.mrpack
#mv htx-1.0.0.zip curseforge.zip
