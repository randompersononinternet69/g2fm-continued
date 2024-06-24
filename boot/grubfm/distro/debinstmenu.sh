menuentry --hotkey=g 'Graphical install' {
    set background_color=black
    linux    (loop)/install.amd/vmlinuz vga=788 --- quiet 
    initrd   (loop)/install.amd/gtk/initrd.gz
}
menuentry --hotkey=i 'Install' {
    set background_color=black
    linux    (loop)/install.amd/vmlinuz vga=788 --- quiet 
    initrd   (loop)/install.amd/initrd.gz
}
submenu --hotkey=a 'Advanced options ...' {
    set menu_color_normal=cyan/blue
    set menu_color_highlight=white/blue
    set theme=/boot/grub/theme/1-1
    set gfxpayload=keep
    menuentry '... Graphical expert install' {
        set background_color=black
        linux    (loop)/install.amd/vmlinuz priority=low vga=788 --- 
        initrd   (loop)/install.amd/gtk/initrd.gz
    }
    menuentry '... Graphical rescue mode' {
        set background_color=black
        linux    (loop)/install.amd/vmlinuz vga=788 rescue/enable=true --- quiet  
        initrd   (loop)/install.amd/gtk/initrd.gz
    }
    menuentry '... Graphical automated install' {
        set background_color=black
        linux    (loop)/install.amd/vmlinuz auto=true priority=critical vga=788 --- quiet 
        initrd   (loop)/install.amd/gtk/initrd.gz
    }
    menuentry --hotkey=x '... Expert install' {
        set background_color=black
        linux    (loop)/install.amd/vmlinuz priority=low vga=788 --- 
        initrd   (loop)/install.amd/initrd.gz
    }
    menuentry --hotkey=r '... Rescue mode' {
        set background_color=black
        linux    (loop)/install.amd/vmlinuz vga=788 rescue/enable=true --- quiet 
        initrd   (loop)/install.amd/initrd.gz
    }
    menuentry --hotkey=a '... Automated install' {
        set background_color=black
        linux    (loop)/install.amd/vmlinuz auto=true priority=critical vga=788 --- quiet 
        initrd   (loop)/install.amd/initrd.gz
    }
    submenu --hotkey=s '... Speech-enabled advanced options ...' {
        set menu_color_normal=cyan/blue
        set menu_color_highlight=white/blue
        set theme=/boot/grub/theme/1-1-1
        set gfxpayload=keep
        menuentry --hotkey=x '... Expert speech install' {
            set background_color=black
            linux    (loop)/install.amd/vmlinuz priority=low vga=788 speakup.synth=soft --- 
            initrd   (loop)/install.amd/gtk/initrd.gz
        }
        menuentry --hotkey=r '... Rescue speech mode' {
            set background_color=black
            linux    (loop)/install.amd/vmlinuz vga=788 rescue/enable=true speakup.synth=soft --- quiet  
            initrd   (loop)/install.amd/gtk/initrd.gz
        }
        menuentry --hotkey=a '... Automated speech install' {
            set background_color=black
            linux    (loop)/install.amd/vmlinuz auto=true priority=critical vga=788 speakup.synth=soft --- quiet 
            initrd   (loop)/install.amd/gtk/initrd.gz
        }
    }
}
submenu --hotkey=d 'Accessible dark contrast installer menu ...' {
    set menu_color_normal=white/black
    set menu_color_highlight=yellow/black
    set color_normal=white/black
    set color_highlight=yellow/black
    background_image
    set theme=/boot/grub/theme/dark-1-2
    set gfxpayload=keep
    menuentry --hotkey=g '... Graphical install' {
        set background_color=black
        linux    (loop)/install.amd/vmlinuz vga=788 theme=dark --- quiet 
        initrd   (loop)/install.amd/gtk/initrd.gz
    }
    menuentry --hotkey=i '... Install' {
        set background_color=black
        linux    (loop)/install.amd/vmlinuz vga=788 theme=dark --- quiet 
        initrd   (loop)/install.amd/initrd.gz
    }
    submenu --hotkey=a '... Advanced options ...' {
        set menu_color_normal=white/black
        set menu_color_highlight=yellow/black
        set color_normal=white/black
        set color_highlight=yellow/black
        background_image
        set theme=/boot/grub/theme/dark-1-2-1
        set gfxpayload=keep
        menuentry '... Graphical expert install' {
            set background_color=black
            linux    (loop)/install.amd/vmlinuz priority=low vga=788 theme=dark --- 
            initrd   (loop)/install.amd/gtk/initrd.gz
        }
        menuentry '... Graphical rescue mode' {
            set background_color=black
            linux    (loop)/install.amd/vmlinuz vga=788 rescue/enable=true theme=dark --- quiet 
            initrd   (loop)/install.amd/gtk/initrd.gz
        }
        menuentry '... Graphical automated install' {
            set background_color=black
            linux    (loop)/install.amd/vmlinuz auto=true priority=critical vga=788 theme=dark --- quiet 
            initrd   (loop)/install.amd/gtk/initrd.gz
        }
        menuentry --hotkey=x '... Expert install' {
            set background_color=black
            linux    (loop)/install.amd/vmlinuz priority=low vga=788 theme=dark --- 
            initrd   (loop)/install.amd/initrd.gz
        }
        menuentry --hotkey=r '... Rescue mode' {
            set background_color=black
            linux    (loop)/install.amd/vmlinuz vga=788 rescue/enable=true theme=dark --- quiet 
            initrd   (loop)/install.amd/initrd.gz
        }
        menuentry --hotkey=a '... Automated install' {
            set background_color=black
            linux    (loop)/install.amd/vmlinuz auto=true priority=critical vga=788 theme=dark --- quiet 
            initrd   (loop)/install.amd/initrd.gz
        }
    }
}
menuentry --hotkey=s 'Install with speech synthesis' {
    set background_color=black
    linux    (loop)/install.amd/vmlinuz vga=788 speakup.synth=soft --- quiet 
    initrd   (loop)/install.amd/gtk/initrd.gz
}