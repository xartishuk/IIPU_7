require 'green_shoes'

Shoes.app title: 'CD/DVD', width: 520, height: 300 do
  para 'Input folder', margin: 10
  @edit_line = edit_line width: 300, margin: 10
  @add_buttom = button 'Add files', margin: 10
  @burned = button 'Burned', margin: 10
  @write_list = edit_box width: 520, height: 207
  Thread.new do
    loop do
      Dir.chdir('1')
      @write_list.text = `ls`
      Dir.chdir('../')
      sleep 1
    end
  end
  @add_buttom.click do
    now = `pwd`
    `cp "../../#{@edit_line.text}" "#{now.delete("\n")}/1"`
  end
  @burned.click do
    `mkisofs -V "volume_ID" -D -l -L -N -J -R -v -o cdrom.iso ~/IiPY/Laba7/1/`
    `umount /dev/cdrom`
    `cdrecord -dev=/dev/cdrom -v blank=fast`
    `cdrecord -dev=/dev/cdrom -speed=16 -eject -v cdrom.iso`
    `rm -Rf /home/h320r-2/IiPY/Laba7/1`
    `mkdir 1`
    alert('Done!')
  end
