#!lua
-- Get the first HDD device (assuming it's hd0)
local dev = "hd0"

-- Set the themes directory on the first HDD
local themes_dir = "/" .. dev .. "/boot/grub/themes/"

-- Function to enumerate files in a directory
function enum_file (name)
  print("enum_file: " .. name)
  command = "export theme_std=(memdisk)/boot/grubfm/themes/" .. name .. "/theme.txt;" .. 
  "export theme_fm=(memdisk)/boot/grubfm/themes/" .. name .. "/fm.txt;" .. 
  "export theme_info=(memdisk)/boot/grubfm/themes/" .. name .. "/info.txt;" .. 
  "export theme_hw_grub=(memdisk)/boot/grubfm/themes/" .. name .. "/hwinfo/grub.txt;" .. 
  "export theme_hw_cpu=(memdisk)/boot/grubfm/themes/" .. name .. "/hwinfo/cpu.txt;" .. 
  "export theme_hw_ram=(memdisk)/boot/grubfm/themes/" .. name .. "/hwinfo/ram.txt;" .. 
  "export theme_hw_board=(memdisk)/boot/grubfm/themes/" .. name .. "/hwinfo/board.txt;" .. 
  "configfile  ${prefix}/settings.sh;"
  print("Adding menu item: " .. name)
  grub.add_icon_menu ("screen", command, name)
end

-- Function to scan for themes in a directory
function scan_themes (dir)
  print("scan_themes: " .. dir)
  -- Iterate through the directories in the given directory
  for file in grub.utils.iter_dir(dir) do
    -- Check if the file is a directory
    if grub.utils.is_dir(file) then
      -- Check if the directory contains a theme.txt file
      if grub.file_exists(file .. "/theme.txt") then
        -- Call the enum_file function to process the theme
        print("Found theme: " .. file)
        enum_file(file:match("(.*)/"))
      end
    end
  end
end

-- Clear the menu
print("Clearing menu")
grub.clear_menu ()

-- Scan for themes in the themes directory on the first HDD
print("Scanning for themes in: " .. themes_dir)
scan_themes(themes_dir)

-- Source the global script
print("Sourcing global.sh")
grub.script ("source ${prefix}/global.sh")
command ("sleep 2")
