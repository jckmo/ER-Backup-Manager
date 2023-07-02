require 'fileutils'

FileUtils.cd('../../../AppData/Roaming/EldenRing')
$line = '------------------------------------------------------------------------------'


class ERBackup
  @@game_file_name = 'ER0000.sl2'
  @@backup_folder = './EldenRingBackup'
  @@hold_folder = './EldenRingBackup/HOLD'
  @@game_folder = './76561199248410024'

  def self.backup_current_file(build_note)
    #take current file and store it in hold for now
    #create new subfolder in hold folder so no overwrites happen
    #find better way to send backup to a location

    holds = Array(Dir.entries("#{@@hold_folder}"))

    last = holds[-1].to_i
    
    FileUtils.mkdir("#{@@hold_folder}/#{last+1}")
    FileUtils.touch("#{@@hold_folder}/#{last+1}/#{@@game_file_name}")
    FileUtils.touch("#{@@hold_folder}/#{last+1}/build_note.txt")

    File.open("#{@@hold_folder}/#{last+1}/build_note.txt", 'w') { |file| file.write(build_note) }
    FileUtils.copy_file("#{@@game_folder}/#{@@game_file_name}", "#{@@hold_folder}/#{last+1}/#{@@game_file_name}")

    puts "#{@@hold_folder}/#{last+1}/#{@@game_file_name} '#{build_note}' saved"
  end



  def self.load_file
    options = Dir.entries("#{@@backup_folder}")


    puts $line
    puts $line
    puts "\t SELECT BACKUP"
    puts $line
    puts options
    puts $line
    puts $line
    puts "\n"

    input1 = gets.chomp
    case input1
      when input1
        if Array(options).include? input1
          options2 = Dir.entries("#{@@backup_folder}/#{input1}")

          puts $line
          puts $line
          puts "\t SELECT BACKUP"
          puts $line
          puts options2
          puts $line
          puts $line
          puts "\n"

          input2 = gets.chomp

          full_path = "#{@@backup_folder}/#{input1}/#{input2}"

          if Array(options2).include? input2
            puts $line
            puts 'Please give a note to be saved with the previous build:'
            build_note = gets.chomp
            puts "You are about to save the current game file and replace it with the file at #{full_path}. \n\t Continue? (y/n)"
            input3 = gets.chomp
            case input3
            when 'y'
              puts "\n"
              ERBackup.backup_current_file(build_note)
              FileUtils.copy_file("#{@@backup_folder}/#{input1}/#{input2}/#{@@game_file_name}", "#{@@game_folder}/#{@@game_file_name}")
              puts "#{full_path} loaded"
              puts "\n"
            else
              ERBackup.load_file()
            end
          elsif input2 == 'exit'
            return nil
          else
            puts 'try again'
            sleep(1.2)
            ERBackup.load_file()
          end
        elsif input1 == 'exit'
          return nil
        else
            puts 'try again'
            sleep(1.2)
            ERBackup.load_file()
        end
      else
    end
  end
end

puts $line
puts "\nHello! Welcome to ER Backup Manager. Please refer to documentation for desired file structure"
puts "\nAvailable Commands: \n\tERBackup.load_file() \n\tERBackup.save_current_file()\n"
puts $line