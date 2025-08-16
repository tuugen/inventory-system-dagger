# introduction

dagger build files

# Running

requires
- docker daemon running (docker desktop etc..)
- dagger installed https://docs.dagger.io/install/

```bash
cd build

dagger --verbose call my-build-game-step \
       --platform_build_container=arm64 \
       --platform=macos --game_dir=game1 --src=. \
       export --path=./my-export22.zip


```


# Notes

when downgrading from 2.9.1 to 2.6.3, 
project.godot needs to have 
`enabled=PackedStringArray("res://addons/fmod/plugin.cfg", "res://addons/inventory-system/plugin.cfg")` put back in it