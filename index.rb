require 'fileutils'

FileUtils.cd('../../../AppData/Roaming/EldenRing')


class ERBackup
  @@game_file_name = 'ER0000.sl2'
  @@backup_folder = './EldenRingBackup'
  @@hold_folder = './EldenRingBackup/HOLD'
  @@game_folder = './76561199248410024'
  @@hold_count = 1

  def self.backup_current_file
    #take current file and store it in hold for now
    #create new subfolder in hold folder so no overwrites happen
    #find better way to send backup to a location

    if File.size("#{@@hold_folder}/#{@@hold_count}/#{@@game_file_name}") > 0 || nil
      #only works in IRB, need to check folder names for most recent number
      @@hold_count += 1

      FileUtils.mkdir("#{@@hold_folder}/#{@@hold_count}")
      FileUtils.touch(@@game_file_name)
    end

    FileUtils.copy_file("#{@@game_folder}/#{@@game_file_name}", "#{@@hold_folder}/#{@@hold_count}/#{@@game_file_name}")
    puts "backup saved to #{@@hold_folder}/#{@@hold_count}/#{@@game_file_name}"
  end



  def self.load_file
    options = Dir.entries("#{@@backup_folder}")
    line = '------------------------------------------------------------------------------'
    puts `clear`


    puts line
    puts line
    puts "\t select backup"
    puts line
    puts options
    puts line
    puts line

    input1 = gets.chomp
    case input1
      when input1
        if Array(options).include? input1
          options2 = Dir.entries("#{@@backup_folder}/#{input1}")
          puts `clear`

          puts line
          puts line
          puts "\t select backup"
          puts line
          puts options2
          puts line
          puts line

          input2 = gets.chomp

          full_path = "#{@@backup_folder}/#{input1}/#{input2}"

          if Array(options2).include? input2
            puts line
            puts "You are about to save the current game file and replace it with the file at #{full_path}. \n\t Continue? (y/n)"
            input3 = gets.chomp
            case input3
            when 'y'
              ERBackup.backup_current_file()

              FileUtils.copy_file("#{@@backup_folder}/#{input1}/#{input2}/#{@@game_file_name}", "#{@@game_folder}/#{@@game_file_name}")
              puts "file at #{full_path} loaded"
            else
              ERBackup.load_file()
            end
          elsif input2 == 'exit'
            puts 'clear'
            return nil
            puts 'clear'
          else
            puts 'try again'
            sleep(1.2)
            ERBackup.load_file()
          end
        elsif input1 == 'exit'
          puts 'clear'
          return nil
          puts 'clear'
        else
            puts 'try again'
            sleep(1.2)
            ERBackup.load_file()
        end
      else
    end
  end
end