# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
hospitals = Hospital.create([{ name: 'UN dispensary', latitude: 35.93, longitude: 35.92}])
users = User.create([{ hospital_id: 1, name: "Bob George", phone_number: "123-456-7890", priveledge: 1},
					 { hospital_id: 1, name: "Steve Kowen", phone_number: "325-382-2845", priveledge: 2},
					 { hospital_id: 1, name: "Mike Wizowski", phone_number: "839-942-1938", priveledge: 3}])
copters = Copter.create([{ hospital_id: 1, name: "refugee deliveries", category: "quadcopter", last_latitude: 35.93, last_longitude: 35.92, available: true}])
medicines = Medicine.create([{ hospital_id: 1, name: "aspirin", category: "painkiller", description: "reduces pain and fevers", restricted: false, quantity: 100}])
destinations = Destination.create([{ hospital_id: 1, name: "outpost", description: "on the outskirts of a refugee camp", latitude: 36.0, longitude: 35.90}])
