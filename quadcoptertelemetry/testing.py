
input = "GLOBAL_POSITION_INT {time_boot_ms : 14095065, lat : 374453678, lon : -1221645883, alt : 50040, relative_alt :18000, vx : 4, vy : 14, vz : 41, hdg : 7622}\nATTITUDE {time_boot_ms : 14095167, roll : -0.0172966849059, pitch : 0.0105280140415, yaw : 1.44681358337, rollspeed : -0.0016581909731, pitchspeed : 0.00157838314772, yawspeed : 0.00787255819887}\nSYS_STATUS {onboard_control_sensors_present : 4294966319, onboard_control_sensors_enabled : 4294945839, onboard_control_sensors_health : 4294966319, load :0, voltage_battery : 11836, current_battery : 14, battery_remaining : 99, drop_rate_comm : 0, errors_comm : 0, errors_count1 : 0, errors_count2 : 0, errors_count3 : 0, errors_count4 : 0}\nVFR_HUD {airspeed : 0.070000000298, groundspeed : 0.070000000298, heading :95, throttle : 0, alt : 1.30999994278, climb : -0.019999999553}\nBATTERY {flightBattery : 80, avionicsBattery : -1}"

jason = [{"lat":37.87355877821156,"lng":-122.27455544445547},{"lat":37.86851108467214,"lng":-122.27777409527334},{"lat":37.86559749341383,"lng":-122.27120804760489},{"lat":37.873016760580036,"lng":-122.26768898937735},{"lat":37.87240698597794,"lng":-122.26129460308584},{"lat":37.86644447949386,"lng":-122.2594492432836},{"lat":37.86488601758327,"lng":-122.26558613750966}]

info_vars = ["lat", "lon", "relative_alt", "roll", "pitch", "yaw", "flightBattery", "avionicsBattery", "voltage_battery", "current_battery", "airspeed", "groundspeed", "heading"]



if __name__ == '__main__':
  import json
  default_height = "50.000000" #CHANGE THIS
  # list = []
  # i = 0
  # toAppend = False
  # for c in jason

  # stringBuilder = []
  # stringBuilder.append("QGC WPL 110\n")
  # index = 0
  # for m in jason:
  #   stringBuilder.append(str(index) + "\t")
  #   if index == 0:
  #     stringBuilder.append("1\t")
  #   else:
  #     stringBuilder.append("0\t")
  #   stringBuilder.append("3\t16\t0.000000\t0.000000\t0.000000\t0.000000\t")
  #   stringBuilder.append(str(m['lat']) + "\t")
  #   stringBuilder.append(str(m['lng']) + "\t")
  #   if index == 0:
  #     stringBuilder.append("0.000000\t1\n")
  #   else:
  #     stringBuilder.append(default_height + "\t1\n")
  #   index += 1
  # file = open ('wp.txt', 'w')
  # mainString = ''.join(stringBuilder)
  # file.write(mainString)
  # file.close()

  # ~~~ REMEMBER THE HOME POINT
  # ~!~!~ NOT SURE IF THIS WORKS IF WE WANT TO CHANGE THE FLIGHT MID PATH! CHECK heights

  #print "lat: " + data['lat']
  #print "lng: " + data['lng']
  everything = dict()
  strings = []
  i = 0
  toAppend = False
  for c in input:
      if c == "{":
          strings.append(", ")
          toAppend = True
      elif c == "}":
          toAppend = False
      elif toAppend == True:
          strings.append(c)
      i += 1
  mainString = ''.join(strings)
  lst = mainString.split(", ")
  for thing in lst:
    print "thing: " + thing
    a = thing.split(":")
    if len(a) == 2: 
      everything[(a[0]).strip()] = (a[1]).strip()
  print everything  
  return_dictionary = dict()
  for a in info_vars:
    print a
    return_dictionary[a] = everything[a]
  print return_dictionary
# returns key value pairs of lat lon alt roll pitch yaw
