require 'csv'
require 'mysql'

$i = 0
$db = Mysql.new('localhost', 'root', 'royals', 'pitchfx_populate')

def read_csv(file)
  CSV.foreach(file) do |row|
    if $i == 0
      $i += 1
      next
    end
    if ($i % 10000) == 0
      puts "Row #{$i} " + row.inspect
    end
    cmd = $db.prepare "INSERT into pitchfx_data (game_date, pitcher_id, inning, top_of_inning, game_atbat_number, pitch_per_atbat, pitch_per_game, pitcher_throws, batter_id, batter_stance, strike_zone_top, strike_zone_bottom, pitch_result, event_code, event_description, pitch_type, pitch_initial_speed, pitch_speed_at_homeplate, pitch_deflection_break_x, pitch_deflection_break_z, pitch_plate_location_x, pitch_plate_location_z, pitch_initial_position_x, pitch_initial_position_z, command_pitch_location_x, command_pitch_location_z, command_mitt_location_x, command_mitt_location_z) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
    cmd.execute(row[0], row[1], row[2], row[3], row[4], row[5], row[6], row[7], row[8], row[9], row[10], row[11], row[12], row[13], row[14], row[15], row[16], row[17], row[18], row[19], row[20], row[21], row[22], row[23], row[24], row[25], row[26], row[27])
    cmd.close
    $i += 1
  end
end


read_csv('commandfx_2014.csv')
