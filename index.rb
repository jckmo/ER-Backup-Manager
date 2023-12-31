require 'fileutils'

FileUtils.cd('../../../AppData/Roaming/EldenRing')
$line = '----------------------------------------------------------------------------------------------------------------------'

class ERBackup
  @@game_file_name = 'ER0000.sl2'
  @@backup_folder = './EldenRingBackup'
  @@hold_folder = './EldenRingBackup/misc/HOLD'
  @@game_folder = './76561199248410024'
  @@options = Dir.entries("#{@@backup_folder}")

  def self.backup_current_file
    #take current file and store it in hold for now
    #create new subfolder in hold folder so no overwrites happen
    #find better way to send backup to a location
    # holds = Array(Dir.entries("#{@@hold_folder}"))
    # last = holds[-1].to_i

    puts $line
    puts "\t SELECT SAVE LOCATION"
    puts $line
    puts @@options
    puts $line
    puts $line
    puts "\n"

    input1 = gets.chomp
    case input1
    when input1
      if Array(@@options).include? input1
        options2 = Dir.entries("#{@@backup_folder}/#{input1}")
        if Array(options2).length == 3
          input2 = options2[2]
          full_path = "#{@@backup_folder}/#{input1}/#{input2}"
          puts "You are about to save the current game file to #{full_path}\nand replace the previous save file in that location. \n\t Continue? (y/n)"

          input3 = gets.chomp
          case input3
          when 'y'
            puts "\n"
            FileUtils.copy_file("#{@@game_folder}/#{@@game_file_name}", "#{full_path}/#{@@game_file_name}")
            puts "#{full_path} saved"
            puts "\n"
          else
            ERBackup.backup_current_file()
          end
        else 
          puts $line
          puts "\t SELECT SAVE LOCATION"
          puts $line
          puts options2
          puts $line
          puts $line
          puts "\n"

          input2 = gets.chomp
          if Array(options2).include? input2
            full_path = "#{@@backup_folder}/#{input1}/#{input2}"
            
            puts "You are about to save the current game file to #{full_path}\nand replace the previous save file in that location. \n\t Continue? (y/n)"
            
            input3 = gets.chomp
            case input3
            when 'y'
              puts "\n"
              FileUtils.copy_file("#{@@game_folder}/#{@@game_file_name}", "#{full_path}/#{@@game_file_name}")
              puts "#{full_path} saved"
              puts "\n"

            else
              ERBackup.backup_current_file()
            end
          elsif input2 == 'exit'
            return nil
          else
            puts 'try again'

            sleep(1.2)
            ERBackup.backup_current_file()
          end
        end
      end
    end
  end

  def self.load_backup(input1, input2, full_path)
    FileUtils.copy_file("#{full_path}/#{@@game_file_name}", "#{@@game_folder}/#{@@game_file_name}")
    File.open("#{@@backup_folder}/misc/Current.txt", 'w') { |file| file.write("#{input1} #{input2}") }
    puts "#{full_path} loaded"
    puts "\n"
    sleep(0.5)
    puts 'Goodbye, please close the window and reopen the program to load a new save'
    sleep(1.5)
    return exit
  end

  def self.start
    puts $line
    puts "\t SELECT BACKUP"
    puts $line
    puts @@options
    puts $line
    puts $line
    puts "\n"

    input1 = gets.chomp
    case input1
    when input1
      if Array(@@options).include? input1
        options2 = Dir.entries("#{@@backup_folder}/#{input1}")
        if Array(options2).length == 3
          input2 = options2[2]
          full_path = "#{@@backup_folder}/#{input1}/#{input2}"
          puts "You are about to save the current game file and replace it with the file at #{full_path}. \n\t Continue? (y/n)"

          input3 = gets.chomp
          case input3
          when 'y'
            ERBackup.backup_current_file()
            ERBackup.load_backup(input1, input2, full_path)
          else
            ERBackup.start()
          end
        else 
          puts $line
          puts "\t SELECT BACKUP"
          puts $line
          puts options2
          puts $line
          puts $line
          puts "\n"

          input2 = gets.chomp
          if Array(options2).include? input2
            puts $line

            full_path = "#{@@backup_folder}/#{input1}/#{input2}"
            puts "You are about to save the current game file and replace it with the file at #{full_path}. \n\t Continue? (y/n)"
            
            input3 = gets.chomp
            case input3
            when 'y'
              puts "\n"

              ERBackup.backup_current_file()
              ERBackup.load_backup(input1, input2, full_path)
              puts "\n"

            else
              ERBackup.start()
            end
          elsif input2 == 'exit'
            return nil
          else
            puts 'try again'

            sleep(1.2)
            ERBackup.start()
          end
        end
      elsif input1 == 'exit'
        return nil
      else
          puts 'try again'

          sleep(1.2)
          ERBackup.start()
      end
    else
    end
  end 
end

current_game = file_data = File.read("./EldenRingBackup/misc/Current.txt").split.join(" ")

puts $line

puts "\nHello! Welcome to ER Backup Manager. Please refer to documentation for desired file structure"
puts "\n\tCurrent: #{current_game}\n\n"
puts "Available commands:\n\n\tERBackup.start() \n\t\t[Full Load/Save Cycle]\n\tERBackup.backup_current_file() \n\t\t[Save Current Game File to Location]"

