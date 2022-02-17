# conkyround
conky config files, based on Conky-Minimalism by Fleming Henry

Rounded conky, semi-transparent background, lua rings, CPU bar graphs, CPU and GPU temps, etc.

Do note that this config may not work out of the box on all systems, it was coded on Void Linux, which means some variables might be different in more standard distributions.

Also, for some reason if you draw a coloured background in lua (because of the rounded corners, it requires that the background transparency be coded via lua and not the config file, or at least I couldn't figure out how to get rounded corners and transparent config to work together), it will draw that background over any image you include in the config file, so if images aren't showing up, check that your background transparency in lua is sufficiently low, and that you have not added a background to the config itself.

![conky](https://user-images.githubusercontent.com/87580563/154405011-116f7cf8-19d7-4cba-9536-2cdab6f27150.png)
